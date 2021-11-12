# DockerTemplate
Dockerfile template for python biomedical research

### To configure
* line 1: change **base image** (optional)
* line 10: change **pchen6** to your own name (mandatory)
* line 26: change **3.8.5** to your preferred python version (optional)
* Additional environment variables and python packages are suggested to be added at the end


### Build the image
```
$ docker build -t pymed:pchen6 .
```
* change **pymed:pchen6** to your preferred name and tag, with format name:tag.   


### Start the docker container
```
$ docker run -it --rm --user $(id -u):$(id -g) \
  -v DATA-MAPPING \
  -v CODE-MAPPING \
  --gpus '"device=0"' --shm-size=128G --cpuset-cpus=0-9 \
  --name container_name docker_image
```
* DATA-MAPPING: map your local data folder to container
* CODE-MAPPING: map your local code repo to container
* gpus/shm-size/cpuset-cpus: need to set based upon your server
* container_name: cannot duplicate existing ones
* docker_image: docker image to use, e.g., pymed:pchen6
