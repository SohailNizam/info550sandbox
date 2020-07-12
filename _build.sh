#! /bin/bash

#--------------------------------------------------------
# build new/changed lectures and homeworks from Rmd 
#--------------------------------------------------------

# finds all .Rmd lecture files
RMD_LECTURE_FILES=$(find "lectures" -type f -name "*.Rmd")
# finds all .Rmd homework files
RMD_HOMEWORK_FILES=$(find "homework" -type f -name "*.Rmd")

# build Rmd files using Rmarkdown
for RMD_FILE in ${RMD_LECTURE_FILES}
do 
	FILE_PATH=${RMD_FILE%/*}
	FILE_NAME=${RMD_FILE##*/}
	Rscript -e "setwd('${TRAVIS_BUILD_DIR}/${FILE_PATH}/'); rmarkdown::render('${FILE_NAME}')"
done

# build Rmd files using Rmarkdown
for RMD_FILE in ${RMD_HOMEWORK_FILES}
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
