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
ADD vnc /root/.vnc
ADD config /root/.config
ADD Desktop /root/Desktop
ADD scripts /root/scripts
RUN chmod +x /root/.vnc/xstartup /etc/X11/xinit/xinitrc /root/scripts/*.sh /root/Desktop/*.desktop
##. Install java and netbeans

RUN apt-get install software-properties-common -y

#RUN add-apt-repository -y ppa:webupd8team/java
#RUN apt-get update
#RUN echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
#RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
#RUN apt-get -y install oracle-java8-installer
#RUN apt-get install software-properties-common -y
#RUN add-apt-repository -y ppa:vajdics/netbeans-installer
#RUN apt-get update
#RUN apt-get install unzip -y
#RUN apt-get install netbeans-installer -y


RUN apt-get install -y python-software-properties debconf-utils
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
RUN apt-get install -y oracle-java8-installer



RUN add-apt-repository -y ppa:vajdics/netbeans-installer
RUN apt-get update
RUN apt-get install unzip -y
RUN apt-get install netbeans-installer -y



RUN mkdir /root/.netbeans /root/.netbeans/8.1 /root/.netbeans/8.1/var
RUN touch /root/.netbeans/8.1/var/license_accepted
ENTRYPOINT ["/root/scripts/vnc_startup.sh"]
CMD ["--tail-log"]
