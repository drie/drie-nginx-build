all: compile create copy cleanup

compile:
	@echo "*** Compiling binary"
	docker build --tag build-nginx-image --rm .

create:
	@echo "*** Creating container from image"
	docker create --name build-nginx-container build-nginx-image

copy:
	@echo "*** Copying compiled binary"
	docker cp build-nginx-container:/tmp/nginx.tgz ./

cleanup:
	@echo "*** Cleaning up"
	docker rm build-nginx-container
	docker rmi build-nginx-image
