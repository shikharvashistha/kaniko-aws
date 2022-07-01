#!/bin/bash
set -e

if [ $# -lt 3 ]; then
    echo "Usage Example: ./kaniko.sh /workspace/Dockerfile /home/shikhar/ xxxxxxxxxx.dkr.ecr.ap-xxx-1.amazonaws.com/bitnami/spark"
    exit 1
fi

dockerfile=$1
context=$2
destination=$3

cache="false"
if [[ ! -z "$4" ]]; then
    cache=$4
fi

 docker run \
        -v "$context":/workspace \
        -v "$HOME/.aws":/root/.aws \
        gcr.io/kaniko-project/executor:latest \
        --dockerfile "${dockerfile}" --destination "${destination}" --context dir:///workspace/ \
        --cache="${cache}"
