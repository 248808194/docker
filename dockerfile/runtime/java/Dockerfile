FROM zhoutao/centos-supervisor


#java7 
ADD jdk-8u161-linux-x64.tar.gz /usr/local/

RUN ln -s /usr/local/jdk1.8.0_161 /usr/local/jdk



ENV JAVA_HOME /usr/local/jdk
ENV JRE_HOME=/usr/local/jdk/jre
ENV PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
ENV CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib




EXPOSE 22 



CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
