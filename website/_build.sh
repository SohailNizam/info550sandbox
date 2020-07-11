#! /bin/bash

#--------------------------------------------------------
# build new/changed lectures and homeworks from Rmd 
#--------------------------------------------------------

# find which files have changed
# `git` expects a `..` delimiter between commits, not `...`
COMMIT_RANGE="$(echo ${TRAVIS_COMMIT_RANGE//.../..})"
# find modified and added files for this commit (sanity check)
CHANGED_FILES="$(git diff --diff-filter=MA --name-only ${COMMIT_RANGE})"
echo $CHANGED_FILES
# find modified and added Rmd files
CHANGED_RMD_FILES="$(git diff --diff-filter=MA --name-only ${COMMIT_RANGE} -- | grep '.Rmd')"
echo $CHANGED_RMD_FILES

# build changed Rmd files using Rmarkdown
for RMD_FILE in ${CHANGED_RMD_FILES}
do 
	FILE_PATH=${RMD_FILE%/*}
	FILE_NAME=${RMD_FILE##*/}
	Rscript -e "setwd('${TRAVIS_BUILD_DIR}/${FILE_PATH}/'); rmarkdown::render('${FILE_NAME}')"
done

#--------------------------------------------------------
# build new/changed lectures and homeworks from Rmd 
#--------------------------------------------------------
# run python script
${TRAVIS_BUILD_DIR}/website/make_lecture_data.py ${TRAVIS_BUILD_DIR}
