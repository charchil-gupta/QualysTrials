#!/bin/sh -l

#echo "action_state=`git log -n 2 --pretty=format:"%H" | tail -1`" >> $GITHUB_ENV
#git diff --name-only --diff-filter=ACMRT ${{ github.sha }} ${{ env.action_state }}

rm -rf ./scan

mkdir scan

#validate
find . -name \*.tf -o -name  \*.template -o -name \*.yml -o -name \*yaml -o -name \*.json | xargs -I '{}' cp {} ./scan

#call cli
qiac scan -a $URL -u $UNAME -p $PASS -d ./scan --format json -n charchiltagtest --tag [{\"BRANCH_NAME\":\"$GITHUB_REF\"}] > result.json

ls -ltr

cat result.json

#process result for annotation
python pythonscript.py result.json





