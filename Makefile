

export project_name=toolchain-server
export project_version := $(shell git describe --tags --always)
export project_directory := $(shell git rev-parse --show-toplevel)

export docker_registry_path := ghcr.io/adam-stamand
export docker_image_repository := $(docker_registry_path)/$(project_name)

export docker_file := $(project_directory)/Dockerfile


build:
	docker build . -t $(docker_image_repository):$(project_version)
	docker tag $(docker_image_repository):$(project_version) $(docker_image_repository):latest

run:
	docker run -d -p 2222:22 toolchain-server

deploy:
	docker push $(docker_image_repository):$(project_version)
	docker push $(docker_image_repository):latest
