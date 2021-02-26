# kubectl run an ubuntu container in some namespace
# useful for debugging in certain cases
# usage: kdbug [namespace] [pod-name]
kdbug() {
  kubectl run --namespace $1 -i --rm --tty $2 --image ubuntu:latest -- bash
}

# leverage fzf to provide interactive pod selector
# tail logs of selected pod
# usage: klogs-for [namespace]
klogs-for() {
  local _namespace="default"
  if [[ $# > 0 ]]; then
    _namespace=$1
  fi
  kubectl -n $_namespace logs -f $(kubectl -n $_namespace get pods | fzf | awk '{print $1}')
}

# octant open in cluster + namespace
# usage: octant-for [k8s context] [namespace]
# example: octant-for prod webhooks
octant-for() {
  octant --context=$1 --namespace=$2
}

# usage: yeet [OPTION] RESOURCE
yeet() {
  local _interactive
  local _namespace
  local _resource

  if [[ $# == 0 ]]; then
    echo "err: no args"
    return 1;
  fi

  while (( $# )); do
    case "$1" in
      --interactive|-i)
        _interactive=true
        shift 1
        ;;
      --namespace|-n)
        _namespace=$2
        shift 2
        ;;
      *)
        cat << EOM
usage: $0 [OPTIONS] [RESOURCE]

-i | --interactive    Use interactive search through namespace instead of specifying resource explicitly.
-n | --namespace      Namespace to perform operation in.

example:
$0 -n my-namespace deployment/my-deployment
$0 -n my-namespace --interactive
EOM
        return 0
        ;;
    esac
  done

  if [[ ! -z $_interactive ]] && [[ -z $_namespace ]]; then
    echo "err: interactive mode requested without providing namespace"
    return 1;
  fi

  _resource=$@

  if [[ ! -z $_interactive ]]; then
    # run interactive bits
    _resource=$(kubectl -n $_namespace get all | fzf | awk '{print $1}')
  fi

  # ensure resource is set. this can be done on the command line or through interactive mode
  if [[ -z $_resource ]]; then
    echo "err: resource not set"
    return 1;
  fi

  # do operation
  # danger, here be dragons
  kubectl -n $_namespace del $_resource
}

