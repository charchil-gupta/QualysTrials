#/bin/sh -l
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
