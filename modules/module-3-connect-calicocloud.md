# Module 3 - Connect the cluster to Calico Cloud

> **Note**: In order to complete this module, you will need to a [Calico Cloud account](https://www.calicocloud.io/). If you are participating in a live workshop, you will receive an invite with the information to login into an active Calico Cloud environment and join your AKS cluster in there.  
If you are running this workshop in a self-paced mode, you can create an Calico Cloud environment following the steps [here](submodule-3.1-create-calicloud.md).  

Issues with being unable to navigate menus in the UI are often due to browsers blocking scripts - please ensure that you disabled all blocker scripts.

## Step 1 - Accept the Invitation

1. During the workshop, you will receive an invitation to connect to a Calico Cloud organization, just like in the picture below:

2. Click on the link ACCEPT INVITATION and create an password to access the Calico Cloud.

3. Once you have access to your **Calico Cloud** environment, go to step 2:

## Step 2 - Connecting your cluster to Calico Cloud.

1. The welcome screen will allow you to choose among four use cases and will provide a guided tour for each use case. After that you can proceed to connect your first cluster. This option directs you to the **Managed Clusters** section. Click on the "**Connect Cluster**" button to start the process.

   The Connect Cluster window will allow you to choose a name to identify your cluster in Calico Cloud and select which platform you are running the cluster on. The next window presents a link for you to review the cluster requirements for Calico Cloud. A kubectl command to run the installation script will be generated, you need to copy and apply this command in your cluster.

   > **Warning**
   > Please choose a unique name with your alias or username for the cluster name as the workshop uses a shared Calico Cloud instance. 
   > A good example: "cc-aks-myname-workshop"

   ![add-managed-cluster](https://github.com/tigera-solutions/cc-aks-shift-left-workshop/assets/117195889/bef4e5e2-5824-48da-b198-ade0a73ad346)

2. Run the installation script in your cluster. Script should look similar to this:

    <pre>
    kubectl apply -f https://installer.calicocloud.io/manifests/cc-operator/late
    st/deploy.yaml && curl -H "Authorization: Bearer bxkrau8yk:jg3nzzzdm:mmzpsio
    iznns4dugtnszgg17zwbbfw50xxude6i3zzfzpmwyow6j63gu3d5e9ija" "https://www.cali
    cocloud.io/api/managed-cluster/deploy.yaml" | kubectl apply -f -
    </pre>

    > Output should look similar to:
    <pre>
    namespace/calico-cloud created
    customresourcedefinition.apiextensions.k8s.io/installers.operator.calicocloud.io created
    serviceaccount/calico-cloud-controller-manager created
    role.rbac.authorization.k8s.io/calico-cloud-leader-election-role created
    clusterrole.rbac.authorization.k8s.io/calico-cloud-metrics-reader created
    clusterrole.rbac.authorization.k8s.io/calico-cloud-proxy-role created
    rolebinding.rbac.authorization.k8s.io/calico-cloud-leader-election-rolebinding created
    clusterrolebinding.rbac.authorization.k8s.io/calico-cloud-installer-rbac created
    clusterrolebinding.rbac.authorization.k8s.io/calico-cloud-proxy-rolebinding created
    configmap/calico-cloud-manager-config created
    service/calico-cloud-controller-manager-metrics-service created
    deployment.apps/calico-cloud-controller-manager created
    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                    Dload  Upload   Total   Spent    Left  Speed
    100   355  100   355    0     0    541      0 --:--:-- --:--:-- --:--:--   541
    secret/api-key created
    installer.operator.calicocloud.io/aks-cc-repo created
    </pre>

    Joining the cluster to Calico Cloud can take a few minutes. Meanwhile the Calico resources can be monitored until they are all reporting `Available` as `True`

    ```bash
    kubectl get tigerastatus                                                                                                                    
    ```

    > Output should look similar to:
    <pre>
    NAME                            AVAILABLE   PROGRESSING   DEGRADED   SINCE
    apiserver                       True        False         False      96s
    calico                          True        False         False      16s
    compliance                      True        False         False      21s
    intrusion-detection             True        False         False      41s
    log-collector                   True        False         False      21s
    management-cluster-connection   True        False         False      51s
    monitor                         True        False         False      2m1s
    </pre>

    You can also monitor your cluster installation on the Calico Cloud UI. Go to the "**Managed Clusters**" section, select your cluster and expand the timestamp dropdown to see the installation logs.
    In a few minutes the status will change from **Installing** to **Done**. Congratulations! You successfully connected your cluster to Calico Cloud.

    ![monitor-install](https://github.com/tigera-solutions/cc-aks-shift-left-workshop/assets/117195889/978cb58e-85b6-43b0-a32e-90850684e78f)

## STEP 3 - Selecting your cluster.

Once the installation is completed, you will be able to start interacting with your cluster from the Calico Cloud interface. Calico Cloud provides a single pane of glass for managing multiple clusters. If you followed the previous steps, you would have two clusters connected to Calico Cloud at this point: Your cluster and a pre-configured lab cluster that allows you to explore some of the features in Calico Cloud.

You can switch between clusters by following the steps below:

1. Navigate to the Dashboard section - the first icon under the Calico Cat on the top-left of the UI.

2. Click on the **Cluster** dropdown button on the top-right of the UI.

3. Select your recently added cluster.

   ![select-cluster](https://github.com/tigera-solutions/cc-aks-shift-left-workshop/assets/117195889/4b6b5957-bf7c-4373-aa04-2d38f1eb2601)

The "**Cluster**" dropdown button will be always visible accross the Calico Cloud UI, no matter which section you are viewing. You can change the cluster you want to interact with at any moment. 
When you change the cluster, the whole Calico Cloud context will change immediately to reflect the information regarding the current selected cluster.

---

[:arrow_right: Module 4 - Scan Container Images](module-4-scan-images.md)   <br>

[:arrow_left: Module 2 - Deploy an AKS cluster](module-2-deploy-aks.md)

[:leftwards_arrow_with_hook: Back to Main](../README.md)  
