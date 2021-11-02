#!/bin/sh

cd $HOME/.local/repos

for repo in $(cat non-aur-repos.txt); do
    git clone $repo
done
