docker build - < Dockerfile


# Docker Image for Ansible compatible with mitogen

This docker image contains ansbile version 2.10.7 that is the last one compatible with mitogen, in order to speed up heavy deployements.
It also contains all the required packages and collections in order to create vms and to manage them.

On gitlab > Settings > repository > deploy token

Create new with username CI, select all scopes

On gitlab > Settings > CI/CD > variables > add variable

CI_BUILD_TOKEN with previous token code
