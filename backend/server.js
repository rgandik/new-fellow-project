const express = require("express");
const app = express();

const swaggerJsDoc = require("swagger-jsdoc");
const swaggerUi = require("swagger-ui-express");

require("dotenv").config();

const firebase = require("./firebase");
const db = firebase.firestore;

app.listen(4000, () => {
  console.log("Server running on port 4000");
});

// Test API routes

app.get("/pfp", async (req, res) => {
  res.status(200).send('Success')
})