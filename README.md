# docker-redmine

### Running an ephemeral instance

```
docker run -it --rm \
  -e DATABASE_URL=mysql2://myuser:mypass@myhost:3306/redmine?encoding=utf8 \
  -p 8080:8080 shreeve/redmine
```

### How to generate the ```secret_token.rb``` file

```shell
name="RedmineApp::Application.config.secret_key_base"
echo "$name='$(openssl rand -base64 32)'" > config/secret_token.rb
```
