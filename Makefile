MICROSERVICE_NAME=sopro-dev/sopro-grpc

build-and-release:
	docker build --build-arg TAG=$(tag) -t $(MICROSERVICE_NAME):$(tag) .
	docker push $(MICROSERVICE_NAME):$(tag)
