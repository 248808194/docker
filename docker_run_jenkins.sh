#!/bin/bash
# 使用阿里云 jenkins images 初始化全新配置
AppOrg='ttlinux'
AppEnv='demo'
AppName='jenkins'
AppAddresses='127.0.0.1_8080,8080:8080' #指明启动 jenkins 容器宿主机 IP:Port
AppCfgs=''
ZookeeperCluster=''
RunImage='jenkins:latest'
RunOptions='-d -u root:jenkins -v /data/volume/jenkins/dump:/var/jenkins_home'
RunCmd=''
# 循环部署多实例
for AppAddress in ${AppAddresses}
#                                echo $BB
#                                192.168.8.7_8080,8080:8080 192.168.8.7_8080,8080:8080
                                  #多个地址多个循环,格式如上
                                #for i in $BB;do echo $i;done
                                #192.168.8.7_8080,8080:8080
                                #192.168.8.7_8080,8080:8080

    do
# 初始化变量
        ADDRESS=${AppAddress%%,*} # 宿主机地址和宿主机端口 %%,* 删除掉第一个逗号右边的所有字符串
        AppExpose=`echo ,${AppAddress#*,} | sed 's/,/ -p /g'` # 需要影射的端口 #sed 替换为192.168.8.7_8080 -p 8080:8080
        AppIp=${ADDRESS%%_*} # 宿主机地址 %%_* 删除掉第一个下划线右边的所有字符串
        AppPort=${ADDRESS##*_} # 宿主机端口 ADDRESS 过滤出来已经是192.168.8.7_8080 ##*_意思是删除掉第一个_左边的所有字符串只留下端口号.
        AppId=`echo ${AppOrg}_${AppEnv}_${AppName}_${AppIp}_${AppPort} | sed 's/[^a-zA-Z0-9_]//g' | tr "[:lower:]" "[:upper:]"` # 实例容器名  tr -t [:upper:] [:lower:] 转换大小写
        AppHostname=`echo ${AppPort}-${AppIp}-${AppName}-${AppEnv}-${AppOrg} | sed 's/[^a-zA-Z0-9-]//g'| tr "[:upper:]" "[:lower:]"` # 实例主机名 tr -t [:upper:] [:lower:] 转换大小

        docker -H ${AppIp}:4243 pull ${RunImage} >/dev/null # 同步版本镜像
        #docker -H 192.168.8.7:4243 pull jenkins:latest

        RESULT=`docker -H ${AppIp}:4243 inspect -f '{{.Config.Image}}' ${AppId} || echo 0` # 保留当前实例的镜像 Id
        docker -H ${AppIp}:4243 stop ${AppId} || echo # 停止当前实例
        docker -H ${AppIp}:4243 rm ${AppId} || echo # 删除当前实例
        sleep 3
        # 部署新实例  # -e 设置环境变量
        docker -H ${AppIp}:4243 run --restart=always --name=${AppId} --hostname=${AppHostname} -e JAVA_OPTS="-Xms2G -Xmx2G -XX:PermSize=256M -XX:MaxPermSize=256M -Duser.timezone=Asia/Shanghai" -e AppId=${AppId} ${AppExpose} ${RunOptions} ${RunImage} ${RunCmd}
        docker -H ${AppIp}:4243 rmi ${RESULT} || echo # 删除之前的镜像
done


docker run --restart=always --name=myjenkins --hostname=myhostnamejenkins -d -u root:jenkins -v /data/volume/jenkins/dump:/var/jenkins_home -e JAVA_OPTS="-Xms2G -Xmx2G -XX:PermSize=256M -XX:MaxPermSize=256M -Duser.timezone=Asia/Shanghai"