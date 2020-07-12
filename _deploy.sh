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
  info550sandbox

# restructuring the directory

# make temporary directories of lectures and homeworks
# that contain the current contents of the gh-pages branch
mkdir tmp_lectures tmp_homework
cp info550sandbox/lectures/* tmp_lectures
echo "All files in tmp_lectures and tmp_homework after initial copy"
ls -l tmp_lectures
cp info550sandbox/homework/* tmp_homework
ls -l tmp_homework

# copy directories that were changed this commit
# into these temporary directories
for RMD_FILE in ${CHANGED_RMD_FILES}
do 
	FILE_PATH=${RMD_FILE%/*}
	rm -rf "tmp_${FILE_PATH:1}"
	cp -r "${FILE_PATH}/*" "tmp_${FILE_PATH:1}"
done

echo "All files in tmp_lectures and tmp_homework after for loop"
ls -l tmp_lectures
ls -l tmp_homework

# remove contents from existing gh-pages branch
cd info550sandbox
git rm -rf *
echo "All files in /info550sandbox after git rm"
ls -l 
# replace with contents from master branch /website
cp -r ../website/* ./
# move tmp_lectures and tmp_homeworks in and rename
cp -r ../tmp_lectures ./
mv tmp_lectures lectures
cp -r ../tmp_homework ./
mv tmp_homework homework

echo "All files in /info550sandbox after copies"
ls -l 
ls -l lectures
ls -l homework

COMMIT_MESSAGE="update the website. rebuilt "${CHANGED_RMD_FILES}
git add --all *
git commit -m "${COMMIT_MESSAGE}"
git push -q origin gh-pages

