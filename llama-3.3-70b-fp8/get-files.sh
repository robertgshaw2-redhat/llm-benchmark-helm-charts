OUT_PATH=$1
NAMESPACE=$2

export files=$(kubectl exec -n $NAMESPACE interactive-pod -- sh -c 'ls /app/*.json')
for f in $files; do
    base=$(basename "$f")
    kubectl cp -n $NAMESPACE interactive-pod:"$f" "./$OUT_PATH/$base"
    echo "got: ./$OUT_PATH/$base"
done