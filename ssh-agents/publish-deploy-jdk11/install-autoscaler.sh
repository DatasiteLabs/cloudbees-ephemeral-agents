#!/bin/bash

# Need to run as jenkins user! su - jenkins

cf install-plugin app-autoscaler-plugin-2.0.91 -f
cd ../
cf install-plugin app-autoscaler-plugin-2.0.91 -f