#!/bin/sh
# get the PhoneGapLib version
PGVER=`head -1 "${PHONEGAPLIB}/VERSION"`

SRC1="${PHONEGAPLIB}/javascripts/phonegap.${PGVER}.js"
SRC2="${PHONEGAPLIB}/javascripts/phonegap.${PGVER}.min.js"
TARGET="${PROJECT_DIR}/www"

# compile and copy PhoneGapLib
make -C "${PHONEGAPLIB}"
cp "${SRC1}" "${TARGET}"
cp "${SRC2}" "${TARGET}"

# replace [src="phonegap.js"] in all files in www
find "${TARGET}" | xargs grep 'src[ 	]*=[ 	]*[\\'\"]phonegap.*.*.js[\\'\"]' -sl | xargs -L1 sed -i "" "s/src[ 	]*=[ 	]*[\\'\"]phonegap.*.*.js[\\'\"]/src=\"phonegap.${PGVER}.min.js\"/g"
