# docker-redmine

### How to generate the ```secret_token.rb``` file

```shell
name="RedmineApp::Application.config.secret_key_base"
echo "$name='$(openssl rand -base64 32)'" > config/secret_token.rb
```
