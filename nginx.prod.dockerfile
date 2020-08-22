##### Stage 1
FROM node:latest as node
LABEL author="Ousama EL IDRISSI"
WORKDIR /app
COPY package.json package.json
RUN yarn
COPY . .
RUN yarn run build -- --prod

##### Stage 2
FROM nginx:alpine
VOLUME /var/cache/nginx
COPY --from=node /app/dist /usr/share/nginx/html
COPY ./config/nginx.conf /etc/nginx/conf.d/default.conf

# docker build -t nginx-angular:prod -f nginx.prod.dockerfile .
# docker run -p 8080:80 nginx-angular:prod