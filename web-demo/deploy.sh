#!/bin/bash

name=${JOB_NAME}
image=$(cat ${WORKSPACE}/IMAGE)
host=${HOST}

echo "Deploying... name:${name}, image:${image}, host: ${HOST}"

rm -rf web.yaml
cp $(dirname "${BASH_SOURCE[0]}")/template/web.yaml .

sed -i "s,{{name}},${name},g" web.yaml
sed -i "s,{{image}},${image},g" web.yaml
sed -i "s,{{host}},${host},g" web.yaml

kubectl apply -f web.yaml
cat web.yaml
