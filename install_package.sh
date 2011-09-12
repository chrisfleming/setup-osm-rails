#!/bin/bash

SRC=/home/osm/src/
BASEDIR="$( cd "$( dirname "$0" )" && pwd )"

echo $BASEDIR

mkdir -p $SRC


sudo apt-get -y install ruby rdoc ri irb libxml2-dev libxslt1-dev ruby-dev apache2-dev libmagick9-dev build-essential libopenssl-ruby subversion apache2 postgresql postgresql-contrib
sudo apt-get -y install git-core

# GET RubyGems


cd $SRC
wget http://files.rubyforge.vm.bytemark.co.uk/rubygems/rubygems-1.3.7.tgz
echo "Extracting rubygems"
tar -xzf rubygems-1.3.7.tgz 
cd rubygems-1.3.7/
sudo ruby setup.rb 
sudo ln -s /usr/bin/gem1.8 /usr/bin/gem
cd ..
rm rubygems-1.3.7.tgz


# GET source
echo "Getting OSM Source"
cd  $SRC
git clone git://git.openstreetmap.org/rails.git

# Postgres Setup
echo "Setting up postgres"
sudo apt-get install postgresql-contrib libpq-dev
sudo su postgres -c "/usr/bin/psql < $BASEDIR/setup_user_databases.sql" 
sudo su postgres -c "/usr/bin/psql -d openstreetmap < /usr/share/postgresql/8.4/contrib/btree_gist.sql"


cp $BASEDIR/database.yml $SRC/rails/config/database.yml

cd $SRC/rails
# Get the GEMS Needed
echo "Getting the gems installed"
sudo gem install -v=2.3.14 rails 
sudo gem install timecop
sudo gem install pg
sudo gem install ruby-openid
sudo gem install rack-openid
sudo gem install oauth

# Setup Rails Port
echo "Setup the rails port"
cd $SRC/rails
cp config/example.application.yml config/application.yml

# Because I run the gems install as root, I need to create the logs files in advance
# So that they're not root owned.
mkdir $SRC/rails/log
touch $SRC/rails/log/development.log
touch $SRC/rails/log/test.log
chmod 0666 $SRC/rails/log/*.log

sudo rake gems:install

rake db:migrate

rake test
 




