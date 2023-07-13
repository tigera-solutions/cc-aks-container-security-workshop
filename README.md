# Microsoft Azure: Hands-on AKS workshop </br> Shift-left security with Vulnerability Management in AKS and Calico Cloud

## Welcome

Enterprises developing compliant cloud-native applications have two primary needs. First, they must secure and govern access to containerized workloads and the Kubernetes environment. Second, they need to simplify audit logging and compliance reporting. The Kubernetes environment is dynamic and distributed, and workloads are ephemeral, making it difficult to enforce compliance controls and provide continuous reporting.

This repo intends to guide you step-by-step on creating an Azure AKS cluster, registering the cluster on Calico Cloud and securing your cloud-native applications. Although Calico Cloud has many functionalities and security components, this workshop will explore only a few security features used to protect your workload in runtime and deployment time.

## Time Requirements

The estimated time to complete this workshop is 90-120 minutes.

## Target Audience

- Cloud Professionals
- DevSecOps Professional
- Site Reliability Engineers (SRE)
- Solutions Architects
- Anyone interested in Calico Cloud :)

## Learning Objectives

Learn how to:

- **Scan container images** and **block deployment** based on your security criteria during build time.
- Preview and **enforce security policies** to protect vulnerable workloads.
- Implement **zero-trust access controls** to prevent egress and lateral movement during runtime.
- Implement **runtime security** with IDS/IPS and malware detection.
- Implement **global threatfeeds** to prevent communication to known bad IPs and domains
- Get **visibility** into Kubernetes cluster traffic to **troubleshoot** and **improve security**.

## Modules

This workshop is organized in sequential modules. One module will build up on top of the previous module, so please, follow the order as proposed below.

Module 1 - [Getting Started](modules/module-1-getting-started.md)</br>
Module 2 - [Deploy an AKS cluster](modules/module-2-deploy-aks.md)</br>
Module 3 - [Connect the cluster to Calico Cloud](modules/module-3-connect-calicocloud.md)</br>
Module 4 - [Scan Container Images](modules/module-4-scan-images.md)</br>
Module 5 - [Calico Cloud Admission Controller](modules/module-5-admission-controller.md)</br>
Module 6 - [Zero-trust access control using identity-aware microsegmentation](modules/module-6-zerotrust.md)</br>
Module 7 - [Runtime security with IDS/IPS using Deep Packet Inspection](modules/module-7-runtimesec.md)</br>
Module 8 - [Enabling End to End Encryption with WireGuard](modules/module-8-threatfeed.md)</br>
Module 9 - [Traffic visualization inside your Kubernetes Cluster](modules/module-9-visibility.md)</br>
Module 10 - [Clean up](modules/module-10-cleanup.md)</br>

---

### Useful links

- [Project Calico](https://www.tigera.io/project-calico/)
- [Calico Academy - Get Calico Certified!](https://academy.tigera.io/)
- [O’REILLY EBOOK: Kubernetes security and observability](https://www.tigera.io/lp/kubernetes-security-and-observability-ebook)
- [Calico Users - Slack](https://slack.projectcalico.org/)

**Follow us on social media**

- [LinkedIn](https://www.linkedin.com/company/tigera/)
- [Twitter](https://twitter.com/tigeraio)
- [YouTube](https://www.youtube.com/channel/UC8uN3yhpeBeerGNwDiQbcgw/)
- [Slack](https://calicousers.slack.com/)
- [Github](https://github.com/tigera-solutions/)
- [Discuss](https://discuss.projectcalico.tigera.io/)

> **Note**: The workshop provides examples and sample code as instructional content for you to consume. These examples will help you understand how to configure Calico Cloud and build a functional solution. Please note that these examples are not suitable for use in production environments.
