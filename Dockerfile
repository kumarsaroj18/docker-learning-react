FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .

RUN npm install

RUN mkdir node_modules/.cache && chmod -R 777 node_modules/.cache

COPY . .

RUN npm run build
FROM nginx:latest
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# default command for nginx container is to start the server, so we don't need to explictily start the server