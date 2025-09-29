# Étape 1 : Build
FROM node:20-alpine AS builder
WORKDIR /app

# Copie des fichiers package.json et lock pour installer les deps
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le reste du projet
COPY . .

# Build de l'application Next.js
RUN npm run build

# Étape 2 : Exécution
FROM node:20-alpine AS runner
WORKDIR /app

# Installer uniquement les dépendances de prod
COPY package*.json ./
RUN npm install --omit=dev

# Copier les fichiers nécessaires au runtime
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/next.config.js ./next.config.js

EXPOSE 3000
CMD ["npm", "start"]
