Ruby On Rails X Postgres X Mina
===============================
This is a repo that use mina deployment
Task to be prepared
```bash
- Mina
sudo mkdir /var/www/postgres
chown -R deploy /var/www/postgres
touch /shared/config/database.yml, secrets.yml

- change sudoers to without password, so when do e.g. sudo service nginx restart no need to be prompted
%sudo   ALL=(ALL:ALL) NOPASSWD: ALL

- POSTGRESQL
sudo su - postgres
createuser --interactive
psql
ALTER ROLE user WITH PASSWORD 'password';

- NGINX /etc/nginx/sites-enabled/default
server {
        listen 80;
        passenger_enabled on;
        rails_env production;
        root /var/www/ror_postgres/current/public;
}

```
