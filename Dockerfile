FROM quay.io/centos/centos:stream9

LABEL maintainer "@irix_jp"

WORKDIR /root
RUN dnf update -y && \
    dnf install -y git httpd-tools && \
    dnf module install -y nodejs:22/common && \
    dnf module install -y nginx:1.26/common && \
    npm install -g pnpm

RUN git clone https://github.com/ether/etherpad-lite.git && \
    cd etherpad-lite && \
    git fetch origin master && \
    git checkout master && \
    git branch && \
    pnpm i && \
    pnpm run build:etherpad

RUN cd etherpad-lite && \
    pnpm run plugins i \
    ep_align \
    ep_embedded_hyperlinks2 \
    ep_font_color \
    ep_headings2

RUN touch /etc/nginx/restrictions.conf

COPY nginx.conf /etc/nginx/nginx.conf
COPY settings.json /root/etherpad-lite/settings.json
COPY init.sh /init.sh

EXPOSE 80
EXPOSE 443

CMD ["bash", "/init.sh"]
