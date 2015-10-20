#!/bin/bash

sudo service desman stop

rm -rf desman-old

mv desman desman-old
unzip desman.zip

cp -rf desman-old/public/uploads desman/public/
cp -rf desman-old/log desman/log
cp -rf desman-old/db/production.sqlite3 desman/db

cd desman

rm -rf public/assets

bundle
RAILS_ENV=production bundle exec rake db:migrate
RAILS_ENV=production bundle exec rake assets:precompile


sudo service desman start

rm -rf ../desman-old
rm -rf ../desman.zip
