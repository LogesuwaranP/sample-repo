FROM node:24-alpine AS build

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci

COPY . .

RUN npm run build


FROM node:24-alpine AS runtime

WORKDIR /app

COPY package.json ./
COPY server.js ./
COPY --from=build /app/dist ./dist

USER node

EXPOSE 3000

CMD ["node", "server.js"]