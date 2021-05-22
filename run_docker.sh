#!/usr/bin/env bash

## Complete the following steps to get Docker running locally

# Step 1:
# Build image and add a descriptive tag
sudo docker build . --tag=ml-api

# Step 2: 
# List docker images
sudo docker image ls

# Step 3: 
# Run flask app
sudo docker run -it --rm --name ml-api -p 8000:8080 ml-api