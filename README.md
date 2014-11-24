Ruby On Rails X Postgres X Mina
===============================
This is a repo that use mina deployment
Task to be prepared

###VPS
- Create user
```bash
sudo adduser deploy
sudo adduser deploy sudo
su deploy
cd
```
- SSH WITHOUT PASSWORD
```bash
ssh-copy-id deploy@host
```
- Package Install
```bash
sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties nodejs 
```

```bash
IMAGE MAGICK
sudo apt-get install image imagemagick php5-imagick 
```
- Ruby RBENV
```bash
cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

rbenv install 2.1.3
rbenv global 2.1.3
ruby -v
```
- Tell RubyGems dont install doc
```bash
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
```

- NGINX PASSENGER
```bash
# Install Phusion's PGP key to verify packages
gpg --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
gpg --armor --export 561F9B9CAC40B2F7 | sudo apt-key add -

# Add HTTPS support to APT
sudo apt-get install apt-transport-https

# Add the passenger repository
sudo sh -c "echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main' >> /etc/apt/sources.list.d/passenger.list"
sudo chown root: /etc/apt/sources.list.d/passenger.list
sudo chmod 600 /etc/apt/sources.list.d/passenger.list
sudo apt-get update

# Install nginx and passenger
sudo apt-get install nginx-full passenger
```

- Nginx.conf 
```bash
sudo vim /etc/nginx/nginx.conf
passenger_root /usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini;
passenger_ruby /usr/bin/ruby;
```
- POSTGRESQL
```bash
sudo apt-get install postgresql postgresql-contrib libpq-dev
sudo su - postgres
createuser --interactive
psql
ALTER ROLE user WITH PASSWORD 'password';
```
- Sudo without prompt password
```bash
%sudo   ALL=(ALL:ALL) NOPASSWD: ALL
```

- NGINX /etc/nginx/sites-enabled/default
```bash
server {
        listen 80;
        passenger_enabled on;
        rails_env production;
        root /home/deploy/ror_postgres/current/public;
}
```
- MINA Setup
```bash
sudo mkdir /var/www/postgres
chown -R deploy /var/www/postgres
touch /shared/config/database.yml, secrets.yml
```

- MONIT delayed_job configuration
```bash
/etc/monit/conf.d/file_name
check process delayed_job with pidfile /home/deploy/ror_postgres/current/tmp/pids/delayed_job.pid
    start program = "/bin/su - deploy && /bin/bash -c 'cd /home/deploy/ror_postgres/current && PATH=/home/deploy/.rbenv/bin:/home/deploy/.rbenv/shims:$PATH RAILS_ENV=production ./bin/delayed_job start'" with timeout 280 seconds
    stop program = "/bin/su - deploy && /bin/bash -c 'cd /home/deploy/ror_postgres/current && PATH=/home/deploy/.rbenv/bin:/home/deploy/.rbenv/shims:$PATH RAILS_ENV=production ./bin/delayed_job stop" with timeout 280 seconds
```
