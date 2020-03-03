#
#   MongoDB API Pipeline
#

# Build environment
FROM node:10 AS build-env

COPY package.json package.json
RUN npm install

# Production environment
FROM node:10-alpine AS production-env

COPY --from=build-env /node_modules /node_modules
COPY app.js .

EXPOSE 8080

CMD node app.js