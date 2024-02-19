const admin = require("firebase-admin");
require("dotenv").config();

const creds = JSON.parse(process.env.FIREBASE_CREDENTIALS);

admin.initializeApp({
  credential: admin.credential.cert(creds),
  databaseURL: `https://${process.env.FIREBASE_PROJECT_ID}.firebaseio.com`,
});

const db = admin.firestore();


const auth = (req, res, next) => {
  try {
    const tokenId = req.get("Authorization").split("Bearer ")[1];
    return admin
      .auth()
      .verifyIdToken(tokenId)
      .then((decoded) => {
        req.token = decoded;
        next();
      })
      .catch((err) => res.status(401).send(err));
  } catch (e) {
    res.status(400).send("Errors");
  }
};

module.exports = db;