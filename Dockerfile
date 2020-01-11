FROM alpine

RUN apk update && \
    apk add curl && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.17.0/bin/linux/amd64/kubectl && \
    chmod +x kubectl && \
    cp kubectl /usr/bin

COPY ./make-kubeconfig.sh /usr/sbin/make-kubeconfig