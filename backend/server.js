// Importing required modules for Express API calls, Firebase authentication and database access, and Swagger API documentation
const express = require("express");
const firebase = require("./firebase");
const swaggerJsDoc = require("swagger-jsdoc");
// Version 4.3.0 of swagger-ui-express installed to prevent issues with Swagger rendering when hosted on Vercel
const swaggerUi = require("swagger-ui-express");

require("dotenv").config();

const app = express();

// Might be equivalent to const db = require("./firebase");
const db = firebase.firestore;

// Swagger configuration
const swaggerOptions = {
  // Rendered elements (may need to be updated when editing API routes)
  definition: {
    openapi: "3.0.0",
    info: {
      title: "MeetUp API",
      version: "1.0.0",
      description: "Skeleton API for MeetUp app. Built by TPEO",
    },
  },
  apis: ["./server.js"], // Path to the API docs
};

// Swagger middleware
const swaggerDocs = swaggerJsDoc(swaggerOptions);
app.use(
  "/api-docs",
  swaggerUi.serve,
  swaggerUi.setup(swaggerDocs, {
    customCssUrl:
      "https://cdnjs.cloudflare.com/ajax/libs/swagger-ui/4.1.0/swagger-ui.min.css",
  })
);

// Test API routes (preceded by Swagger documentation)

/**
 * @swagger
 * /test:
 *   get:
 *     summary: Tests API calls to backend
 *     description: Returns a message to demonstrate functionality of API calls to backend.
 *     responses:
 *       200:
 *         description: Returns "Success" to demonstrate that API calls can successfully be made to backend.
 *         content:
 *           text/plain:
 *             schema:
 *               type: string
 *               example: Success
 *       500:
 *         description: Server Error
 */
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