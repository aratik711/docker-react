FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN echo "104.16.19.35 registry.npmjs.org" >> /etc/hosts && \
    npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html