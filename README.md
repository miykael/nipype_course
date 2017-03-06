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

Once Docker is installed, open up the docker terminal and test it works with the command:

    docker run hello-world

**Note:** Mac and Linux users might need to use ``sudo`` to run ``docker`` commands.

## How to run ``miykael/nipype_course``

After installing docker on your system and making sure that the ``hello-world`` example was running, we are good to go to start the Nipype Course image. The exact implementation is a bit different for Windows user, but the general command looks as follows:

    docker run -ti --rm -p 8888:8888 -v /home/username/results:/output miykael/nipype_course

But what do those flags mean?

- The ``-ti`` flag tells docker that it should open an interactive container instance.
- The ``--rm`` flag tells docker that the container should automatically be removed after we close docker.
- The ``-p`` flag specifies which port we want to make available for docker.
- The ``-v`` flag tells docker which folder (here: ``/home/username/results`` it should mount to make it accesible inside the container. The second part of the ``-v`` flag (here: ``/output``) specifies under which path the mounted folder can be found inside the container. This means that we can use the folder ``/output`` inside the tutorial to save data outside the docker container under ``/home/username/results``. **Important**: To use the ``results`` folder, you first need to create it on your system!
- The last argument ``miykael/nipype_course`` tells docker that we want to run this docker image.

To run a docker image, docker will look for the specified image on [Docker Hub](https://hub.docker.com/r/miykael/nipype_course/). If the docker image was already download to your system, it will be directly opened. Otherwise, it first needs to download all containers, which might take some time.


### Run a docker image on Linux or Mac

Running a docker image on a Linux or Mac OS is very simple. Make sure that you've created a results folder on your system (e.g. ``mkdir -p /home/username/results``). Then just open a new terminal and use the command from above:

    docker run -ti --rm -p 8888:8888 -v /home/username/results:/output miykael/nipype_course

Once the docker image is downloaded, open the shown URL link in your browser and you are good to go. The URL will look something like:

    http://localhost:8888/?token=0312c1ef3b61d7a44ff5346d3d150c23249a548850e13868


### Run a docker image on Windows

Running a docker image on Windows is a bit trickier than on Ubuntu. Assuming you've installed the DockerToolbox, open the Docker Quickstart Terminal (encircled in red).

<center><img src="https://raw.githubusercontent.com/miykael/nipype_tutorial/master/static/images/docker_terminal.png" width=600></center>

Once the docker terminal is ready (when you see the whale), we can execute the following steps (see also figure):

1. We need to check the IP adress of your docker machine. For this, use the command:

    ``docker-machine ip``

   In my case, this returned ``192.168.99.100``

2. If you haven't already created a new folder to store your container output into, do so. You can create the folder either in the explorer as usual or do it with the command ``mkdir -p`` in the docker console. For example like this:

    ``mkdir -p /c/Users/username/results``

    Please replace ``username`` with the name of the current user on your system. **Pay attention** that the folder paths in the docker terminal are not backslash (``\``) as we usually have in Windows. Also, ``C:\`` needs to be specified as ``/c/``.

3. Now, we can open run the container with the command from above:

    ``docker run -ti --rm -p 8888:8888 -v /c/Users/username/outputs:/output miykael/nipype_course``

4. Once the docker image is downloaded, it will show you an URL that looks something like this:

    ``http://localhost:8888/?token=0312c1ef3b61d7a44ff5346d3d150c23249a548850e13868``

    This URL will not work on a Windows system. To make it work, you need to replace the string ``localhost`` with the IP address of your docker machine, that we acquired under step 1. Afterwards, your URL should look something like this:

    ``http://192.168.99.100:8888/?token=0312c1ef3b61d7a44ff5346d3d150c23249a548850e13868``

    Copy this link into your webbrowser and you're good to go!


## Docker tips and tricks

### Access Docker Container with ``bash`` or ``ipython``

You don't have to open a jupyter notebook when you run ``miykael/nipype_course``. You can also access the docker container directly with ``bash`` or ``ipython`` by adding it to the end of your command, i.e.:

    docker run -ti --rm -v /home/username/results:/output miykael/nipype_course bash

This also works with other software commands, such as ``bet`` etc.

### Stop Docker Container

To stop a running docker container, either close the docker terminal or select the terminal and uste the ``Ctrl-C`` shortcut multiple times.

### List all installed docker images

To see a list of all installed docker images use:

    docker images

### Delete a specific docker image

To delete a specific docker image, first use the ``docker images`` command to list all installed containers and than use the ``IMAGE ID`` and the ``rmi`` instruction to delete the container:

    docker rmi -f 7d9495d03763

### Export and Import a docker image

If you don't want to depend on a internet connection, you can also export an already downloaded docker image and than later on import it on another PC. To do so, use the following two commands:


    # Export docker image miykael/nipype_course
    docker save -o nipype_course.tar miykael/nipype_course

    # Import docker image on another PC
    docker load --input nipype_course.tar

It might be possible that you run into administrator privileges isssues because you ran your docker command with ``sudo``. This means that òther users don't have access rights to ``nipype_course.tar``. To avoid this, just change the rights of ``nipype_course.tar`` with the command:

    sudo chmod 777 nipype_course.tar


# The Dataset

The data used for this tutorial is from [openfmri.org](https://openfmri.org/) and is structured according the new and fancy [Brain Imaging Data Structure (BIDS)](http://bids.neuroimaging.io/).

The dataset ds102 used for this tutorial was shortened to only three subjects, *sub-01*, *sub-02*, *sub-03* *sub-04* and *sub-05*. For more information about the dataset, see the [description on openfmri.org](https://openfmri.org/dataset/ds000102/).


# Feedback, Help & Support

If you want to help with this tutorial or have any questions, fell free to fork the repo of the [Notebooks](https://github.com/miykael/nipype_tutorial) or [this course](https://github.com/miykael/nipype_course). If you have any questions or found a problem, open a new issue for the [Notebooks](https://github.com/miykael/nipype_course/issues) or the [course](https://github.com/miykael/nipype_course/issues).


# License

This Dockerfile is based on the dockerfiles ``crn_base`` and ``crn_nipype`` from the ([Poldrack Lab](https://github.com/poldracklab/crn_base)), the dockerfiles from ([NeuroVault](https://github.com/NeuroVault/NeuroVault)), the dockerfile biss2016-notebook from [Oscar Esteban](https://hub.docker.com/u/oesteban), the dockerfile under ([github.com/BIDS-Apps/dockerfile-templates](https://github.com/BIDS-Apps/dockerfile-templates)) and the dockerfile under ([github.com/Neurita/neuro_docker](https://github.com/Neurita/neuro_docker)).

The jupyter notebook foundation is based on [jupyter/docker-stacks](https://github.com/jupyter/docker-stacks)'s base-, minimal- and scipy-notebook.

This means that the same copyrights apply to this Dockerfile, as they do for the above mentioned content. For more information see: [github.com/miykael/nipype_env](https://github.com/miykael/nipype_env).
