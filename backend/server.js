// Importing required modules for Express API calls, Firebase authentication and database access, and Swagger API documentation
const express = require("express");
const admin = require("firebase-admin");
const FieldValue = admin.firestore.FieldValue;
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

// Profiles

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

    res.status(201).send("Profile created");
  } catch (error) {
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

    const snapshot = await db.collection("users").doc(user).set(data, { merge: true });

    res.status(200).send("Profile updated");
  } catch (error) {
    res.status(500).send(error.message);
  }
})

// DELETE: Endpoint to delete a specific user's profile
app.delete("/users/:user", async (req, res) => {
  try {
    const user = req.params.user

    const snapshot = await db.collection("users").doc(user).delete();

    res.status(200).send("Profile deleted")
  } catch (error) {
    res.status(500).send(error.message);
  }
})

// GET: Endpoint to pull a specific user's full profile
// For logged-in user
app.get("/users/:user", async (req, res) => {
  try {
    // Sets the user variable to the query parameter provided in the request URL
    const user = req.params.user

    // Fetching profile data from "users" for a specific user
    const snapshot = await db.collection("users").doc(user).get();

    let profile = snapshot.data();

    res.status(200).send(profile);
  }  catch (error) {
    res.status(500).send(error.message);
  }
})

// GET: Endpoint to pull a specific user's public profile
// To view other user's profiles
app.get("/users/preview/:user", async (req, res) => {
  try {
    const user = req.params.user
    
    const snapshot = await db.collection("users").doc(user).get();

    // Removes secure information from pulled data
    // Currenly removes uid and location by setting preview equal to all other values
    let preview = {
      "name": snapshot.data().name,
      "school": snapshot.data().school,
      "company": snapshot.data().company,
      "pfp": snapshot.data().pfp,
      "birthday": snapshot.data().birthday,
      "interests": snapshot.data().interests
    }

    res.status(200).send(preview);
  } catch (error) {
    res.status(500).send(error.message);
  }
})

// Groups

// POST: Endpoint to create a new group
app.post("/groups", async (req, res) => {
  try {
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
      "users": req.body.users,
      "distance": req.body.distance,
      "platform": req.body.platform,
      "gcUrl": req.body.gcUrl
    }  
  
    const snapshot = await db.collection("groups").doc().set(data, { merge: true });

    res.status(201).send("Circle created");
  } catch (error) {
    res.status(500).send(error.message);
  }
})

// PUT: Endpoint to update an existing group
app.put("/groups/:group", async (req, res) => {
  try {
    const group = req.params.group

    const data = {
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
      }
    }

    const snapshot = await db.collection("groups").doc(group).set(data, { merge: true });

    res.status(200).send("Circle updated")
  } catch (error) {
    res.status(500).send(error.message);
  }
})

// DELETE: Endpoint to delete a specific group
app.delete("/groups/:group", async(req, res) => {
  try {
    const group = req.params.group

    const snapshot = await db.collection("groups").doc(group).delete();

    res.status(200).send("Circle deleted")
  } catch (error) {
    res.status(500).send(error.message);
  }
})

// PUT: Endpoint to add a user to an existing group
app.put("/groups/:user/:group", async (req, res) => {
  try {
    const user = req.params.user
    const group = req.params.group

    const data = {
      // Adds the user to the array of existing users in the group
      users: FieldValue.arrayUnion(user)
    }

    const snapshot = await db.collection("groups").doc(group).update(data, { merge: true });

    res.status(200).send("Circle joined");
  } catch (error) {
    res.status(500).send(error.message);
  }
})

// DELETE: Endpoint to remove a user from a group
app.delete("/groups/:user/:group", async (req, res) => {
  try {
    const user = req.params.user
    const group = req.params.group

    const data = {
      // Removes the user from the array of existing users in the group
      users: FieldValue.arrayRemove(user)
    }

    const snapshot = await db.collection("groups").doc(group).update(data, { merge: true });

    res.status(200).send("Circle left");
  } catch (error) {
    res.status(500).send(error.message);
  }
})

// GET: Endpoint to view all created groups
app.get("/groups", async (req, res) => {
  try {
    const snapshot = await db.collection("groups").get();

    let groups = [];
    snapshot.forEach((doc) => {
      groups.push(doc.data())
    })

    res.status(200).send(groups);
  } catch (error) {
    res.status(500).send(error.message);
  }
})

// GET: Endpoint to view a specific group
app.get("/groups/:group", async (req, res) => {
  try {
    const group = req.params.group

    // Fetching data for a specific group
    const snapshot = await db.collection("groups").doc(group).get();

    res.status(200).send(snapshot.data());
  } catch (error) {
    res.status(500).send(error.message);
  }
})

// GET: Endpoint to view all of the groups a specific user has joined
app.get("/groups/joined/:user", async (req, res) => {
  try {
    const user = req.params.user

    const snapshot = await db.collection("groups").where("users", "array-contains", user).get();

    let groups = [];
    snapshot.forEach((doc) => {
      groups.push(doc.data())
    })

    res.status(200).send(groups)
  } catch (error) {
    res.status(500).send(error.message);
  }
})

// GET: Endpoint to view all of the groups a specific user has created
app.get("/groups/created/:user", async (req, res) => {
  try {
    const user = req.params.user

    const snapshot = await db.collection("groups").where("users", "array-contains", user).get();

    let groups = [];
    snapshot.forEach((doc) => {
      if (doc.data().users[0] == user) {
        groups.push(doc.data())
      }
    })
    res.status(200).send(groups);
  } catch (error) {
    res.status(500).send(error.message);
  }
})

// GET: Endpoint to view groups with matching category
// Working on developing into universal sort (activity name, categories, school, company)
app.get("/groups/sorted/:category", async (req, res) => {
  try {
    const category = req.params.category

    const snapshot = await db.collection("groups").where("categories", "array-contains", category).get();

    let groups = [];
    snapshot.forEach((doc) => {
      groups.push(doc.data())
    })

    res.status(200).send(groups)
  } catch (error) {
    res.status(500).send(error.message);
  }
})

// GET: Endpoint to view groups containing user search as a substring
app.get("/groups/searched/:search", async (req, res) => {
  try {
    const search = req.params.search.toLowerCase()
    
    const snapshot = await db.collection("groups").get();

    let groups = [];
    snapshot.forEach((doc) => {
      if (doc.data().activity.toLowerCase().includes(search)) {
        groups.push(doc.data())
      }
    })

    res.status(200).send(groups)
  } catch (error) {
    res.status(500).send(error.message);
  }
})

app.listen(4000, () => {
  console.log("Server running on port 4000");
});