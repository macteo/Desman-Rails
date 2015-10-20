#!/bin/bash

cd ..
rm -rf desman
cp -Rf Desman-Rails desman
rm -rf desman/.git
rm -rf desman/.vagrant
rm -rf desman/public/assets
mkdir desman/public/assets
rm -rf desman/public/uploads
rm -rf desman/public/builds
rm -rf desman/tmp/pids
mkdir desman/tmp/pids
rm -rf desman/tmp/sessions
mkdir desman/tmp/sessions
rm -rf desman/tmp/sockets
mkdir desman/tmp/sockets
rm -rf desman/tmp/cache
mkdir desman/tmp/cache
rm -rf desman/log

rm desman.zip

zip -r desman.zip desman/*

scp desman.zip ec2ireland.macteo.it:~/

rm desman.zip
rm -rf desman
ssh ec2ireland.macteo.it < Desman-Rails/replace.sh
