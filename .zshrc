
# Docker Helper Alias
function dnames-fn {
	for ID in `docker ps | awk '{print $1}' | grep -v 'CONTAINER'`
	do
    	docker inspect $ID | grep Name | head -1 | awk '{print $2}' | sed 's/,//g' | sed 's%/%%g' | sed 's/"//g'
	done
}

function dip-fn {
    OUT='CONTAINER_NAME\tIP_ADDRESS\tNETWORK\n'
    for DOC in `dnames-fn`
    do
        NW=`docker inspect $DOC -f "{{json .NetworkSettings.Networks }}" | cut -d '"' -f 2 | tr -d "\n"`
        IP=`docker inspect $DOC | grep -m3 IPAddress | cut -d '"' -f 4 | tr -d "\n"`
        OUT+=$DOC'\t'$IP'\t'$NW'\n'
    done
    echo $OUT|column -t
}

dnet(){
  docker inspect "$1" -f "{{json .NetworkSettings.Networks }}"
}
dnet(){
  docker inspect "$1" -f "{{json .NetworkSettings.Networks }}"
}

function dex-fn {
	docker exec -it $1 ${2:-bash}
}

function dc-fn {
        docker-compose $*
}

function dlab {
       docker ps --filter="label=$1" --format="{{.ID}}"
}

function drun-fn {
	docker run -it $1 $2
}

function dl-fn {
	docker logs -f $1
}

#Docker Alias
alias dc=dc-fn
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dkill="docker kill"
alias dnames=dnames-fn
alias dip=dip-fn
alias dex=dex-fn
alias dcu="docker-compose up -d"
alias dcd="docker-compose down"
alias drun=drun-fn
alias dsp="docker system prune --all"
alias dl=dl-fn



function kex-fn {
  kubectl exec --stdin --tty $1 -- ${2:-/bin/bash}
}

#Kubectl Alias
alias kgp="kubectl get pod"
alias kgs="kubectl get service"
alias kgd="kubectl get deployment"
alias kgn="kubectl get node"
alias kgns="kubectl get namespaces"
alias kgr="kubectl get replicasets"
alias kga="kubectl get all,ingress"
alias kgi="kubectl get ingress"
alias kedit="kubectl edit"
alias kdes="kubectl describe"
alias kex=kex-fn
alias kdela="kubectl delete all --all"
alias kdel="kubectl delete"
alias kcg="kubectl config get-contexts"
alias kaws="kubectl config use-context PUT-YOUR-AWS-ARN>/<NAMESSPACE>"
alias kdocker="kubectl config use-context docker-desktop"
alias kminikube="kubectl config use-context minikube"
alias klog="kubectl logs -f"
alias kpatch="kubectl patch ingress -n airport-wp-staging -p '{"metadata":{"finalizers":[]}}' --type=merge"


#Helm Alias
alias hdryrun="helm install --generate-name --dry-run --debug"
alias hrun="helm install --generate-name --debug"
alias htmpl="helm template"
