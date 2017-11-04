#!/bin/sh

echo ""
echo "Setting up NUISANCE docker developer."
echo ""

# Set docker client tag (default is nuisancemc/nuisanceclient)
export NUISANCE_DOCKERCLIENT="nuisancemc/nuisancedevel"

# Set docker version tag (default is :latest or blank)
#export NUISANCE_DOCKERVER=":latest"

# Set docker mounting point (default is $HOME/NUISANCEMC)
# This can be anywhere you have read/write access and will be
# where you save your MC inputs/outputs
export NUISANCE_MOUNT="$HOME/NUISANCEMC/"

# Set Mount options. cached is availble to speed things up
# in the Docker for Mac edge version. Leave this commented out
# if you don't understand what it does.
export NUISANCE_MOUNT_OPTIONS=":cached"

echo "Developer Tag : $NUISANCE_DOCKERCLIENT"
echo "Version Tag   : $NUISANCE_DOCKERVER"
echo "Mount Point   : $NUISANCE_MOUNT"
echo "Mount Options : $NUISANCE_MOUNT_OPTIONS"
echo "Run Command   : 'nuisancedevel'"
echo ""

# Standard nuisance devel alias
alias nuisancedevel='docker run -it --rm -v ${NUISANCE_MOUNT}:${NUISANCE_MOUNT}${NUISANCE_MOUNT_OPTIONS} -w $NUISANCE_MOUNT ${NUISANCE_DOCKERCLIENT}${NUISANCE_DOCKERVER} bash'




