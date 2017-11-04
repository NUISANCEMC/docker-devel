## NUISANCE Docker Developer

Docker allows NUISANCE to be ran on Windows or Mac machines by easily pulling images from docker hub.
Docker must be installed before using these scripts and root access is required to install it.
- Docker for Mac (https://docs.docker.com/docker-for-mac/install/#download-docker-for-mac)
- Docker for Windows (https://docs.docker.com/engine/installation/)

The NUISANCE Docker Developer image is just a wrapper around your current terminal that makes it behave as if its CentOS7 and lets you navigate a NUISANCE build directory on your current machine.

### Setup Instructions
First, edit the setup.sh script to choose a valid mount point. The Default is set to `$HOME/NUISANCEMC`.
You should choose somewhere you have read/write access as this is where you will be storing MC files for the nuisance client.
```
$ cd docker
$ emacs -nw setup.sh

# Set docker mounting point (default is $HOME/NUISANCEMC)
# This can be anywhere you have read/write access and will be
# where you save your MC inputs/outputs
export NUISANCE_MOUNT="$HOME/NUISANCEMC/"
```

Next, run the `setup.sh` script to setup environement
``` 
$ source setup.sh 
Setting up NUISANCE docker developer.

Developer Tag : nuisancemc/nuisancedevel
Version Tag   :
Mount Point   : /Users/patrickstowell/NUISANCEMC/
Mount Options : :cached
Run Command   : 'nuisancedevel'
```

Next, run the `build.sh` script to pull the devel image from docker hub and make the mount point folder if not already created.
```
$ source build.sh
Pulling docker image from docker hub
docker pull nuisancemc/nuisancedevel:latest
latest: Pulling from nuisancemc/nuisancedevel
d9aaf4d82f24: Pull complete
87c609607de1: Downloading [=====================>                             ]  79.99MB/188.8MB
d4767c61d4c8: Downloading [=============================>                     ]  92.96MB/159MB
2b6b5241c396: Download complete
a2555975cf39: Download complete
f452462d594d: Downloading [===============>                                   ]   11.3MB/37.02MB
a198305d6741: Waiting
```
wait for the images to be downloaded, until eventually all downloads and extractions are complete.
```
$ source build.sh
Pulling docker image from docker hub
docker pull nuisancemc/nuisancedevel:latest
latest: Pulling from nuisancemc/nuisancedevel
d9aaf4d82f24: Pull complete
87c609607de1: Pull complete
d4767c61d4c8: Pull complete
2b6b5241c396: Pull complete
a2555975cf39: Pull complete
f452462d594d: Pull complete
a198305d6741: Pull complete
Digest: sha256:1f7fd2e4e53d0177f36689221940976d1e0da88db1a0e00a4747dfb67ee59ea6
Status: Downloaded newer image for nuisancemc/nuisancedevel:latest
```

Finally, test the docker container actually runs by using the `nuisancedevel` alias. You should be able to see all the files inside your mount point from the starting working directory of the container and nuisance should already be setup.
```
$ nuisancedevel
[root@dea96e00379d NUISANCEMC]#
```

### Unpacking NUISANCE 
Now that you have a way to run the nuisance developer image, you can build NUISANCE as if you are on a CentOS machine with all the required system dependencies alraedy installed. Building the required generators + ROOT is quite time consuming however, and it is easier to download and unpack a prebuilt version from our precompiled CentOS binaries.

A handy "unpack" script is provided to do this aswell as recompile NUISANCE-v2r8 for you.

First, we want to copy the NUISANCE "scripts/unpack.sh" script to wherever we want to build NUISANCE, which must be somewhere inside our mount point defined earlier.
```
$ ls
README.md   docker   scripts
$ source docker/setup.sh
Setting up NUISANCE docker developer.

Developer Tag : nuisancemc/nuisancedevel
Version Tag   :
Mount Point   : /Users/patrickstowell/NUISANCEMC/
Mount Options : :cached
Run Command   : 'nuisancedevel'

$ cp scripts/unpack.sh	$NUISANCE_MOUNT/unpack.sh
```

Next, we want to load up the dockerdevel environment and navigate to where we placed the "unpack" script.
```
$ nuisancedevel
[root@dea96e00379d NUISANCEMC]# ls
docker-devel   unpack.sh
```

Running the unpack script should be enough to download everything required
```
[root@dea96e00379d NUISANCEMC]# source unpack.sh
Downloading pre-built NUISANCE-docker-devel tarball to current directory
--2017-11-04 13:31:38--  https://www.dropbox.com/s/jzrpjmi3blweetk/nuisance-v2r8-gcc4.8.5-centos7.tar.gz?dl=0

...

```



### Run Instructions
First setup the docker-devel environement by sourcing the setup.sh script.
```
$ source setup.sh
Setting up NUISANCE docker devel.

Devel Tag    : nuisancemc/nuisancedevel
Version Tag   : :latest
Mount Point   : /Users/patrickstowell/NUISANCEMC/
Mount Options :
Run Command   : 'nuisancedevel'
```
To use the docker container you should place any files required inside the $NUISANCE_MOUNT point you defined in the setup script before you run the container.
```
$ cp mygeniefile.root $NUISANCE_MOUNT/
```
Once you are happy that the required files are located in that folder you can run the container using the alias
```
$ nuisancedevel
[INFO]: Adding NuWro library paths to the environment.
[INFO]: Adding PYTHIA6 library paths to the environment.
[INFO]: Adding GENIE paths to the environment.
[root@dea96e00379d NUISANCEMC]#
```
You should be able to see the files you copied to the $NUISANCE_MOUNT area.
```
$ ls $PWD/*.root
/Users/patrickstowell/NUISANCEMC/mygeniefile.root
```
NUISANCE is already setup when you log in so you can use any of the standard applications.
```
$ which nuiscomp 
/NUISANCEMC/nuisance/v2r6/build/Linux/bin/nuiscomp
$ nuisflat -i GENIE:mygeniefile.root -n 100000 -f GenericFlux -o flatgeniefile.root
```


## Linux docker
If docker is installed on your Linux machine it is possible to pull and run these images provided you replace 
```
docker
```
with
```
sudo docker
```

However, we recommend that instead you either build nuisance locally or try to obtain one of our binaries for your build system to avoid docker altogether given that NUISANCE is designed to build on Linux systems.
