FROM node:20-alpine

WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install --production

COPY . .

RUN npm link  # để link CLI netrum toàn cục

ENTRYPOINT ["netrum"]
