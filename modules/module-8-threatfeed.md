# Module 8 - Global Threatfeeds

Calico Cloud integrates with threat intelligence feeds so you can detect when your Kubernetes clusters communicate with suspicious IPs. When communications are detected, an anomaly detection dashboard in the UI shows the full context, including which pod(s) were involved so you can analyze and remediate. You can also use a threat intelligence feed to power a dynamic deny-list, either to or from a specific group of sensitive pods, or your entire cluster.

## Deny workloads to connect to IPs in the SNORT IP Block list

Cisco maintains an updated dynamic IP block list as part of SNORT, and this list can be used as a global threatfeed to regularly pull down updates and then enact a network policy to block egress from pods to these IPs

- Create the threatfeed from the YAML manifest
  
  ```bash
  kubectl create -f manifests/40-snort-ip-block-list.yaml
  ```

- Create the test ```ubuntu``` pod from the YAML manifest
  
  ```bash
  kubectl create -f manifests/42-tf-ubuntu.yaml
  ```

- Test via curl a connection to one of these IPs from the ubuntu pod

  ```bash
  kubectl exec -it tf-ubuntu -- /bin/bash
  ```

  ```bash
  root@tf-ubuntu:/# curl -I https://5.196.58.96
  ```

  The response shows that the IP is reachable but due to SSL CN mismatch we are not connecting securely to it (this is good)

  ```bash
  curl: (60) SSL: no alternative certificate subject name matches target host name '5.196.58.96'
  More details here: https://curl.se/docs/sslcerts.html

  curl failed to verify the legitimacy of the server and therefore could not
  establish a secure connection to it. To learn more about this situation and
  how to fix it, please visit the web page mentioned above.
  ```

- Now apply our global network policy that is acting to deny egress to the block list we have just created

  ```bash
  kubectl create -f 41-tf-gnp.yaml
  ```

- Now exec into the ubuntu pod and try to curl the IP again

  ```bash
  root@tf-ubuntu:/# curl -I -m3 https://5.196.58.96
  curl: (28) Connection timed out after 3001 milliseconds
  ```

  This time around the network policy kicks in and denies the flow. The service graph as well as the flow logs confirms the deny action.

  <img width="1477" alt="Screen Shot 2023-07-13 at 10 23 08 AM" src="https://github.com/tigera-solutions/cc-aks-container-security-workshop/assets/117195889/db02b3be-b16c-4f02-92aa-26a0e7f2b05f">


[:arrow_right: Module 9 - Traffic visualization inside your Kubernetes Cluster](module-9-visibility.md) <br>

[:arrow_left: Module 7 - Runtime security with IDS/IPS using Deep Packet Inspection](module-7-runtimesec.md)

[:leftwards_arrow_with_hook: Back to Main](../README.md)
