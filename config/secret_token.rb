RedmineApp::Application.config.secret_key_base= ENV['REDMINE_SECRET'] || `openssl rand -base64 32`.chomp
