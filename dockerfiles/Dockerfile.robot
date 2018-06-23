FROM ros:kinetic

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
RUN chown bb8 /home/bb8
RUN chgrp rosuser /home/bb8
RUN chown bb8 /home/bb8
USER bb8

WORKDIR /home/bb8
RUN echo "umask 0002" >> /home/bb8/.bashrc
RUN echo "echo abc | sudo -S chgrp video /dev/video*" >> /home/bb8/.bashrc
Run echo "#" >> /home/bb8/.bashrc
RUN chmod 755 /home/bb8/.bashrc

CMD ["/bin/bash"]
