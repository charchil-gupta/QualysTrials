#!/bin/sh -l

SCANFOLDER=$1

echo "Action triggered by $GITHUB_EVENT_NAME event"

if [ $GITHUB_EVENT_NAME = "push" ] || [ $GITHUB_EVENT_NAME = "pull_request" ]
then
    if [ $(git diff --name-only --diff-filter=ACMRT HEAD^ HEAD | wc -l) -eq "0" ]; then 
        echo "There are no files/folders to scan."
        exit 0
    else
        echo "Below files will be included in scan"
        git diff --name-only --diff-filter=ACMRT HEAD^ HEAD
        foldername="qiacscanfolder_$(date +%Y%m%d%H%M%S)"
        mkdir $foldername
        cp --parents "$(git diff --name-only --diff-filter=ACMRT HEAD^ HEAD)" $foldername
        cd $foldername
        SCANFOLDER="."
    fi
else
    if [ "$SCANFOLDER" = "." ]
    then 
        echo "Scanning entire repository."
    else
        echo "Scan Directory Path is - $SCANFOLDER"
    fi
fi

 #Calling Iac CLI
 echo "Scanning Started at - $(date +"%Y-%m-%d %H:%M:%S")"
 qiac scan -a $URL -u $UNAME -p $PASS -d $SCANFOLDER -m json -n GitHubActionScan --tag [{\"BRANCH_NAME\":\"$GITHUB_REF\"},{\"REPOSITORY_NAME\":\"$GITHUB_REPOSITORY\"}] > /result.json
 echo "Scanning Completed at - $(date +"%Y-%m-%d %H:%M:%S")"
 #process result for annotation
 echo " "
 echo "\e[4mSCAN RESULT\e[0m"
 cd /
 cat result.json
 python resultParser.py result.json











