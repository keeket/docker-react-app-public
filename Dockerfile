# definieer bouw fase om enkel de /app/build map naar productie te deployen in latere stap
FROM node:16-alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# met iedere nieuwe FROM wordt het voorgaande proces gestopt, ws vergelijkbaar met tijdelijke images tijdesn een docker build 
FROM nginx 

# kopieer build map van vorige stage naar specifieke nginx serve map
COPY --from=builder /app/build /usr/share/nginx/html