FROM alpine

RUN apk --update add redmine ruby-unicorn ruby-mysql2 && rm -rf /var/cache/apk/*

WORKDIR /usr/share/webapps/redmine
COPY config/database.yml  ./config/
COPY config/Gemfile.local ./

EXPOSE 8080
CMD ["bundle", "exec", "unicorn"]
