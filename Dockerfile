# Stage 1 : Build Angular
FROM node:16 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install --legacy-peer-deps

COPY . .

RUN npm run build --prod

# Stage 2 : Nginx
FROM nginx:alpine

# ⚠️ IMPORTANT : remplace par le nom réel de ton app
COPY --from=build /app/dist/angular-app /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
