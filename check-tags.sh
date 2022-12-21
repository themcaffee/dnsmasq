#!/bin/sh


# Configure git
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"
# Get dnsmasq
git clone git://thekelleys.org.uk
# Get dnsmasq tags
cd /dnsmasq
git fetch --all --tags
git tag --list 'v*' | sort -V > /tmp/latest-tag
# Get the tags that exist in this repo
cd /dnsmasq-docker
git fetch --all --tags
git tag --list 'v*' | sort -V > /tmp/latest-tag-docker
# Iterate through the tags and check if they exist in the docker repo
while read version; do
    echo $version
    if grep -q -F -f /tmp/latest-tag-docker $version; then
        echo "No new tag"
    else
        echo "New tag found"
        cd /dnsmasq-docker
        git tag $version
        git push origin $version
    fi
done </tmp/latest-tag