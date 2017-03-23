# This Dockerfile is based on the dockerfile 'fmriprep' from the Poldrack
# Lab (https://github.com/poldracklab/fmriprep). The jupyter notebook foundation
# is based on jupyter/docker-stacks's base-notebook.
#
# This means that the same copyrights apply to this Dockerfile, as they do for
# the above mentioned dockerfiles. For more information see:
# https://github.com/miykael/nipype_env

FROM miykael/nipype_level3
MAINTAINER Michael Notter <miykaelnotter@gmail.com>

#-------------------------------------
# Prepare files and folders for course
#-------------------------------------
USER root

# Download dataset for course from openfmri.org
RUN mkdir -p /data
RUN curl -sSL http://openfmri.s3.amazonaws.com/tarballs/ds102_R2.0.0_all_data.tgz | tar zxv -C /data \
    --exclude='sub-06' --exclude='sub-07' --exclude='sub-08' --exclude='sub-09' \
    --exclude='sub-10' --exclude='sub-11' --exclude='sub-12' --exclude='sub-13' \
    --exclude='sub-14' --exclude='sub-15' --exclude='sub-16' --exclude='sub-17' \
    --exclude='sub-18' --exclude='sub-19' --exclude='sub-20' --exclude='sub-21' \
    --exclude='sub-22' --exclude='sub-23' --exclude='sub-24' --exclude='sub-25' \
    --exclude='sub-26' --exclude='derivatives'
RUN mv `ls -d /data/ds102_*` /data/ds102
RUN head -n 6 /data/ds102/participants.tsv > tmp.rst
RUN mv tmp.rst /data/ds102/participants.tsv

# Copy ANTs transformation matrix into docker image
COPY antsdir /data/antsdir

# Get notebooks for course from miykael/nipype_tutorial
RUN wget -q -P /home/$NB_USER/work \
    https://github.com/miykael/nipype_tutorial/archive/master.zip
RUN unzip -q /home/$NB_USER/work/master.zip \
    -d /home/$NB_USER/work/
RUN cp /home/$NB_USER/work/nipype_tutorial-master/index.ipynb \
    /home/$NB_USER/work/index.ipynb
RUN cp -r /home/$NB_USER/work/nipype_tutorial-master/notebooks \
    /home/$NB_USER/work/notebooks
RUN cp -r /home/$NB_USER/work/nipype_tutorial-master/static \
    /home/$NB_USER/work/static
RUN rm -rf /home/$NB_USER/work/master.zip \
    /home/$NB_USER/work/nipype_tutorial-master

#----------------------
# Give power to NB_USER
#----------------------
USER root

# Set user rights to NB_USER
RUN chown -R $NB_USER:users /home/$NB_USER/work && \
    chown -R $NB_USER:users /data

# Set default user to NB_USER
USER $NB_USER

RUN pip install bids==0.1