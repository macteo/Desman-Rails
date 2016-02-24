#!/bin/bash

sudo service puma-manager stop

cd web

rm -rf desman-old

mv desman desman-old
unzip desman.zip

cp -rf desman-old/public/uploads desman/public/
cp -rf desman-old/log desman/log
cp -r desman-old/config/secrets.yml desman/config/secrets.yml
cp -r desman-old/config/database.yml desman/config/database.yml
cp -r desman-old/config/apps_auth.yml desman/config/apps_auth.yml

cd desman

rm -rf public/assets

bundle
RAILS_ENV=production bundle exec rake db:migrate
RAILS_ENV=production bundle exec rake assets:precompile

sudo service puma-manager start

rm -rf ../desman-old
rm -rf ../desman.zip
