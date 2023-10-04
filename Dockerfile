FROM node:18.13.0-alpine AS deps

ARG NEXT_PUBLIC_BARIKOI_API_KEY
ARG NEXT_PUBLIC_BASE_URL

ENV NEXT_PUBLIC_BARIKOI_API_KEY=${NEXT_PUBLIC_BARIKOI_API_KEY}
ENV NEXT_PUBLIC_BASE_URL=${NEXT_PUBLIC_BASE_URL}
ENV SKIP_HUSKY=1

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci

COPY . .

RUN npm run build

RUN npx next telemetry disable

EXPOSE 3000

CMD [ "npm", "run", "start"]
