FROM alpine:3.11
WORKDIR /tmp
RUN apk add make automake gcc musl-dev gcc bash git curl upx  && \
    git clone https://github.com/giulianozor/coreutils-static.git  && \
    cd coreutils-static && \
    sh -c ./build.sh && \
    cd .. && \
    rm -rf coreutils-static
