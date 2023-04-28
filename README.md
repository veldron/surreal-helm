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



## Values for chart

```yaml
hooks:
  post-install:
    enabled: true # don't change, use it to copy the secret to your web application namespace
appName: surrealdb
targetNamespace: my-app # namespace where the secret will be copied to, useful in your web application namespace
surrealdb:
  secretFileName: surrealdb-secret
  # user: root # optional, the chart will generate random user if not set
  # password: root # optional, the chart will generate random password if not set
  image:
    tag: latest # optional, default to latest
  logging:
    level: trace # optional, default to info
  ingress:
    enabled: false # optional, default to false
    annotations:
      kubernetes.io/ingress.class: nginx # optional, default to nginx
      cert-manager.io/cluster-issuer: letsencrypt-prod # optional, cert-manager cluster issuer name
    host: ~
  resources:
    limits:
      cpu: 100m
      memory: 256Mi
    requests:
      cpu: 50m
      memory: 64Mi

tikv:
  name: surreal-tikv
  storage: 1Gi # optional, default to 1Gi storage for tikv data
  resources:
    limits:
      cpu: 1000m
      memory: 2Gi
    requests:
      cpu: 500m
      memory: 1Gi
  storageClassName: standard # optional, default to standard, tested with longhorn and standard, 
replicas:
  tidb:
    pd: 3 # optional, default to 3
    tikv: 3 # optional, default to 3
  surrealdb: 2 # optional, default to 2

```
## Installing the Chart

1. Clone this repo
2. Run `helm install surrealdb ./ -n surrealdb --create-namespace`
3. Adding parameters you might need: `helm install surrealdb surrealdb-helm/ --set surrealdb.ingress.enabled=true --set surrealdb.ingress.host=surrealdb.example.com --set surrealdb.user=example --set surrealdb.pass=example --set tikv.storage=20Gi --set replicas.tidb.pd=5 --set replicas.tidb.tikv=5 --set replicas.surrealdb=5 -n surrealdb --create-namespace`