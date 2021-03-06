FROM centos:8

LABEL maintainer "@irix_jp"

RUN dnf update -y && \
    dnf install -y glibc-all-langpacks git sudo which jq openssl openssl-devel openssl-libs httpd-tools && \
    dnf module install -y nodejs:10/common && \
    dnf module install -y nginx:1.14/common && \
    dnf clean all

RUN mkdir /etc/nginx/ssl && \
    openssl req -new -x509 -sha256 -newkey rsa:2048 -days 36500 \
                -subj '/C=JP/ST=Tokyo/L=Tokyo/O=Eplite Ltd./OU=Web/CN=localhost' \
                -nodes -out /etc/nginx/ssl/nginx.pem -keyout /etc/nginx/ssl/nginx.key && \
    chown root:root -R /etc/nginx/ssl/ && \
    chmod 600 /etc/nginx/ssl/* && \
    chmod 700 /etc/nginx/ssl

WORKDIR /eplite
RUN git clone --branch master --depth 1 https://github.com/ether/etherpad-lite.git
WORKDIR /eplite/etherpad-lite
RUN bin/installDeps.sh && \
    npm install sqlite3 && \
    rm -rf ~/.npm/_cacache

COPY settings.json /eplite/etherpad-lite/settings.json
COPY eplite.conf /etc/nginx/conf.d/eplite.conf
COPY init.sh /init.sh

CMD ["bash", "/init.sh"]
