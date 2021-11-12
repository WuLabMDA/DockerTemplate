# DockerTemplate
Docker template for python biomedical research

### To configure
* line 1: change **base image** (optional)
* line 11: change **pchen6** to your own name (mandatory)
* line 25: change **3.8.5** to your preferred python version (optional)
* Additional environment variables and python packages are suggested to add at the end


### Build the image
```
$ docker build -t pymed:wulab .
```
