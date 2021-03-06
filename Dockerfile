FROM node:12-alpine

ENV KUBECTL_VERSION=1.16.10

RUN apk upgrade -q --no-cache
RUN apk add -q --no-cache \
  bash \
  ca-certificates \
  coreutils \
  curl \
  docker \
  gettext \
  git \
  grep \
  jq \
  make \
  openssl \
  perl-xml-xpath \
  py3-pip \
  py3-paramiko \
  python \
  sed \
 && pip3 install -q docker-compose

COPY get-package-details.sh /usr/bin/get-package-details
COPY set-tags.sh /usr/bin/set-tags

RUN wget -q "https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl" -O "/usr/bin/kubectl" \
 && chmod +x "/usr/bin/kubectl" \
 && printf '\nsource /usr/bin/get-package-details\n' >> /root/.bashrc

CMD ["bash"]
