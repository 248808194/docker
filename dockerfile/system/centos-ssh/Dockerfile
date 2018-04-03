FROM centos


#base pkg
RUN	rpm -ivh https://mirrors.aliyun.com/epel/epel-release-latest-7.noarch.rpm && \
	yum -y install mysql-devel mysql git tree net-tools sudo psmisc procps vim vi
#sshd
RUN	yum -y install openssh-server openssh-clients openssh openssl nginx && \
	yum clean all && \
	echo "daemon off;" >> /etc/nginx/nginx.conf && \
	yum clean all && \
	ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key && \
	ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key && \
	ssh-keygen -A -t dsa -f /etc/ssh/ssh_host_ed25519_key

#set root password
RUN	echo root:YUOIQ2HR9FDHU1823YUHBi^iatgyhkUI123 | chpasswd

EXPOSE 22 



CMD ["/usr/sbin/sshd","-D"]
