FROM ubuntu:jammy

WORKDIR /app

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
        golang \
        build-essential \
        autoconf \
        libtool \
        pkg-config \
        git \
        cmake \
        language-pack-en \
        python3-pip \
        python3-dev && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    cd /usr/local/bin && \
    ln -s /usr/bin/python3 python && \
    pip3 install --upgrade pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# Install grpc, grpc_plugins, and protoc
ARG TAG ${TAG:-v1.54.2}

# Install protoc
RUN echo "Building grpc from tag: ${TAG}" && \
    git clone --recurse-submodules -b ${TAG} https://github.com/grpc/grpc && \
    cd grpc && \
    mkdir -p cmake/build && \
    cd cmake/build && \
    cmake -DgRPC_INSTALL=ON -DgRPC_BUILD_TESTS=OFF -DCMAKE_INSTALL_PREFIX=/usr/local ../.. && \
    make -j$(nproc) && \
    make plugins -j$(nproc) && \
    make install && \
    cd /app && \
    rm -rf /app/grpc

# Add Golang binary directory to PATH
ENV PATH="/root/go/bin:$PATH"
# Install protoc-gen-go and protoc-gen-go-grpc
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest && \
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
