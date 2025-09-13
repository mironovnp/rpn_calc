FROM ubuntu:22.04 AS builder

RUN apt-get update && \
    apt-get install -y cmake g++ git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . .

RUN rm -rf build && \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release && \
    cmake --build . --target rpn_calculator --parallel 2

FROM ubuntu:22.04

WORKDIR /app
COPY --from=builder /app/build/rpn_calculator .

CMD ["./rpn_calculator"]
