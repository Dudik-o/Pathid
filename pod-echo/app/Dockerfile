FROM node:20-alpine
WORKDIR /app

# Create package.json inside the container
RUN npm init -y && npm install express --omit=dev

COPY . .
ENV PORT=8080
EXPOSE 8080
CMD ["node", "app.js"]