#!/bin/bash

name=${JOB_NAME}
image=$(cat ${WORKSPACE}/IMAGE)
host=${HOST}

echo "Deploying... name:${name}, image:${image}, host: ${HOST}"

rm -rf web.yaml
# cp $(dirname "${BASH_SOURCE[0]}")/template/web.yaml .
cp ${WORKSPACE}/template/web.yaml .
echo "copy success"
sed -i "s,{{name}},${name},g" web.yaml
sed -i "s,{{image}},${image},g" web.yaml
sed -i "s,{{host}},${host},g" web.yaml
echo "ready to apply"
kubectl apply -f web.yaml
echo "apply ok"

cat web.yaml

# Health Check
success=0
count=60
IFS=","
sleep 5
while [ ${count} -gt 0 ]
do
    replicas=$(kubectl get deploy ${name} -o go-template='{{.status.replicas}},{{.status.updatedReplicas}},{{.status.readyReplicas}},{{.status.availableReplicas}}')
    echo "replicas: ${replicas}"
    arr=(${replicas})
    if [ "${arr[0]}" == "${arr[1]}" -a "${arr[1]}" == "${arr[2]}" -a "${arr[2]}" == "${arr[3]}" ];then
        echo "health check success!"
        success=1
        break
    fi
    ((count--))
    sleep 2
done

if [ ${success} -ne 1 ];then
    echo "health check failed!"
    exit 1
fi


