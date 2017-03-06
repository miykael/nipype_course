# Docker Image for a Nipype Course

This Docker image provides a Linux environment with functioning Python, Nipype, FSL, AFNI, ANTs and SPM12 software package, some example data and tutorial notebooks to learn Nipype. The Dockerfile that creates this tutorial environment can be found here: [github.com/miykael/nipype_course](https://github.com/miykael/nipype_course). It's **important** to mention, that you don't need docker to run Nipype on your system. We only use it for the purpose of this tutorial to make sure that all user have the exact same environment.


# The Notebooks

The notebooks for this tutorial are from the [Nipype Tutorial](https://github.com/miykael/nipype_tutorial). You can check out all the notebooks online on [this homepage](https://miykael.github.io/nipype_tutorial/), if you don't want to download and run the whole docker image yourself.


# How to start the Docker image

## Install Docker

Before you can do anything, you first need to install [Docker](https://www.docker.com) on your system. The installation process differes per system. Luckily, the docker homepage has nice instructions for...

 - [Ubuntu](https://docs.docker.com/engine/installation/linux/ubuntu/) or [Debian](https://docs.docker.com/engine/installation/linux/debian/)
 - [Windows 7/8/9/10](https://docs.docker.com/toolbox/toolbox_install_windows/) or [Windows 10Pro](https://docs.docker.com/docker-for-windows/install/)
 - [OS X (from El Capitan 10.11 on)](https://docs.docker.com/docker-for-mac/install/) or [OS X (before El Capitan 10.11)](https://docs.docker.com/toolbox/toolbox_install_mac/).

Once Docker is installed, open up the docker terminal and test if it works with the command:

    docker run hello-world

**Note:** Mac and Linux users might need to use ``sudo`` to run ``docker`` commands.


## Run Docker Image ``miykael/nipype_course``

Getting the docker image for this course to run on your system differs between systems.

### Ubuntu

Running a docker image on Ubuntu is basically very simple. Just open a new terminal and type:

    docker run -ti --rm -p 8888:8888 miykael/nipype_course

Once the docker image is downloaded, open the shown URL link in your browser and you are good to go. The URL will look something like:

    http://localhost:8888/?token=0312c1ef3b61d7a44ff5346d3d150c23249a548850e13868

**BUT**, it is highly recommended to use the `-v` flag so that you have a folder on your system, that you can also access within the docker image. For this, first create a folder, for example called `results`. Now, use the absolute path of this folder in the docker command above s follows:

    docker run -ti --rm -p 8888:8888 -v "/home/username/results:/output" miykael/nipype_course

**Side Note**: You can also get into the docker image and use ``bash`` or ``ipython`` by adding it to the end of your command, i.e.

    docker run -it --rm -v "/home/username/results:/output" miykael/nipype_course bash


### Mac

Sorry, I didn't test it yet on a OS X system, but my guess is that it will be very much like on Ubuntu.


### Windows

Running a docker image on Windows is a bit trickier than on Ubuntu. Assuming you've installed the DockerToolbox, open the Docker Quickstart Terminal. Once everythinig is ready (and you see the whale), we can prepare the system:

1. Check the IP address of your system with the command:

    ``docker-machine ip``

   In my case, this returned ``192.168.99.100``

2. Create a new folder that we can use as an input and output folder to send data from Windows into the docker image and vice versa. You can create the folder either in the explorer as usual or do it with the command ``mkdir -p`` in the docker console. For example like this:

    ``mkdir -p /c/Users/username/results``

    Please replace ``username`` with the name of the current user on your system.


3. Now, we're good to go. Just put the path of your output folder after the ``-v`` flag:

    ``docker run -ti --rm -p 8888:8888 -v /c/Users/username/results:/output miykael/nipype_course``

4. Now, as a final step. Copy the shown URL from the docker command, and replace at the beginning ``localhost`` with the IP address of your docker machine. You should end up with something like this:

    ``http://192.168.99.100:8888/?token=0312c1ef3b61d7a44ff5346d3d150c23249a548850e13868``


**Side Note**: (1) Pay attention, that the folder paths in the docker terminal are not backslash (``\``) as we usually have in Windows. Also, you have to use ``/c/`` instead of ``C:\``.
(2) You can also get into the docker image and use ``bash`` or ``ipython`` by adding it to the end of your command, i.e.

    docker run -it --rm -v /c/Users/username/results:/output miykael/nipype_course bash


# The Dataset

The data used for this tutorial is from [openfmri.org](https://openfmri.org/) and is structured according the new and fancy [Brain Imaging Data Structure (BIDS)](http://bids.neuroimaging.io/).

The dataset ds102 used for this tutorial was shortened to only three subjects, *sub-01*, *sub-02*, *sub-03* *sub-04* and *sub-05*. For more information about the dataset, see the [description on openfmri.org](https://openfmri.org/dataset/ds000102/).


# Feedback, Help & Support

If you want to help with this tutorial or have any questions, fell free to fork the repo of the [Notebooks](https://github.com/miykael/nipype_tutorial) or [this course](https://github.com/miykael/nipype_course). If you have any questions or found a problem, open a new issue for the [Notebooks](https://github.com/miykael/nipype_course/issues) or the [course](https://github.com/miykael/nipype_course/issues).


# License

This Dockerfile is based on the dockerfiles ``crn_base`` and ``crn_nipype`` from the ([Poldrack Lab](https://github.com/poldracklab/crn_base)), the dockerfiles from ([NeuroVault](https://github.com/NeuroVault/NeuroVault)), the dockerfile biss2016-notebook from [Oscar Esteban](https://hub.docker.com/u/oesteban), the dockerfile under ([github.com/BIDS-Apps/dockerfile-templates](https://github.com/BIDS-Apps/dockerfile-templates)) and the dockerfile under ([github.com/Neurita/neuro_docker](https://github.com/Neurita/neuro_docker)).

The jupyter notebook foundation is based on [jupyter/docker-stacks](https://github.com/jupyter/docker-stacks)'s base-, minimal- and scipy-notebook.

This means that the same copyrights apply to this Dockerfile, as they do for the above mentioned content. For more information see: [github.com/miykael/nipype_env](https://github.com/miykael/nipype_env).
