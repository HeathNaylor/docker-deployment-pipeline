# Contain Yourself

## Setup remote servers
If there are no servers, we must first set them up. This will bring up several Docker Machines and build swarms with managers and workers.

`./Provision/createMachines.sh`

## Build local image and run container
To begin developing, you will first need a local container with the nginx already installed. Create that using the following command:

`./Provision/buildLocal.sh`

You can now view the output of the application by running `docker logs -f local-container`.

## Build production image
If you are ready to tag a release and promote the image to any environment then run the following command:

`./Provision/buildDeployImage.sh`

Now it is time to tag and push the image to the remote repository, this will act as our artifact for promotion.
`docker tag image-untagged heathn/my-application:<version>`
`docker push heathn/my-application:<version>`

Ensure that your `./Provision/docker-compose-deploy.yml` references the intended version to be released.

## Deploy to QA stack
The latest version is now on the remote repository, it is time to build containers out of that image on the QA stack.

`./Provision/deployStackQa.sh`

That's it, the latest application is now spanned across the QA stack according to the rules in the `./Provision/docker-compose-deploy.yml`

## Deploy to Production stack
This step is the same as the last with the exception of which script is executed.

`./Provision/deployStackProd.sh`

The latest application is now running in your production stack
