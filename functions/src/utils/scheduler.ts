import * as admin from "firebase-admin";

// Helper function to parse date string
const parseDateString = (dateString) => {
    // Adjust this depending on your date string format
    return new Date(dateString);
};

const transactionsScheduler = async () => {
    try {
        const now = new Date();
        const tenMinutesAgo = new Date(now.getTime() - 10 * 60 * 1000); // 5 minutes ago

        const prodTrans = await admin.firestore().collection("transactions").where("paymentStatus", "==", "PENDING").get();
        const defTrans = await admin.firestore().collection("test_transactions").where("paymentStatus", "==", "PENDING").get();

        for (let i = 0; i < prodTrans.docs.length; i++) {
            const transactionCreatedAt = prodTrans.docs[i].get("createdAt");
            const createdAtDate = parseDateString(transactionCreatedAt);

            if (createdAtDate < tenMinutesAgo) {
                await prodTrans.docs[i].ref.update({ paymentStatus: "REFUSED" });
                console.log(`Updated transaction ${prodTrans.docs[i].id} to REFUSED.`);
            }

        }

        // Process default transactions
        for (const doc of defTrans.docs) {
            const dataCreatedAt = doc.get("createdAt");
            const createdAtDate = parseDateString(dataCreatedAt);

            if (createdAtDate < tenMinutesAgo) {
                await doc.ref.update({ paymentStatus: "REFUSED" });
                console.log(`Updated transaction ${doc.id} to REFUSED.`);
            }
        }

    } catch (error) {
        console.error("Error processing transactions:", error);
    }

};

module.exports = {
    transactionsScheduler,
};