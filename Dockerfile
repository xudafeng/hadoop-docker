FROM centos:7

MAINTAINER xdf

RUN yum -y update && yum clean all

RUN yum -y install net-tools.x86_64 tar wget which rsync openssh-server openssh-clients java-1.7.0-openjdk-devel

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -C '' -N ''
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -C '' -N ''
RUN ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ""
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key

#ADD id_rsa.pub /root/.ssh/authorized_keys

RUN ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
RUN cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys

#ADD hosts /hosts

RUN curl -s http://mirrors.hust.edu.cn/apache/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s ./hadoop-2.7.3 hadoop

ENTRYPOINT ["/entrypoint.sh"]
