const express = require("express");
import { Request, Response } from "express";
const utils = require("./../../utils/email");

const router = express.Router();

router.post("/email/", async (req: Request, res: Response) => {
  try {
    const receiverEmails = ['lupapiiramark@gmail.com'];
    const html = "Hi Mariko";

    const data = await utils.sendEmailNotification(receiverEmails, html);

    return res.json({
      status: "Successfully",
      data: data,
    });
  } catch (error) {
    console.error("Error Uploading File:", error);
    return res
      .status(500)
      .json({ error: "An error occurred while uploading file." });
  }
});

module.exports = router;
