FROM ros:kinetic

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


RUN mkdir -p /home/bb8
RUN chown bb8:rosuser /home/bb8
USER bb8

WORKDIR /home/bb8
RUN echo "umask 0002" >> /home/bb8/.bashrc
RUN echo "echo abc | sudo -S chgrp video /dev/video*" >> /home/bb8/.bashrc
RUN echo "#" >> /home/bb8/.bashrc
RUN echo "PATH=$HOME/robot/bin:$HOME/bin:$PATH" >> /home/bb8/.bashrc

RUN chmod 755 /home/bb8/.bashrc

CMD ["/bin/bash"]
