sudo add-apt-repository -y ppa:nilarimogard/webupd8 # https://askubuntu.com/questions/351499/solution-to-no-ultimately-trusted-keys-found
sudo apt-get update

sudo apt-get install -y launchpad-getkeys
sudo launchpad-getkeys

sudo apt install -y gnupg2
gpg2 --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

curl -L get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.6.3

# --------------------------------

sudo apt-get install -y nginx

sudo apt-get install -y dirmngr gnupg
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
sudo apt-get install -y apt-transport-https ca-certificates

sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger bionic main > /etc/apt/sources.list.d/passenger.list'
sudo apt-get update

sudo apt-get install -y libnginx-mod-http-passenger

sudo service nginx restart

# --------------------------------

sudo apt-get install -y libpq-dev

# --------------------------------

curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn

# --------------------------------
