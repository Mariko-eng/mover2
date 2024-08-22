const nodemailer = require("nodemailer");

const authUserEmail = {
    user: "busstop447@gmail.com",
    pass: "wzkjqzvoehwfejbc",
};

const transporter = nodemailer.createTransport({
    host: 'smtp.gmail.com',
    port: 465,
    secure: true,
    auth: authUserEmail,
});


const sendEmailNotification = async (receiverEmails : string[], html : string) => {
    const fromEmail = "busstop447@gmail.com";
    const subject = "Bus Stop Notification";
    let toEmail = "";

    if (receiverEmails.length >= 1) {
        if (receiverEmails.length === 1) {
            toEmail = receiverEmails[0];
        } else {
            toEmail = receiverEmails.join(", ");
        }
    } else {
        toEmail = fromEmail;
    }

    const mailOptions = {
        from: fromEmail,
        to: toEmail,
        subject: subject,
        html: html,
    };


    try {
        const data = await transporter.sendMail(mailOptions);
        // console.log("Sent!");
        return data;
    } catch (error) {
        console.log(error);
        return error;
    }
};

module.exports = {
    sendEmailNotification,
};