from alpine:3.7
MAINTAINER jackadamjackadam@sina.com
#变更源
#安装包源切到中科大, 国内访问加速

#RUN {
#    echo 'http://mirrors.ustc.edu.cn/alpine/v3.7/main';
#    echo 'http://mirrors.ustc.edu.cn/alpine/v3.7/community';
#    echo 'http://mirrors.ustc.edu.cn/alpine/edge/main';
#    echo 'http://mirrors.ustc.edu.cn/alpine/edge/community';
#    echo 'http://mirrors.ustc.edu.cn/alpine/edge/testing';
#    } > /etc/apk/repositories && \
#设置默认时区为亚洲/上海 (没有北京可选)

RUN apk add --no-cache --upgrade apk-tools tzdata && \
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
echo "Asia/Shanghai" > /etc/timezone && \
apk del tzdata 

EXPOSE 8000

#这里增加python3
RUN apk add --no-cache --upgrade git python3 python3-dev gcc musl-dev==1.1.18-r3 libxslt-dev linux-headers && \
pip3 install --upgrade pip requests chardet sqlalchemy utils psutil lxml web.py==0.40-dev1 gevent

#克隆代理池源码
RUN git clone https://github.com/anjia0532/IPProxyPool.git

#启动代理池
CMD python3 /IPProxyPool/IPProxy.py
