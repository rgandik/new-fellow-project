// Importing required modules for Express API calls, Firebase authentication and database access, and Swagger API documentation
const express = require("express");
const admin = require("firebase-admin");
const swaggerJsDoc = require("swagger-jsdoc");
// Version 4.3.0 of swagger-ui-express installed to prevent issues with Swagger rendering when hosted on Vercel
const swaggerUi = require("swagger-ui-express");
// Swagger API documentation stored as a json file
const swagger = require("./swagger.json");
const bodyParser = require("body-parser");
const cors = require("cors");

require("dotenv").config();

const app = express();

const db = require("./firebase");

// Middlewares to handle cross-origin requests and to parse the body of incoming requests to JSON
app.use(cors());
app.use(bodyParser.json());

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
    customCss: '.swagger-ui .opblock .opblock-summary-path-description-wrapper { align-items: center; display: flex; flex-wrap: wrap; gap: 0 10px; padding: 0 10px; width: 100%; }',
    customCssUrl:
      "https://cdnjs.cloudflare.com/ajax/libs/swagger-ui/4.1.0/swagger-ui.min.css",
  })
);

// POST: Endpoint to add a new user's profile
app.post("/users", async (req, res) => {
  try {
    // Sets the data object to the provided key-value pairs in the request body
    const data = {
      "uid": req.body.uid,
      "name": req.body.name ?? "null",
      "birthday": req.body.birthday ?? "null",
      "gender": req.body.gender ?? "null",
      "school": req.body.school ?? "null",
      "icity": req.body.icity ?? "null",
      "icompany": req.body.icomponay ?? "null",
      "irole": req.body.irole ?? "null",
    }

      // Makes the POST request to the database with contents of data object
      const snapshot = await db.collection("users").doc(data.uid).set(data, { merge: true });
      
      // Response with data from POST request and Firestore-generated ID (201 for POST)
      res.status(201).send(snapshot);
  } catch(error) {
    // In case of an error with request, sends an error message instead
    res.status(500).send(error.message);
  }
})

app.listen(4000, () => {
  console.log("Server running on port 4000");
});