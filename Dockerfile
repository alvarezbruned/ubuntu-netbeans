FROM ubuntu:14.04

MAINTAINER Albert Alvarez "albert@alvarezbruned.com"

ENV DEBIAN_FRONTEND noninteractive
ENV DISPLAY :1
ENV NO_VNC_HOME /root/noVNC
ENV VNC_COL_DEPTH 24
ENV VNC_RESOLUTION 1280x1024
ENV VNC_PW vncpassword

############### xvnc / xfce installation
RUN apt-get update && apt-get upgrade -y && apt-get install -y supervisor nano xfce4 gnome-icon-theme-full vnc4server wget

# xvnc server porst, if $DISPLAY=:1 port will be 5901
EXPOSE 5901
sh /root/scripts/java_install_8.sh
sh /root/scripts/netbeans_8_install.sh
ADD vnc /root/.vnc
ADD config /root/.config
ADD Desktop /root/Desktop
ADD scripts /root/scripts
RUN chmod +x /root/.vnc/xstartup /etc/X11/xinit/xinitrc /root/scripts/*.sh

ENTRYPOINT ["/root/scripts/vnc_startup.sh"]
CMD ["--tail-log"]
