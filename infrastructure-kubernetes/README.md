# Kubernetes Infrastructure

You can deploy this example to any compatiable Kubernetes cluster, but the following instructions
are provided to assist in setting up a local cluster that is certain to be compatible.

## Target environment

* Ubuntu 18.04 (`lsb_release -a`)
* Docker CE version 19.03.6 (`docker -v`)
* MicroK8s providing:
** Kubernetes Client v1.17.3 (`kubectl version`)
** Kubernetes Server v1.17.2 (`kubectl version`)

## Setting up environment

Starting from a machine with a fresh copy of Ubuntu 18.04:

### MicroK8s

1. Install `MicroK8s` following these instructions: https://microk8s.io/docs/
2. Enable the following addons: `dns, storage, registry, helm, ingress, dashboard`.
3. Check status of addons `microk8s.status --wait-ready`.

### Docker CE

See: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04



```
microk8s.enable dns
microk8s.enable storage
microk8s.enable registry
microk8s.enable helm
microk8s.enable ingress
microk8s.enable dashboard
```