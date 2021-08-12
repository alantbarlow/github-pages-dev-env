
FROM ruby:2.7.3-alpine AS base

ENV GEM_HOME="/usr/local/bundle/"
ENV PATH $GEM_HOME/bin:$GEM_HOME/gems/bin:$PATH
ENV GITHUB_PAGES_VERSION="217"

FROM base AS build

RUN apk --update add --no-cache --virtual run-dependencies build-base=0.5-r2 \
    && gem install github-pages:"$GITHUB_PAGES_VERSION"

FROM base

RUN adduser -D dev

USER dev

COPY --from=build $GEM_HOME $GEM_HOME