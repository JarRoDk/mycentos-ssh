FROM centos
RUN yum -y update; yum clean all
RUN yum -y install openssh-server passwd; yum clean all
RUN yum -y install rsyslog
ADD ./start.sh /start.sh
RUN mkdir /var/run/sshd

RUN ssh-keygen -A 
ADD ./sshd_config /etc/ssh/sshd_config
#RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 

RUN chmod 755 /start.sh
# EXPOSE 22
RUN ./start.sh
ENTRYPOINT ["/usr/sbin/rsyslogd" ]
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
