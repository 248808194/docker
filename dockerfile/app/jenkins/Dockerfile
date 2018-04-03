FROM zhoutao/centos_java18_tomcat8


#jenkins
ADD jenkins.war  /usr/local/tomcat/webapps/

#RUN ls /root/.jenkins/secrets/initialAdminPassword


EXPOSE 22 8080 



CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
