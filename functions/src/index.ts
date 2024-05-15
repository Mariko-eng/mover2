const admin = require("firebase-admin");
const functions = require("firebase-functions");
// const bodyParser = require("body-parser")
import config from "./config";

admin.initializeApp({
  credential: admin.credential.cert(config.firebaseConfig),
  storageBucket: 'gs://straeto-2c817.appspot.com',
});

import { Request, Response } from "express";
const express = require("express");
const cors = require("cors");

// const PORT = 3000; // for local  Development
const app = express();
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
// app.use(bodyParser.urlencoded({extended:false}))

app.use("/auth", require("./routes/auth"));
app.use("/utils", require("./routes/utils"));

//test connection
app.get("/", (req: Request, res: Response) => {
  try {
    res.status(200).json({
      status: "Welcome to the Bus Stop API",
    });
  } catch (error) {
    res.status(500).json({
      details: "Something went wrong",
    });
  }
});

// For  Local Development
// app.listen(3000, () => {
//   console.log(`Local Development Server Started .... ${3000}`);
// });

exports.busStopApi = functions.https.onRequest(app);
