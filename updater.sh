sudo apt-get update
sudo apt-get -y upgrade
cd /vagrant
bundle
rake db:migrate
