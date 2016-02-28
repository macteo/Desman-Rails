sudo add-apt-repository -y ppa:webupd8team/java
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
echo "deb http://packages.elastic.co/kibana/4.4/debian stable main" | sudo tee -a /etc/apt/sources.list.d/kibana-4.4.x.list
echo 'deb http://packages.elastic.co/logstash/2.2/debian stable main' | sudo tee /etc/apt/sources.list.d/logstash-2.2.x.list
sudo apt-get update

sudo apt-get -y upgrade
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

sudo apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev libmysqlclient-dev

sudo locale-gen UTF-8

echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections

sudo apt-get -y install oracle-java8-installer elasticsearch kibana nginx apache2-utils logstash

sudo nano /etc/elasticsearch/elasticsearch.yml
    # network.host: localhost
sudo service elasticsearch restart
sudo update-rc.d elasticsearch defaults 95 10

cd ~
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

rbenv install 2.3.0
rbenv global 2.3.0
ruby -v

echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler

sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install -y nodejs redis-server

gem install rails

rbenv rehash

# cd /vagrant
# bundle
# rake db:migrate


# TODO: Need to enable elasticsearch on localhost

# sudo nano /etc/elasticsearch/elasticsearch.yml
    # Decomment this line
    # network.host: localhost

# sudo service elasticsearch restart
# sudo service kibana restart

# Create Elasticsearch index
# curl -XPUT 'http://localhost:9200/events/'
