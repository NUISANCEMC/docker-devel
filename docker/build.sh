#!/bin/sh
source ./setup.sh
if [ ! -e $NUISANCE_MOUNT ]
then
    echo "Making docker mount point"
    mkdir -v $NUISANCE_MOUNT
fi

echo "Building Docker OS Terminal Wrapper"
docker build ./ -t ${NUISANCE_DOCKERCLIENT}${NUISANCE_DOCKERVER}