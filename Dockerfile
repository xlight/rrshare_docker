#本镜像基于最新版alpine+glibc+rrshareweb
FROM alpine:20190228

LABEL MAINTAINER="xLight <https://xlight.me/>"


# 配置glibc
ENV GLIBC_VERSION=2.29-r0

RUN apk update \
	&& apk --no-cache add wget libstdc++ tzdata \
	&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& echo 'Asia/Shanghai' >  /etc/timezone \
	&& wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
	&& wget -q https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
	&& wget -q https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk \
 	&& apk --no-cache add glibc-${GLIBC_VERSION}.apk \
	&& apk --no-cache add glibc-bin-${GLIBC_VERSION}.apk \
	&& mkdir -p /rrshare \
	&& mkdir -p /opt/work/store \    
	&& wget -q http://appdown.rrys.tv/rrshareweb_centos7.tar.gz -O /rrshare/rrshareweb_centos7.tar.gz \
	&& tar zxvf /rrshare/rrshareweb_centos7.tar.gz -C /rrshare/ \     
	&& rm -rf /rrshare/rrshareweb_centos7.tar.gz \   
	&& apk del wget tzdata \
	&& rm -rf /glibc-${GLIBC_VERSION}.apk \
	&& rm -rf /glibc-bin-${GLIBC_VERSION}.apk
	

WORKDIR /
VOLUME ["/opt/work/store","/opt/work/conf"]
EXPOSE 3001 

CMD ["sh", "-c", "if [ ! -f /opt/work/conf/rrshare.db ]; then echo 'conf not found,build!' && mkdir -p /opt/work/conf && mv /rrshare/rrshareweb/conf/* /opt/work/conf/ && ln -s /opt/work/conf/rrshare.db /rrshare/rrshareweb/conf/ &&   ln -s /opt/work/conf/rrshare.json /rrshare/rrshareweb/conf/ ; else echo 'file found,link!' && rm -f /rrshare/rrshareweb/conf/* && ln -s /opt/work/conf/rrshare.db /rrshare/rrshareweb/conf/ &&   ln -s /opt/work/conf/rrshare.json /rrshare/rrshareweb/conf/ ; fi; /rrshare/rrshareweb/rrshareweb"]

RUN sed -i "s/http:\/\/www\.zmzfile\.com\/file\//http:\/\/file.apicvn.com\/file\//g" /rrshare/rrshareweb/web/build/static/js/main.*.js
