FROM alpine:3.6 as HUGO

# Download and install hugo
ENV HUGO_VERSION 0.50
ENV HUGO_BINARY hugo_${HUGO_VERSION}_linux-64bit

# Install pygments (for syntax highlighting)
RUN apk update && apk add py-pygments && apk add git && apk add bash && rm -rf /var/cache/apk/*
RUN apk update && apk add nodejs && apk add yarn && yarn global add postcss-cli

# Download and Install hugo
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}.tar.gz /usr/local/
RUN tar xzf /usr/local/${HUGO_BINARY}.tar.gz -C /usr/local/bin/ \
    && rm /usr/local/${HUGO_BINARY}.tar.gz

# copy files and build site
ADD . /app
RUN hugo version
RUN hugo --source=/app --destination=/public

FROM nginx:stable-alpine
COPY --from=HUGO /public/ /usr/share/nginx/html/
EXPOSE 80
