FROM debian:10.8-slim as build

LABEL maintainer="Adam St. Amand"

# ARG name=defaultValue

RUN apt-get update && apt-get install -y \ 
    gcc-avr \ 
    avr-libc \
    avrdude \
    gdb-avr \
    openssh-server \
    sudo \
    cmake

RUN useradd docker \
        && passwd -d docker \
        && mkdir /home/docker \
        && chown docker:docker /home/docker \
        && addgroup docker sudo \
        && true

RUN  echo 'docker:docker' | chpasswd
RUN sed -i 's/PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config

EXPOSE 22

RUN service ssh start



CMD ["/usr/sbin/sshd","-D"]