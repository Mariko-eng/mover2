import * as admin from "firebase-admin";
const { sendEmailNotification } = require("./../../utils/email");

const onTripCreateProd = async ({ data, snapshot, context }) => {
    const companyId = data.companyId;
    let receiverEmails = [];

    const htmlBody = `<div><h1>${"New Trip Alert"}</h1><p>Trip : <b>${
        data.tripNumber}<b/></p><p>${"A New Trip Has Been Added!"}</p></div>`;

    const superAdminResults = await admin.firestore().collection("admin_accounts")
    .where("group", "==", "super_bus_admin")
    .get();

    const busAdminResults = await admin.firestore().collection("admin_accounts")
        .where("companyId", "==", companyId)
        .where("group", "==", "bus_admin")
        .get();

    for (let i = 0; i < superAdminResults.docs.length; i++) {
        const email = superAdminResults.docs[i].get("email");
        receiverEmails.push(email);
    }

    for (let i = 0; i < busAdminResults.docs.length; i++) {
        const email = busAdminResults.docs[i].get("email");
        receiverEmails.push(email);
    }

    await sendEmailNotification(receiverEmails, htmlBody);
};

const onTripCreateDev = async ({ data, snapshot, context }) => {
    const companyId = data.companyId;
    let receiverEmails = [];

    const htmlBody = `<div><h1>${"New Trip Alert"}</h1><p>Trip : <b>${
        data.tripNumber}<b/></p><p>${"A New Trip Has Been Added!"}</p></div>`;

    const superAdminResults = await admin.firestore().collection("test_admin_accounts")
    .where("group", "==", "super_bus_admin")
    .get();

    const busAdminResults = await admin.firestore().collection("test_admin_accounts")
    .where("companyId", "==", companyId)
    .where("group", "==", "bus_admin")
    .get();

    for (let i = 0; i < superAdminResults.docs.length; i++) {
        const email = superAdminResults.docs[i].get("email");
        receiverEmails.push(email);
    }

    for (let i = 0; i < busAdminResults.docs.length; i++) {
        const email = busAdminResults.docs[i].get("email");
        receiverEmails.push(email);
    }

    await sendEmailNotification(receiverEmails, htmlBody);
};

module.exports = {
onTripCreateProd,
onTripCreateDev,
};