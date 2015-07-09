FROM alpine:3.2

ENV GEM_DEPENDENCIES="https://github.com/shreeve/gemdeps-alpine-3.2-x86_64-2.2.0/blob/master/INDEX.yaml"

RUN echo "gem: --no-document" > /etc/gemrc && \
    apk update && \
    apk add bash git nginx openssh ca-certificates tzdata && \
    apk add ruby ruby-bigdecimal ruby-io-console && \
    gem install gem-dependencies && \
    gem update --system && \
    gem update && \
    gem install bundler && \
    rm -rf /var/cache/apk/*

RUN git clone --branch 3.0-stable --depth 1 https://github.com/redmine/redmine.git /app && \
    cp /app/config/configuration.yml.example /app/config/configuration.yml

WORKDIR /app

COPY config/Gemfile.local ./
COPY config/database.yml ./config/

RUN RUBYOPT="-rrubygems/gem_dependencies" bundle install --without development test && \
    rm -rf /var/cache/apk/*

COPY config/secret_token.rb ./config/initializers/

EXPOSE 8080

CMD ["bundle", "exec", "unicorn"]
