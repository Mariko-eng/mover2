const express = require("express");
import { Request, Response } from "express";
const utils = require("./../../utils");

const router = express.Router();

router.post("/upload/", async (req: Request, res: Response) => {
  try {
    const fileLink = await utils.fileUpload(req);

    return res.json({
      status: "Successfully",
      fileLink: fileLink,
    });
  } catch (error) {
    console.error("Error Uploading File:", error);
    return res
      .status(500)
      .json({ error: "An error occurred while uploading file." });
  }
});

module.exports = router;
