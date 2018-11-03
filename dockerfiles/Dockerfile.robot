FROM ros:kinetic

################################################################################
# For viewing mp4 files generated from PyBullet
################################################################################
RUN apt-get install -y vlc
RUN apt-get install -y python3-tk

################################################################################
# Install blender 2.79 (this version is needed by Phobos)
################################################################################
RUN apt-get update
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:thomas-schiex/blender -y
RUN apt-get update
RUN apt-get install blender=2.79.b~1521727842-0thomas~xenial0 -y

################################################################################
# For audio and text to speech
################################################################################
RUN apt-get install -y alsaplayer-alsa alsaplayer-common gnome-alsamixer alsa-utils alsamixergui
RUN apt-get install -y festival espeak
## For google_speech
RUN apt-get install -y sox libsox-fmt-mp3 
################################################################################
# For gnome-terminal
################################################################################
RUN apt-get install -y gnome-terminal tcsh

RUN locale-gen --purge
RUN locale-gen en_US.UTF-8
################################################################################
# create user
################################################################################
RUN groupadd -g 999 rosuser && \
   useradd -r -u 999 -g rosuser bb8

RUN usermod -aG sudo bb8
RUN echo "bb8:abc" | chpasswd
#------------------------------------------------------------
# need to be added to the "dialout" group to upload code to and Arduino
# microcontroller over the USB or serial ports
#------------------------------------------------------------
RUN usermod -aG dialout bb8

#------------------------------------------------------------
# need video group permission to access usb cameras
#------------------------------------------------------------
RUN usermod -aG video bb8
#------------------------------------------------------------
# need video group permission to access audio
#------------------------------------------------------------
RUN usermod -aG audio bb8


#RUN mkdir -p /home/bb8
#RUN chown bb8:rosuser /home/bb8
USER bb8

#WORKDIR /home/bb8
#RUN echo "umask 0002" >> /home/bb8/.bashrc
#RUN echo "echo abc | sudo -S chgrp video /dev/video*" >> /home/bb8/.bashrc
#RUN echo "#" >> /home/bb8/.bashrc
#RUN echo "PATH=$HOME/robot/bin:$HOME/bin:/opt/ros/kinetic/bin:$PATH" >> /home/bb8/.bashrc

#RUN chmod 755 /home/bb8/.bashrc

CMD ["/bin/bash"]
