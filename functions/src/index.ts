const admin = require("firebase-admin");
const functions = require("firebase-functions");
// The Cloud Functions for Firebase SDK to set up triggers and logging.
const {onSchedule} = require("firebase-functions/v2/scheduler");
const {logger} = require("firebase-functions");
// const bodyParser = require("body-parser")
import config from "./config";

admin.initializeApp({
  credential: admin.credential.cert(config.firebaseConfig),
  storageBucket: 'gs://straeto-2c817.appspot.com',
});

import { Request, Response } from "express";

const { onTicketCreateProd, onTicketCreateDev } = require("./triggers/ticket");
const { onTripCreateProd, onTripCreateDev } = require("./triggers/trip");
const { transactionsScheduler } = require("./utils/scheduler");

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
app.use("/utils/notifications", require("./routes/utils/email"));

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


// Run once a day at midnight, to clean up the users
// Manually run the task here https://console.cloud.google.com/cloudscheduler
exports.transactionsCleanUp = onSchedule("every 15 minutes", async (event) => {
  // Fetch all user details.
  await transactionsScheduler(),

  logger.log("finished");
});


exports.newTripProd = functions.firestore
  .document(`trips/{any}`)
  .onCreate(async (snapshot, context) => {
    const data = snapshot.data();
    await onTripCreateProd({
      data: data,
      snapshot: snapshot,
      context: context,
    });
  });

exports.newTripDev = functions.firestore
  .document(`test_trips/{any}`)
  .onCreate(async (snapshot, context) => {
    const data = snapshot.data();
    await onTripCreateDev({
      data: data,
      snapshot: snapshot,
      context: context,
    });
  });

exports.newTicketProd = functions.firestore
  .document(`tickets/{any}`)
  .onCreate(async (snapshot, context) => {
    const data = snapshot.data();
    await onTicketCreateProd({
      data: data,
      snapshot: snapshot,
      context: context,
    });
  });

exports.newTicketDev = functions.firestore
  .document(`test_tickets/{any}`)
  .onCreate(async (snapshot, context) => {
    const data = snapshot.data();
    await onTicketCreateDev({
      data: data,
      snapshot: snapshot,
      context: context,
    });
  });


exports.busStopApi = functions.https.onRequest(app);
