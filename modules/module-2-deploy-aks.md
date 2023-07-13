# Module 2 - Deploy an Azure AKS Cluster

1. Define the environment variables to be used by the resources definition.

   > **NOTE**: In the following sections we'll be generating and setting some environment variables. If you're terminal session restarts you may need to reset these variables. You can use that via the following command:
   >
   > source envLabVars.env

   Start in the root of the repository folder

   ```bash
   cd cc-aks-container-security-workshop
   ```

   ```bash
   export RESOURCE_GROUP=rg-csec-workshop
   export CLUSTERNAME=aks-csec-workshop
   export LOCATION=canadacentral
   # Persist for later sessions in case of disconnection.
   echo export RESOURCE_GROUP=$RESOURCE_GROUP >> envLabVars.env
   echo export CLUSTERNAME=$CLUSTERNAME >> envLabVars.env
   echo export LOCATION=$LOCATION >> envLabVars.env
   ```

2. If not created, create the Resource Group in the desired Region.

   ```bash
   az group create \
     --name $RESOURCE_GROUP \
     --location $LOCATION
   ```

3. Create the AKS cluster without a network plugin.

   ```bash
   az aks create \
     --resource-group $RESOURCE_GROUP \
     --name $CLUSTERNAME \
     --kubernetes-version 1.25 \
     --location $LOCATION \
     --node-count 2 \
     --node-vm-size Standard_B4ms \
     --max-pods 100 \
     --generate-ssh-keys \
     --network-plugin azure
   ```

4. Verify your cluster status. The `ProvisioningState` should be `Succeeded`

   ```bash
   az aks list -o table | grep $CLUSTERNAME
   ```

   Or

   ```bash
   watch az aks list -o table 
   ```

   You may get an output like the following

   <pre>
   Name                                   Location       ResourceGroup                         KubernetesVersion    CurrentKubernetesVersion    ProvisioningState    Fqdn
   -------------------------------------  -------------  ------------------------------------  -------------------  --------------------------  -------------------  -----------------------------------------------------------------------
   kartik-aks-csec-workshop               canadacentral  kartik-rg-csec-workshop               1.25                 1.25.6                      Succeeded            kartik-aks-kartik-rg-csec-w-03cfb8-i568hfhr.hcp.canadacentral.azmk8s.io
      </pre>

5. Get the credentials to connect to the cluster.

   ```bash
   az aks get-credentials --resource-group $RESOURCE_GROUP --name $CLUSTERNAME
   ```

6. Verify you have API access to your new AKS cluster

   ```bash
   kubectl get nodes
   ```

   The output will ne something similar to the this:

   <pre>
    NAME                                STATUS   ROLES   AGE    VERSION
    aks-nodepool1-24664026-vmss000000   Ready    agent   7m1s   v1.25.6
    aks-nodepool1-24664026-vmss000001   Ready    agent   7m4s   v1.25.6
   </pre>

   To see more details about your cluster:

   ```bash
    kubectl cluster-info
   ```

   The output will ne something similar to the this:
   <pre>
    Kubernetes control plane is running at https://aks-shift--rg-shift-left-wo-03cfb8-z5n2y68t.hcp.canadacentral.azmk8s.io:443
    CoreDNS is running at https://aks-shift--rg-shift-left-wo-03cfb8-z5n2y68t.hcp.canadacentral.azmk8s.io:443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
    Metrics-server is running at https://aks-shift--rg-shift-left-wo-03cfb8-z5n2y68t.hcp.canadacentral.azmk8s.io:443/api/v1/namespaces/kube-system/services/https:metrics-server:/proxy

    To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
   </pre>

   You should now have a Kubernetes cluster running with 2 nodes. You do not see the master servers for the cluster because these are managed by Microsoft. The Control Plane services which manage the Kubernetes cluster such as scheduling, API access, configuration data store and object controllers are all provided as services to the nodes.

7. Verify the settings required for Calico Cloud.

   ```bash
   az aks show --resource-group $RESOURCE_GROUP --name $CLUSTERNAME --query 'networkProfile'
   ```

   You should see "networkPlugin": "azure" and "networkPolicy": null (networkPolicy will just not show if it is null).

8. Verify the transparent mode by running the following command in one node

   ```bash
   VMSSGROUP=$(az vmss list --output table | grep -i $RESOURCE_GROUP | awk -F ' ' '{print $2}')
   VMSSNAME=$(az vmss list --output table | grep -i $RESOURCE_GROUP | awk -F ' ' '{print $1}')
   az vmss run-command invoke -g $VMSSGROUP -n $VMSSNAME --scripts "cat /etc/cni/net.d/*" --command-id RunShellScript --instance-id 0 --query 'value[0].message' --output table
   ```

   > output should contain "mode": "transparent"

---

## Enviroment Preparation

### Decrease the time to collect flow logs

By default, flow logs are collected every 5 minutes. We will decrease that time to 15 seconds, which will increase the amount of information we must store, and while that is not recommended for production environments, it will help to speed up the time in which events are seen within Calico observability features.

```bash
kubectl patch felixconfiguration default -p '{"spec":{"flowLogsFlushInterval":"15s"}}'
kubectl patch felixconfiguration default -p '{"spec":{"dnsLogsFlushInterval":"15s"}}'
kubectl patch felixconfiguration default -p '{"spec":{"flowLogsFileAggregationKindForAllowed":1}}'
kubectl patch felixconfiguration default -p '{"spec":{"flowLogsFileAggregationKindForDenied":0}}'
kubectl patch felixconfiguration default -p '{"spec":{"dnsLogsFileAggregationKind":0}}'
```

Configure Felix to collect TCP stats - this uses eBPF TC program and requires miniumum Kernel version of v5.3.0/v4.18.0-193. Further documentation.

```bash
kubectl patch felixconfiguration default -p '{"spec":{"flowLogsCollectTcpStats":true}}'
```

Enable ApplicationLayer Envoy pods to enable L7 stats

```bash
kubectl apply -f manifests/04-applayer.yml
```

### Install demo applications

Deploy the dev app stack

```bash
kubectl apply -f manifests/20-dev-app.yaml
```

Deploy the Online Boutique app stack

```bash
kubectl apply -f manifests/30-kubernetes-manifests.yaml
```

Enable L7 logs for the nginx service

```bash
kubectl annotate svc nginx-svc -n dev projectcalico.org/l7-logging=true
```

---

[:arrow_right: Module 3 - Connect the cluster to Calico Cloud](module-3-connect-calicocloud.md) <br>

[:arrow_left: Module 1 - Getting Started](module-1-getting-started.md)

[:leftwards_arrow_with_hook: Back to Main](../README.md)  
