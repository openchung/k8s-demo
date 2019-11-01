#!/bin/bash

name=${JOB_NAME}
image=$(cat ${WORKSPACE}/IMAGE)
host=${HOST}

echo "Deploying... name:${name}, image:${image}, host: ${HOST}"

rm -rf web.yaml
#cp $(dirname "${BASH_SOURCE[0]}")/template/web.yaml .
cp ${WORKSPACE}/template/web.yaml .
echo "copy success"
sed -i "s,{{name}},${name},g" web.yaml
sed -i "s,{{image}},${image},g" web.yaml
sed -i "s,{{host}},${host},g" web.yaml
echo "ready to apply"
kubectl apply -f web.yaml
echo "apply ok"
cat web.yaml
