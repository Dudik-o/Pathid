// app.js
const express = require("express");
const app = express();
const port = process.env.PORT || 8080;

const info = () =>
  `pod_name=${process.env.POD_NAME}\npod_ip=${process.env.POD_IP}\n`;

app.get("/", (_req, res) => res.type("text/plain").send(info()));
app.get("/info", (_req, res) => res.type("text/plain").send(info()));  // <- add this
app.get("/health", (_req, res) => res.status(200).send("ok"));

app.listen(port, () => console.log(`listening on ${port}`));
