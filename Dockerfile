FROM ubuntu:20.04

WORKDIR .

ARG TB_HOME=/usr/local/tibero6

ADD res/tibero.tar.gz /usr/local

COPY res/license.xml ${TB_HOME}/license/

COPY start.sh /.

COPY InitDatabase.sql /.

COPY InitAccount.sql /.

COPY initTibero.sh /.

COPY bash_profile_add /root

RUN cat /root/bash_profile_add >> /root/.bashrc

RUN echo "/etc/hosts: $(cat /etc/hosts)"

RUN echo "/proc/sys/kernel/hostname : $(cat /proc/sys/kernel/hostname)"

RUN /initTibero.sh

EXPOSE 8629

ENTRYPOINT ["bin/bash", "/start.sh"]
