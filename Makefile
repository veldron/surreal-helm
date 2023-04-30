.PHONY: install-tidb-operator install-tikv-cluster

install-tidb-operator:
	kubectl create namespace tidb-admin || true
	kubectl create -f https://raw.githubusercontent.com/pingcap/tidb-operator/master/manifests/crd.yaml || true
	helm repo add pingcap https://charts.pingcap.org/ || true
	helm install --namespace tidb-admin tidb-operator pingcap/tidb-operator --version v1.4.4

install-tikv-cluster:
	kubectl create namespace tikv-cluster || true
	cat tikv-only-cluster.yaml | kubectl apply -n tikv-cluster -f -

install_surreal_db:
	kubectl create namespace surrealdb || true
	cat surrealdb_deploy.yaml | kubectl apply -n surrealdb -f -