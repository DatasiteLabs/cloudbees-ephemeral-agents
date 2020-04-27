#!/bin/bash

# Need to run as jenkins user! su - jenkins

cf install-plugin app-autoscaler-plugin -f
cd ../
cf install-plugin app-autoscaler-plugin -f