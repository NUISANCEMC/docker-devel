## NUISANCE Docker Developer

Docker allows NUISANCE to be ran on Windows or Mac machines by easily pulling images from docker hub.
Docker must be installed before using these scripts and root access is required to install it.
- Docker for Mac (https://docs.docker.com/docker-for-mac/install/#download-docker-for-mac)
- Docker for Windows (https://docs.docker.com/engine/installation/)

The NUISANCE Docker Developer image is just a wrapper around your current terminal that makes it behave as if its CentOS7 and lets you navigate a NUISANCE build directory on your current machine.

### Prequisites
To actually run and use NUISANCE you will need the following things installed on your host machine
- Docker : See above for links for this
- ROOT : To analyse NUISANCE outputs graphically you will still need a local installation of ROOT on your host machine. Note this will end up being different to the one used by NUISANCE inside the docker image. Any version of ROOT 5+ should be sufficient as all you need it for is to open standard ROOT files. Pre-compiled binaries for many machines can be found here: https://root.cern.ch/content/release-61008


### Setup Instructions
First, edit the setup.sh script to choose a valid mount point. The Default is set to `$HOME/NUISANCEMC`.
You should choose somewhere you have read/write access as this is where you will be storing the NUISANCE files.
```
[HostOS]$ cd docker
[HostOS]$ emacs -nw setup.sh

# Set docker mounting point (default is $HOME/NUISANCEMC)
# This can be anywhere you have read/write access and will be
# where you save your MC inputs/outputs
export NUISANCE_MOUNT="$HOME/NUISANCEMC/"
```

Next, run the `setup.sh` script to setup your environement
``` 
[HostOS]$ source setup.sh 
Setting up NUISANCE docker developer.

Developer Tag : nuisancemc/nuisancedevel
Version Tag   :
Mount Point   : /Users/patrickstowell/NUISANCEMC/
Mount Options : 
Run Command   : 'nuisancedevel'
```

Next, run the `build.sh` script to pull the developer image and dependencies from docker hub and make the mount point folder if not already created.
```
[HostOS]$ source build.sh
ASDASDAS
```
when all that is finished you should see the message
```
SDASDS
```


Finally, test the docker container actually runs by using the `nuisancedevel` alias. You should be able to see all the files inside your mount point from the starting working directory of the container.
```
[HostOS]$ nuisancedevel
[DevlOS]#
```

### Unpacking NUISANCE 
Now that you have a way to run the nuisance developer image, you can build NUISANCE inside it as if you are on a CentOS machine with all the required system dependencies alraedy installed. Building the required generators + ROOT is quite time consuming however, and it is easier to download and unpack a prebuilt version from our precompiled CentOS binaries.

A handy "unpack" script is provided to do this aswell as recompile NUISANCE-v2r8 for you.

First, we want to copy the NUISANCE "scripts/unpack.sh" script to wherever we want to build NUISANCE, which must be somewhere inside our mount point defined earlier.
```
[HostOS]$ ls
README.md   docker   scripts
[HostOS]$ source docker/setup.sh
Setting up NUISANCE docker developer.

Developer Tag : nuisancemc/nuisancedevel
Version Tag   :
Mount Point   : /Users/patrickstowell/NUISANCEMC/
Mount Options : :cached
Run Command   : 'nuisancedevel'

[HostOS]$ cp scripts/unpack.sh	$NUISANCE_MOUNT/unpack.sh
```

Next, we want to load up the dockerdevel environment and navigate to where we placed the "unpack" script.
```
[HostOS]$ nuisancedevel
[DevlOS]# ls
docker-devel   unpack.sh
```

Running the unpack script should be enough to download everything required
```
[DevlOS]# source unpack.sh
Downloading pre-built NUISANCE-docker-devel tarball to current directory
--2017-11-04 13:31:38--  https://www.dropbox.com/s/jzrpjmi3blweetk/nuisance-v2r8-gcc4.8.5-centos7.tar.gz?dl=0

...

-- The C compiler identification is GNU 4.8.5
-- The CXX compiler identification is GNU 4.8.5
-- Check for working C compiler: /usr/bin/cc
-- Check for working C compiler: /usr/bin/cc -- works

...

[DEBUG]: Configuring directory: src/Smearceptance
[DEBUG]: Module targets: Routines;FCN;expANL;expArgoNeuT;expBEBC;expBNL;expElectron;expFNAL;expGGM;expK2K;expMINERvA;expMiniBooNE;expSciBooNE;expT2K;MCStudies;NuisGenie;FitBase;InputHandler;Splines;Reweight;Utils;Smearceptance
-- Configuring done
-- Generating done
-- Build files have been written to: /Users/patrickstowell/NUISANCEMC/test/nuisance-v2r8-gcc4.8.5-centos7/nuisance-v2r8/build
Scanning dependencies of target Routines
[  1%] Building CXX object src/Routines/CMakeFiles/Routines.dir/ComparisonRoutines.cxx.o
[  1%] Building CXX object src/Routines/CMakeFiles/Routines.dir/SystematicRoutines.cxx.o

...

[100%] Building CXX object src/Tests/CMakeFiles/ParserTests.dir/ParserTests.cxx.o
Linking CXX executable ParserTests
[100%] Built target ParserTests
Scanning dependencies of target SignalDefTests
[100%] Building CXX object src/Tests/CMakeFiles/SignalDefTests.dir/SignalDefTests.cxx.o
Linking CXX executable SignalDefTests
[100%] Built target SignalDefTests

...

-- Installing: /Users/patrickstowell/NUISANCEMC/docker-devel/nuisance-v2r8-gcc4.8.5-centos7/nuisance-v2r8/build/Linux/bin/nuisbayes
-- Installing: /Users/patrickstowell/NUISANCEMC/docker-devel/nuisance-v2r8-gcc4.8.5-centos7/nuisance-v2r8/build/Linux/bin/PrepareGENIE
-- Installing: /Users/patrickstowell/NUISANCEMC/docker-devel/nuisance-v2r8-gcc4.8.5-centos7/nuisance-v2r8/build/Linux/bin/PrepareNuwro
-- Installing: /Users/patrickstowell/NUISANCEMC/docker-devel/nuisance-v2r8-gcc4.8.5-centos7/nuisance-v2r8/build/Linux/tests/SignalDefTests
-- Installing: /Users/patrickstowell/NUISANCEMC/docker-devel/nuisance-v2r8-gcc4.8.5-centos7/nuisance-v2r8/build/Linux/tests/ParserTests
[DevlOS]#
```
If the script managed to get to a stage where each of the build files are installed like the one below, then NUISANCE built successfully.
```
SADSAD
```

With a working NUISANCE build, the "setupnuisance.sh" script located in the original unpacked folder will setup everything required to run NUISANCE after starting up the NUISANCE docker developer image.
```
$ nuisancedevel
[DevlOS]# ls
docker-devel   nuisance-v2r8-gcc4.8.5-centos7   unpack
[DevlOS]# cd nuisance-v2r8-gcc4.8.5-centos7
[DevlOS]# ls
lhapdf  libxml2-install  log4cpp  nuisance-v2r8  pythia6  R-2_12_6  root  scripts  setupnuisance.sh  v11q-reweight
[DevlOS]# source setupnuisance.sh
```

So to test you have a working build run the following commands
```
$ nuisancedevel
[DevlOS]# cd nuisance-v2r8-gcc4.8.5-centos7
[DevlOS]# source setupnuisance.sh
[DevlOS]# nuiscomp -h
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
[DevlOS]#
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
