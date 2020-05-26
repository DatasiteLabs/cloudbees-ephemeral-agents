#!/usr/bin/env bash

usage() {
    cat <<END
    ./build.sh [-h] -u some-token-value -t your-build-tag -p path-to-your-dockerfile

    Used to build a docker image containing the Pivnet Cloud Foundry Autoscaler plugin.
    In order to download it, you will need a uaa token from the Pivotal Newtork. This can
    be obtaioned through the Pivotal Network UI, and will be tied to your Pivotal Network
    account.

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

docker build -t $docker_tag $docker_path
# sleep 5m # this kills the API credential that would appear in the container history by waiting for it to expire
# docker push $docker_tag # if you're pushing to a private repository, make sure you've taken care of whatever credentials you need!
