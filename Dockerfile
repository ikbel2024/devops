# --- ÉTAPE 1 : COMPILATION ---
# On utilise Node 10 pour la compatibilité avec Angular 6/7
FROM node:10-alpine AS build-stage

WORKDIR /app

# Installation des dépendances
COPY package*.json ./
# --unsafe-perm est nécessaire pour compiler node-sass sur d'anciennes versions
RUN npm install --unsafe-perm

# Copie du code et Build
COPY . .
RUN npm run build --prod

# --- ÉTAPE 2 : SERVEUR DE PRODUCTION ---
FROM nginx:stable-alpine

# CORRECTION DU CHEMIN : 
# On récupère le contenu de dist/angular-app (selon votre angular.json)
COPY --from=build-stage /app/dist/angular-app /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
