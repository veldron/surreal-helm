<!-- This is a readme file for surrealdb -->

## Suureal Helm Chart

This chart is meant to install Surrealdb on a Kubernetes cluster.

This repo was cloned from https://gitlab.com/karpfediem/surrealdb-helm

## Prerequisites

1. Helm 3 
2. Kubernetes cluster
3. tidb-operator installed on the cluster
    To use this chart, you must first install the `tidb-operator` chart from PingCAP:
    ```bash
    helm repo add pingcap https://charts.pingcap.org/
    ```


### Values for this chart

```yaml
surrealdb:
  user: root #Username 
  pass: root #Password
  ingress:
    enabled: false
    annotations:
      kubernetes.io/ingress.class: nginx
      cert-manager.io/cluster-issuer: letsencrypt-prod
    host: ~

tikv:
  name: surreal-tikv # name name of tikv cluster
  storage: 10Gi # storage size for tikv
replicas:
  tidb:
    pd: 3 # number of pd replicas
    tikv: 3 # number of tikv replicas
  surrealdb: 3 # number of surrealdb replicas
```
## Installing the Chart

1. Clone this repo
2. Run `helm install surrealdb ./ -n surrealdb --create-namespace`
3. Adding parameters you might need: `helm install surrealdb surrealdb-helm/ --set surrealdb.ingress.enabled=true --set surrealdb.ingress.host=surrealdb.example.com --set surrealdb.user=example --set surrealdb.pass=example --set tikv.storage=20Gi --set replicas.tidb.pd=5 --set replicas.tidb.tikv=5 --set replicas.surrealdb=5 -n surrealdb --create-namespace`