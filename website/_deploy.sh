#! /bin/bash

# configure your name and email if you have not done so
git config --global user.email "benkeser@emory.edu"
git config --global user.name "David Benkeser"

# clone the repository
git clone -b gh-pages \
  https://${GITHUB_PAT}@github.com/${TRAVIS_REPO_SLUG}.git \
  info550sandbox

# remove contents from existing gh-pages branch
cd info550sandbox
git rm -rf *
echo "All files in /info550sandbox after git rm"
ls -l 
# replace with contents from master branch /website
cp -r ../website/* ./
# move tmp_lectures and tmp_homeworks in and rename
cp -r ../lectures ./
cp -r ../homework ./

echo "All files in /info550sandbox after copies"
ls -l 
ls -l lectures
ls -l homework

COMMIT_MESSAGE="update the website."
git add --all *
git commit -m "${COMMIT_MESSAGE}"
git push -q origin gh-pages

