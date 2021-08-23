#!/bin/sh -l

ls -ltr

SCANFOLDER=$1

echo "Action triggered by $GITHUB_EVENT_NAME event"

if [ $GITHUB_EVENT_NAME = "push" ] || [ $GITHUB_EVENT_NAME = "pull_request" ]
then
    echo "Below files will be included in scan"
    git diff --diff-filter=d HEAD^ HEAD --name-only
    mkdir scanfolder
    cp --parents $(git diff --name-only --diff-filter=ACMRT HEAD^ HEAD) scanfolder
    cd scanfolder
    echo "Scanning Started at - $(date +"%Y-%m-%d %H:%M:%S")"
    qiac scan -a $URL -u $UNAME -p $PASS -d $SCANFOLDER --format json -n GitHubActionScan --tag [{\"BRANCH_NAME\":\"$GITHUB_REF\"},{\"REPOSITORY_NAME\":\"$GITHUB_REPOSITORY\"}] > ../result.json
    echo "Scanning Completed at - $(date +"%Y-%m-%d %H:%M:%S")"
    #process result for annotation
    echo " "
    echo "\e[4mSCAN RESULT\e[0m"
    cd ..
    ls -ltr
    python resultParser.py result.json
else
    if [ "$SCANFOLDER" = "." ]
    then 
        echo "Scanning entire repository"
    else
        echo "Scan Directory Path is - $SCANFOLDER"
    fi

    #Calling Iac CLI
    echo "Scanning Started at - $(date +"%Y-%m-%d %H:%M:%S")"
    qiac scan -a $URL -u $UNAME -p $PASS -d $SCANFOLDER --format json -n GitHubActionScan --tag [{\"BRANCH_NAME\":\"$GITHUB_REF\"},{\"REPOSITORY_NAME\":\"$GITHUB_REPOSITORY\"}] > result.json
     echo "Scanning Completed at - $(date +"%Y-%m-%d %H:%M:%S")"
    #process result for annotation
    echo " "
    echo "\e[4mSCAN RESULT\e[0m"
    ls -ltr
    python resultParser.py result.json
fi











