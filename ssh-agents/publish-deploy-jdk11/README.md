# PUBLISH-DEPLOY CONTAINER

This container is configured to build a Java service and push that service to PCF.

## Building

To build publish-deploy-jdk11, use the ./build.sh script.

### Required Parameters

- uaa_token (-u): your UAA token generated following the UAA token workflow in [Pivotal's documentation](https://network.pivotal.io/docs/api).
- docker_tag (-t): the tag to apply to the image - this will be used in a _docker build_ and _docker psuh_ command, so it will need to follow [docker's syntax](https://docs.docker.com/get-started/part5/)
- path (-p): the path to your build context. If it's blank, the script will assume you're building in the current working directory and attempt to use it as the current context.

### Script Walkthrough

run `./build.sh -p $YOUR_PATH -t $YOUR_TAG -u $YOUR_UAA_TOKEN_FROM_PIVOTAL`.

The script will check that your path is a valid one, or use the current directory if you didn't include any values for -p. Next, it will perform the UAA authorization dance to swap your UAA token for a PivNet access token, a process described [here](https://network.pivotal.io/docs/api). Finally, it'll build the image and tag it, sleep long enough to expire the PivNet token that is stored in the base image, then push the image to your designated repository with `docker push`.

## How to get a Pivnet UAA Token

### Requirements

- A Pivnet account, which you can obtain [here](https://network.pivotal.io/) by clicking **Sign In** in the upper right-hand corner of the page.

### Token Walkthrough

Sign into your Pivotal Network ("PivNet") account [here](https://network.pivotal.io/users/dashboard/edit-profile). On the initial landing page, click on the blue **REQUEST NEW REFRESH TOKEN** at the bottom of the page. Copy this token and save it in a safe place - I prefer [KeePass 2](https://keepass.info/), but you do you if you want to save it in a text file on your desktop (don't do this).