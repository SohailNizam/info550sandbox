#! /bin/bash

# configure your name and email if you have not done so
git config --global user.email "benkeser@emory.edu"
git config --global user.name "David Benkeser"

# find which files have changed (for commit message)
# `git` expects a `..` delimiter between commits, not `...`
COMMIT_RANGE="$(echo ${TRAVIS_COMMIT_RANGE//.../..})"
# find modified and added Rmd files
CHANGED_RMD_FILES="$(git diff --diff-filter=MA --name-only ${COMMIT_RANGE} -- | grep '.Rmd')"
echo $CHANGED_RMD_FILES

# clone the repository
git clone -b gh-pages \
  https://${GITHUB_PAT}@github.com/${TRAVIS_REPO_SLUG}.git \
  info550
# remove contents and restructure
cd info550
git rm -rf *
cp -r ../website/* ./
cp -r ../lectures ./
cp -r ../homework ./

ls -l 

COMMIT_MESSAGE="update the website. rebuilt "${CHANGED_RMD_FILES}
git add --all *
git commit -m ${COMMIT_MESSAGE}
git push -q origin gh-pages

