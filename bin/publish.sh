#!/bin/bash

set -e
set -x

### Constants
SOURCE_DIR=~/src/braindump
PUBLISH_DIR=~/gtd/org/braindump_html

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
./bin/org-publish.sh

### Rsync site with remote folder
rsync -av --delete "$PUBLISH_DIR/" blog:/home/public
