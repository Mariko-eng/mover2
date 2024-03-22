const admin = require("firebase-admin");
// const functions = require("firebase-functions");
import config from "./config";

// console.log(config.firebaseConfig)

admin.initializeApp({
  credential: admin.credential.cert(config.firebaseConfig),
});


console.log("Here 1")

const usersRef = admin.firestore().collection("users");

console.log(usersRef)
