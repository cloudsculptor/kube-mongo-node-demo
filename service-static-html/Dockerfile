#
#   WEB APP BUILD PIPELINE
#   ----------------------
#
#   This sample pipeline 'builds' a 'web app' in an Ubuntu 18.04 'build environment'
#   and then transfers the final 'app' to a stripped back production server ready
#   for deployment.
#

# Build environment
FROM ubuntu:18.04 AS build-env

# Fake build task
WORKDIR /build-dir
COPY index.src.html /build-dir
RUN cp index.src.html index.html

# Production environment
FROM httpd:2.4-alpine AS production-env

COPY --from=build-env /build-dir/index.html /usr/local/apache2/htdocs/

EXPOSE 80