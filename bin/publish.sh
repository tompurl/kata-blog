#!/bin/bash

set -e
# set -x

source /home/tom/.keychain/$HOSTNAME-sh

### Constants
SOURCE_DIR=~/src/kata-blog
PUBLISH_DIR=~/gtd/kata-blog/public

### See if the master branch has been updated

cd "$SOURCE_DIR"
git remote update

message=$(./bin/check-local-repo-status.sh)

if [[ "$message" == "Up-to-date" ]]; then
    exit 0
elif [[ "$message" != "Need to pull" ]]; then
    echo "Cannot continue. Git repo status:" >&2
    echo "$message" >&2
    exit 1
fi

# Pull the update
git pull origin master

### Generate html and such
hugo 

### Rsync site with remote folder
rsync -av --delete "$PUBLISH_DIR/" blog:/home/public
