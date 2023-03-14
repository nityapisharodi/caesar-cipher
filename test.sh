#!/bin/bash

#tag1=$(git describe --tags origin $(git rev-list --tags --max-count=1))

tag=$(git describe --tags $(git rev-list --tags --max-count=1) | awk -F - '{print $1}')
echo $tag