# ---- ÉTAPE 1 : BUILD DU CODE SOURCE ----
FROM node:18-alpine AS build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
# Commande qui génère le dossier /app/dist
RUN npm run build 

# --- ÉTAPE 2 : SERVEUR DE PRODUCTION ---
FROM nginx:stable-alpine
# On copie uniquement le dossier /dist généré à l'étape 1 vers Nginx
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
