#!/usr/bin/env bash

usage() {
    cat <<END
    ./build.sh [-h] -u some-token-value -t your-build-tag -p path-to-your-dockerfile

    Used to build a docker image containing the Pivnet Cloud Foundry Autoscaler plugin. 
    In order to download it, you will need a uaa token from the Pivotal Newtork. This can
    be obtaioned through the Pivotal Network UI, and will be tied to your Pivotal Network
    account.

    -u = uaa_token, the Pivotal Network token the script will exchange for your access token,
         which can then be passed safely to the Dockerfile's args because it will expire.
    
    -t = the docker build tag you want passed to the script

    -p = the path to your Dockerfile. If left blank, the script will assume you are executing
         from the working directory and will assign the output of pwd to this parameter
END
}

while getopts ":h:u:t:p:" opt; do
    case $opt in 
        h) usage
           exit 0
           ;;
        u) uaa_token=$OPTARG
           ;;
        t) docker_tag=$OPTARG
           ;;
        p) docker_path=$OPTARG
           ;;
        \?) usage
            exit 0
            ;;
    esac
done
shift $((OPTIND -1))

if [ -z ${docker_path+x} ]; then docker_path=$(pwd); fi;

access_token=$(curl -X POST https://network.pivotal.io/api/v2/authentication/access_tokens -d "{\"refresh_token\":\"$uaa_token\"}" -s 2>&1 | sed 's/{"access_token":"\(.*\)"}/\1/')
docker build -t $docker_tag $docker_path --build-arg token=$access_token
sleep 5m # this kills the API credential that would appear in the container history by waiting for it to expire
docker push $docker_tag # if you're pushing to a private repository, make sure you've taken care of whatever credentials you need!
