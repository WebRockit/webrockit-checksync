#!/bin/sh

# include any additional steps that need to be followed, just prior to building the rpm here
# this script will be run from the target build target path

PROBLEMS=0
OLDPWD=`pwd`

mkdir -p ./etc/init.d
mv ./opt/webrockit-checksync/ext/webrockit-checksync.init ./etc/init.d/webrockit-checksync
rm -rf ./opt/webrockit-checksync/ext
chmod 755 ./etc/init.d/webrockit-checksync
mv ./opt/webrockit-checksync/config/config.yml.example ./opt/webrockit-checksync/config/config.yml
mkdir ./opt/webrockit-checksync/logs

if [ $? -ne 0 ]
then
    PROBLEMS=99
fi
cd ${OLDPWD}

if [ ${PROBLEMS} -ne 0 ]
then
    exit 1
else
    exit 0
fi
