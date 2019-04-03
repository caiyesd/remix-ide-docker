FROM ubuntu:18.04

MAINTAINER caiyesd@gmail.com

ENV NODE_VERSION v10.15.3

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak && \
    echo '\
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse \n\
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse \n\
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse \n\
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse \n\
' > /etc/apt/sources.list

RUN apt update && apt install -y wget xz-utils git g++ make python && \
    wget https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz && \
    tar -C /usr/local/ -xJf node-${NODE_VERSION}-linux-x64.tar.xz && \
    rm -rf node-${NODE_VERSION}-linux-x64.tar.xz && \
    export PATH=/usr/local/node-${NODE_VERSION}-linux-x64/bin:${PATH} && \
    echo "export NODE_VERSION=${NODE_VERSION}" >> /root/.bashrc && \
    echo 'export PATH=/usr/local/node-${NODE_VERSION}-linux-x64/bin:${PATH}' >> /root/.bashrc && \
    echo 'prefix = "${HOME}/.node"' >> ${HOME}/.npmrc && \
    mkdir -p ${HOME}/.node && \
    echo 'export PATH=${HOME}/.node/bin:${PATH}' >> /root/.bashrc && \
    npm install -g --unsafe-perm remix-ide && \
    sed -i s/127.0.0.1/0.0.0.0/g ${HOME}/.node/lib/node_modules/remix-ide/bin/remix-ide && \
    sed -i s/", loopback"//g ${HOME}/.node/lib/node_modules/remix-ide/node_modules/remixd/src/websocket.js && \
    ln -s /usr/local/node-${NODE_VERSION}-linux-x64/bin/node /usr/bin/ && \
    ln -s ${HOME}/.node/bin/remix-ide /usr/bin && \
    echo "Done."

EXPOSE 8080
EXPOSE 65520

CMD "remix-ide" "/app"
