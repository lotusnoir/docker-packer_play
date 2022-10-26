# Packer + ansible

This images is made to build packer images with ansible provisionner on a gitlab pipeline.

## Test image locally

```
#Build image
docker build -t packerimage . 
#Run container from this image
docker run --name packercontainer -d -P packerimage
#Enter container
docker exec -it packercontainer bash
```


## Using on gitlab runner

Packer need a special runner to process this jobs:

- open port to hypervisor api
- docker in network host mode
