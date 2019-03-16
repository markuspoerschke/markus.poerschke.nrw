FROM markuspoerschke/hugo AS HUGO

# copy files and build site
ADD . /app
RUN ls -lah /usr/local/bin/
RUN /usr/local/bin/hugo version
RUN /usr/local/bin/hugo --source=/app --destination=/public

FROM nginx:stable-alpine
COPY --from=HUGO /public/ /usr/share/nginx/html/
EXPOSE 80
