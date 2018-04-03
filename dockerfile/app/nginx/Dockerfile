FROM centos



RUN	rpm -ivh https://mirrors.aliyun.com/epel/epel-release-latest-7.noarch.rpm && \
	yum -y install mysql-devel mysql git tree net-tools sudo psmisc procps vim vi nginx  && \
	yum clean all && \
	echo "daemon off;" >> /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx"]

