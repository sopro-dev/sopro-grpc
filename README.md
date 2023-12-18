# Image GRPC

This image compiles gRPC from source to:
- Enhance compatibility
- Serve as baseline with OnnxRuntimes
- Compile .proto files
- Compile grpc_plugins

with specific versions to avoid breaking changes.

```bash
# tag is grpc version, also used as image tag
# sopro-dev/sopro-grpc:tag
make build-and-release tag=v1.54.2
```