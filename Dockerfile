FROM alpine:3.2

ENV GEM_DEPENDENCIES="https://github.com/shreeve/gemdeps-alpine-3.2-x86_64-2.2.0/blob/master/INDEX.yaml"

RUN echo "gem: --no-document" > /etc/gemrc && \
    apk --update add ruby tzdata git && \
    gem install gem-dependencies && \
    gem update --system && \
    gem update && \
    gem install bundler io-console && \
    rm -rf /var/cache/apk/*

RUN git clone --branch 3.0-stable --depth 1 https://github.com/redmine/redmine.git /app/redmine && \
    cp /app/redmine/config/configuration.yml.example /app/redmine/config/configuration.yml

WORKDIR /app/redmine

COPY config/Gemfile.local ./
COPY config/database.yml ./config/

RUN RUBYOPT="-rrubygems/gem_dependencies" bundle install --without development test && \
    rm -rf /var/cache/apk/*

COPY config/secret_token.rb ./config/initializers/

EXPOSE 8080

CMD ["bundle", "exec", "unicorn"]
