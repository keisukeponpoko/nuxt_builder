FROM node:11.8.0-alpine
ENV LANG C.UTF-8

RUN mkdir /app
WORKDIR /app

ADD . /app
RUN npm i -g yarn

CMD yarn install && NUXT_HOST=0.0.0.0 yarn run dev
