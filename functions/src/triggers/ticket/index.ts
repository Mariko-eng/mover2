import * as admin from "firebase-admin";
const { sendEmailNotification } = require("./../../utils/email");

const onTicketCreateProd = async ({ data, snapshot, context }) => {
    const companyId = data.companyId;
    let receiverEmails = [];

    const htmlBody = `<div><h1>${"New Ticket Alert"}</h1><p>Ticket : <b>${data.ticketNumber
        }<b/></p><p>${"A New Ticket Has Been Purchased!"}</p></div>`;

    const superAdminResults = await admin.firestore().collection("admin_accounts")
        .where("group", "==", "super_bus_admin")
        .get();

    for (let i = 0; i < superAdminResults.docs.length; i++) {
        const email = superAdminResults.docs[i].get("email");
        receiverEmails.push(email);
    }

    const busAdminResults = await admin.firestore().collection("admin_accounts")
        .where("companyId", "==", companyId)
        .where("group", "==", "bus_admin")
        .get();

    for (let i = 0; i < busAdminResults.docs.length; i++) {
        const email = busAdminResults.docs[i].get("email");
        receiverEmails.push(email);
    }

    await sendEmailNotification(receiverEmails, htmlBody);
};

const onTicketCreateDev = async ({ data, snapshot, context }) => {
    const companyId = data.companyId;
    let receiverEmails = [];

    const htmlBody = `<div><h1>${"New Ticket Alert"}</h1><p>Ticket : <b>${data.ticketNumber
        }<b/></p><p>${"A New Ticket Has Been Purchased!"}</p></div>`;

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

module.exports = { onTicketCreateProd, onTicketCreateDev };