#!/bin/bash

# check license.xml
LICENSE=res/license.xml
if ! [[ -f "$LICENSE" ]]; then
    echo "----------$LICENSE not exists.----------"
    exit -1
fi

# check tibero.tar.gz
TIBERO=res/tibero.tar.gz
if ! [[ -f "$TIBERO" ]]; then
    echo "----------$TIBERO not exists.----------"
    exit -1
fi

# check image name 
IMAGE_NAME="tibero-image-builder-out"
if [ $# -gt 1 ]; then
  echo "---------!Only one argument is needed!--------"
  exit -1
elif [ $# -eq 1 ]; then
  IMAGE_NAME=$1
fi

echo "tibero image will be built under the name '${IMAGE_NAME}'"

echo '------------------------------------------------------------------'

# parse license file
HOSTNAME_IDENTIFIER="identified_by_host"
HOSTNAME_LINE=$(egrep -o '<identified_by_host>.*</identified_by_host>' $LICENSE) 
_HOSTNAME=$(echo "$HOSTNAME_LINE" | sed 's/<[^>]*>//g')
echo "host name is '$_HOSTNAME'"

docker buildx build --build-arg "BUILDKIT_SANDBOX_HOSTNAME=$_HOSTNAME" --progress=plain --output type=docker -t $IMAGE_NAME .
