sudo add-apt-repository -y ppa:nilarimogard/webupd8 # https://askubuntu.com/questions/351499/solution-to-no-ultimately-trusted-keys-found
sudo apt-get update

sudo apt-get install -y launchpad-getkeys
sudo launchpad-getkeys

sudo apt install -y gnupg2
gpg2 --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB

curl -L get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.6.3
