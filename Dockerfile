FROM node:9.5.0 as build
WORKDIR /build
COPY npm-shrinkwrap.json npm-shrinkwrap.json
COPY package.json package.json
RUN npm set progress=false \
  && npm config set depth 0 \
  && npm i --production --only=production --loglevel=error \
  && rm -f ./.npmrc
# App Files
COPY config config
COPY dist dist

# Runtime
FROM node:9.5.0
WORKDIR /opt
EXPOSE 8080/tcp
ENTRYPOINT ["node", "dist/Server.js"]
COPY --from=build /build /opt
