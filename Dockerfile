FROM node:alpine

# install bash git cmake make gcc libc-dev libuv-dev
RUN apk add --no-cache bash git cmake make gcc g++ libc-dev libuv-dev

# Node.js package to keep the proxy running in case of failure
RUN npm -g i forever

# clone and install Fusl's fork of xmrig
RUN git clone https://github.com/Fusl/xmrig /xmrig
WORKDIR /xmrig
RUN cmake .
RUN make

# Add Node.js proxy server to container
ADD xm /xm
WORKDIR /xm
RUN npm i

ADD run.sh /xmrig

WORKDIR /xmrig
ENTRYPOINT ["./run.sh"]
