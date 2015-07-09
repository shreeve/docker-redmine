# docker-redmine

### Running an ephemeral instance

```
docker run -it --rm \
  -e DATABASE_URL=mysql2://myuser:mypass@myhost:3306/redmine?encoding=utf8 \
  -p 8080:8080 shreeve/redmine
```

### Using a specific session token

Redmine uses a token to encrypt session data. If you have only one Redmine
instance and you don't care if user sessions will get nuked each time Redmine
launches, then you do not have to do anything. If, however, you are running
a cluster of Redmine instances or you would like to preserve user sessions
across restarts, then set the following variable:

```
REDMINE_SECRET=$(openssl rand -base64 32)
```
