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
db.settings({ ignoreUndefinedProperties: true });

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
      "birthday": {
        "day": Number(req.body.day),
        "month": Number(req.body.month),
        "year": Number(req.body.year)
      },
      "company": req.body.company,
      "interests": req.body.interests,
      "location": {
        "latitude": Number(req.body.latitude),
        "longitude": Number(req.body.longitude)
      },
      "name": req.body.name,
      "pfp": req.body.pfp,
      "school": req.body.school,
      "uid": req.body.uid
    }

    // Makes the POST request to the database with contents of data object
    const snapshot = await db.collection("users").doc(data.uid).set(data, { merge: true });

    // Response with data from POST request and Firestore-generated ID (201 for POST)
    res.status(201).send("Profile created");
  } catch(error) {
    // In case of an error with request, sends an error message instead
    res.status(500).send(error.message);
  }
})

// PUT: Endpoint to update an existing user's profile
app.put("/users/:user", async (req, res) => {
  try {
    const user = req.params.user

    const data = {
      "birthday": {
        "day": Number(req.body.day),
        "month": Number(req.body.month),
        "year": Number(req.body.year)
      },
      "company": req.body.company,
      "interests": req.body.interests,
      "location": {
        "latitude": Number(req.body.latitude),
        "longitude": Number(req.body.longitude)
      },
      "name": req.body.name,
      "pfp": req.body.pfp,
      "school": req.body.school
    }

    // Makes the PUT request to the database with contents of data object
    const snapshot = await db.collection("users").doc(user).set(data, { merge: true });

    // Response with data from POST request and Firestore-generated ID (201 for POST)
    res.status(201).send("Profile updated");
  } catch(error) {
    // In case of an error with request, sends an error message instead
    res.status(500).send(error.message);
  }
})

// GET: Endpoint to pull a specific user's profile
app.get("/users/:user", async (req, res) => {
  try {
    // Sets the user variable to the query parameter provided in the request URL
    const user = req.params.user

    // Fetching profile data from "users" for a specific user
    const snapshot = await db.collection("users").doc(user).get();

    // Response sent with the data recorded in tasks array (200 for GET)
    res.status(200).send(snapshot.data());
  }  catch (error) {
    // In case of an error with request, sends an error message instead
    res.status(500).send(error.message);
  }
})

// POST: Endpoint to create a new group
app.post("/groups", async (req, res) => {
  try {
    // Sets the data object to the provided key-value pairs in the request body
    const data = {
      "activity": req.body.activity,
      "categories": req.body.categories,
      "description": req.body.description,
      "location": {
        "latitude": Number(req.body.latitude),
        "longitude": Number(req.body.longitude)
      },
      "time": {
        "day": Number(req.body.day),
        "month": Number(req.body.month),
        "year": Number(req.body.year),
        "hour": Number(req.body.hour),
        "minute": Number(req.body.minute)
      },
      "size": Number(req.body.size),
      "users": req.body.users
    }  
  
    // Makes the POST request to the database with the contents of the data object
    const snapshot = await db.collection("groups").doc().set(data, { merge: true });

    // Reponse with data from POST request and Firestore-generated ID (201 for POST)
    res.status(201).send("Circle created");
  } catch(error) {
    // In case of an error with request, sends an error message instead
    res.status(500).send(error.message);
  }
})

app.listen(4000, () => {
  console.log("Server running on port 4000");
});