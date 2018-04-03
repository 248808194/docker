FROM zhoutao/centos-supervisor


#BASE 
RUN yum -y install gcc gcc-c++ ncurses-devel libxml2-devel openssl-devel curl-devel libjpeg-devel libpng-devel autoconf pcre-devel libtool-libs freetype-devel gd zlib-devel zip unzip wget crontabs iptables file bison cmake patch mlocate flex diffutils automake make readline-devel glibc-devel glibc-static glib2-devel bzip2-devel gettext-devel libcap-devel logrotate ntp libmcrypt-devel GeoIP*

#PCRE INSTALL
ADD pcre-8.37.tar.gz /usr/local/src
RUN cd /usr/local/src/pcre-8.37 && \
    ./configure && \
    make && \
    make install 

#LuaJIT INSTALL
ADD LuaJIT-2.0.4.tar.gz /usr/local/src

RUN cd /usr/local/src/LuaJIT-2.0.4 &&  make && make install PREFIX=/usr/local/luajit


#Tengine INSTALL
ADD tengine-2.2.2.tar.gz /usr/local/src
RUN useradd www -s /sbin/nologin
RUN cd /usr/local/src/tengine-2.2.2 && \
    ./configure --prefix=/usr/local/nginx \
                --with-http_lua_module \
                --with-luajit-lib=/usr/local/luajit/lib/ \
                --with-luajit-inc=/usr/local/luajit/include/luajit-2.0/ \
                --with-ld-opt=-Wl,-rpath,/usr/local/luajit/lib \
                --with-pcre=/usr/local/src/pcre-8.37 \
                --user=www \
                --group=www \
                --with-poll_module \
                --with-http_stub_status_module \
                --with-http_sub_module \
                --with-http_ssl_module \
                --with-http_stub_status_module \
                --with-file-aio \
                --with-http_dav_module \
                --with-http_realip_module && \
    make && make install
#Tengine INIT Script && Config FILE
ADD nginx.conf /usr/local/nginx/conf/nginx.conf
ADD nginx.service /usr/lib/systemd/system/nginx.service
ADD nginx-init-script /etc/init.d/nginx
#ADD nginx.ini /etc/supervisord.d/nginx.ini


#waf INSTALL 
ADD waf.tar /usr/local/nginx/conf
RUN mkdir /usr/local/nginx/logs/hack/ -p && chmod 777 /usr/local/nginx/logs/hack -Rf && mkdir -p /usr/local/nginx/conf/vhosts




EXPOSE 22 
EXPOSE 80



CMD ["/usr/local/nginx/sbin/nginx"]
