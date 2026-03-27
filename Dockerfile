# Forcer architecture compatible
FROM --platform=linux/amd64 node:18 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install --legacy-peer-deps

COPY . .
RUN npm run build --prod

FROM --platform=linux/amd64 nginx:alpine

# ⚠️ remplace par ton vrai nom Angular
COPY --from=build /app/dist/angular-app /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]