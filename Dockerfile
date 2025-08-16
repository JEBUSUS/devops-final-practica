# Imagen base ligera de Node.js
FROM node:20-alpine AS base
WORKDIR /app

# Instalar dependencias de producción
COPY package*.json ./
RUN npm install --omit=dev && npm cache clean --force


# Copiar el código
COPY . .

# Exponer el puerto (Render usa la variable PORT)
EXPOSE 3000

# Comando de arranque
CMD ["node", "app.js"]
