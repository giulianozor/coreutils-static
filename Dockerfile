FROM alpine:3.11
WORKDIR /tmp
RUN apk add make automake gcc musl-dev gcc bash git curl upx
RUN git clone https://github.com/giulianozor/coreutils-static.git
RUN cd coreutils-static
RUN bash ./build.sh
