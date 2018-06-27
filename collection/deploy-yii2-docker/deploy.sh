#!/bin/bash

# function to display commands
exe() { echo "\$ $@" ; "$@"; }
remote() { exe ssh ${targetUser}@${targetHost} ${@}; }

# load variables from .env file
export $(cat .env | xargs)

# local configuration
localPath="$(pwd)"

# project configuration
projectName=${NAME}

# target configuration
targetUser=${DEPLOY_USER}
targetHost=${DEPLOY_HOST}
targetPath=${DEPLOY_PATH}


# ask if you want to deploy
read -p 'Do you wish to deploy this project to production (y/n)? ' answer
case ${answer:0:1} in
    y|Y )
        echo Yes;
    ;;
    * )
        echo Stopping...;
        exit;
    ;;
esac


# process deploy
echo "Deploying project ${projectName} to the ${targetHost} with user ${targetUser}..."

echo "\nStepping into root folder..."
exe cd ${localPath}

echo "\nGetting list of files under the git ignore..."
gitExcludesString=`git -C ${localPath} ls-files --exclude-standard -oi`
IFS=$'\n' ignore=($gitExcludesString)

echo "\nAppending git files..."
ignore+=('.git' '.gitignore' '.gitkeep')

echo "\nBuilding temporary file for the list of excluded files..."
pathToExcludeFIle="${localPath}/.deploy.log"
excludesString=$(printf "%s\\\n" "${ignore[@]}")
echo $excludesString > ${pathToExcludeFIle}

echo "\nSyncing project folder without files under gitignore..."
exe rsync -a --exclude-from=$pathToExcludeFIle ${localPath}/ ${targetUser}@${targetHost}:${targetPath}

echo "\nDropping temporary file..."
exe rm $pathToExcludeFIle

echo "\nLoading container env variables locally..."
exe set -a && . ${DEPLOY_VARIABLES} && set +a

echo "\nUpping new containers..."
remote "cd ${targetPath} && docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d"

echo "\nRunning migrations inside the container..."
remote "cd ${targetPath} && docker-compose run --rm php php yii migrate --interactive=0"

echo "\nResetting web assets..."
remote "cd ${targetPath} && rm -rf ./app/web/assets/*"

echo "\nComplete!"
