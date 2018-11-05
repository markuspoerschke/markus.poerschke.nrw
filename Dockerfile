FROM ubuntu as HUGO

# Download and install hugo
ENV HUGO_VERSION 0.49.1
ENV HUGO_BINARY hugo_extended_${HUGO_VERSION}_linux-64bit

# Install pygments (for syntax highlighting)
RUN apt-get update \
    && apt-get install -y \
        python3-pygments  \
        git \
        bash \
        nodejs \
        npm \
        curl \
        openssh-client \
        rsync

RUN npm install -g postcss-cli autoprefixer

RUN curl -L https://bin.equinox.io/c/dhgbqpS8Bvy/minify-stable-linux-amd64.tgz | tar -xz \
    && mv minify /usr/local/bin/

# Download and Install hugo
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}.tar.gz /usr/local/
RUN tar xzf /usr/local/${HUGO_BINARY}.tar.gz -C /usr/local/bin/ \
    && rm /usr/local/${HUGO_BINARY}.tar.gz

# copy files and build site
ADD . /app
RUN ls -lah /usr/local/bin/
RUN /usr/local/bin/hugo version
RUN /usr/local/bin/hugo --source=/app --destination=/public

FROM nginx:stable-alpine
COPY --from=HUGO /public/ /usr/share/nginx/html/
EXPOSE 80
