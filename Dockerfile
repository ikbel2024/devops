# Stage 1 : Build Angular
FROM node:16 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install --legacy-peer-deps

COPY . .

# ⚠️ build Angular (compatible toutes versions)
RUN npm run build || npm run build --prod

# Stage 2 : Nginx
FROM nginx:alpine

# Copier TOUT le contenu dist (évite erreur nom app)
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]