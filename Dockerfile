FROM ubuntu:14.04
MAINTAINER Murphy McMahon <pandeiro.docker@gmail.com>

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:123456' | chpasswd

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Add a local, non-root user w/ ssh key
RUN useradd -ms /bin/bash newuser
RUN echo 'newuser:newuser' | chpasswd

ADD init.sh /init.sh

EXPOSE 22
CMD ["/init.sh"]
