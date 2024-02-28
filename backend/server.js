// Importing required modules for Express API calls, Firebase authentication and database access, and Swagger API documentation
const express = require("express");
const firebase = require("./firebase");
const swaggerJsDoc = require("swagger-jsdoc");
// Version 4.3.0 of swagger-ui-express installed to prevent issues with Swagger rendering when hosted on Vercel
const swaggerUi = require("swagger-ui-express");
// Swagger API documentation stored as a json file
const swagger = require("./swagger.json");

require("dotenv").config();

const app = express();

// Might be equivalent to const db = require("./firebase");
const db = firebase.firestore;

// Swagger configuration
const swaggerOptions = {
  // Rendered elements (may need to be updated when editing API routes)
  definition: swagger,
  apis: ["./swagger.json"], // Path to the API docs
};

// Swagger middleware
const swaggerDocs = swaggerJsDoc(swaggerOptions);
app.use(
  "/api-docs",
  swaggerUi.serve,
  swaggerUi.setup(swaggerDocs, {
    customCSS: '.swagger-ui .opblock .opblock-summary-path-description-wrapper { align-items: center; display: flex; flex-wrap: wrap; gap: 0 10px; padding: 0 10px; width: 100%; }',
    customCssUrl:
      "https://cdnjs.cloudflare.com/ajax/libs/swagger-ui/4.1.0/swagger-ui.min.css",
  })
);

// Test API routes (preceded by Swagger documentation)
app.get("/test", async (req, res) => {
  try {
    res.status(200).send('Success')
  } catch {
    res.status(500).send(error.message)
  }
});

app.listen(4000, () => {
  console.log("Server running on port 4000");
});