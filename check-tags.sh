#!/bin/sh

# Configure git
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"
# Get the tags that exist in this repo
git fetch --all --tags
git tag --list 'v*' | sort -V > latest-tag-docker
# Get dnsmasq tags
git clone git://thekelleys.org.uk/dnsmasq.git 
cd dnsmasq
git fetch --all --tags
git tag --list 'v*' | sort -V | tail -n 2 > ../latest-tag
cd ../
rm -rf dnsmasq
# Iterate through the tags and check if they exist in the docker repo
while read version; do
    echo $version
    if grep -Fxq $version "latest-tag-docker"; then
        echo "No new tag"
    else
        echo "New tag found"
        git tag $version
        git push origin $version
    fi
done < latest-tag