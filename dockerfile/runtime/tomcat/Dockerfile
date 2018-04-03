FROM zhoutao/centos-supervisor


#jdk1.7

ADD jdk-8u161-linux-x64.tar.gz /usr/local/
RUN ln -s /usr/local/jdk1.8.0_161 /usr/local/jdk


#tomcat8

ADD apache-tomcat-8.5.24.tar.gz  /usr/local
RUN ln -s /usr/local/apache-tomcat-8.5.24 /usr/local/tomcat
ADD tomcat.ini /etc/supervisord.d/tomcat.ini

 
# java && tomcat  env
ENV JAVA_HOME /usr/local/jdk
ENV TOMCAT_HOME /usr/local/tomcat
ENV JRE_HOME=/usr/local/jdk/jre
ENV PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
ENV CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib




EXPOSE 22 
EXPOSE 8080 



CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
