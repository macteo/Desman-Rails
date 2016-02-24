#!/bin/bash

cd ..
rm -rf desman
cp -Rf Desman-Rails desman
rm -rf desman/.git
rm -rf desman/.vagrant
rm -rf desman/public/assets
mkdir desman/public/assets
rm -rf desman/public/uploads
rm -rf desman/tmp/pids
mkdir desman/tmp/pids
rm -rf desman/tmp/sessions
mkdir desman/tmp/sessions
rm -rf desman/tmp/sockets
rm -r config/secrets.yml
rm -r config/database.yml
rm -r config/apps_auth.yml
mkdir desman/tmp/sockets
rm -rf desman/tmp/cache
mkdir desman/tmp/cache
rm -rf desman/log

rm desman.zip

zip -r desman.zip desman/*

scp desman.zip bryan.dimension.it:~/web/

rm desman.zip
rm -rf desman
ssh bryan.dimension.it < Desman-Rails/replace.sh
