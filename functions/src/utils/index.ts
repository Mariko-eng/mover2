import * as admin from "firebase-admin";
import { Request } from "express";
import * as formidable from "formidable-serverless";
const UUID = require("uuid-v4");

// let sum = (x: number, y: number): number => {
//     return x + y;
// }

const fileUpload = async (request: Request): Promise<string> => {
  try {
    const uuid = UUID();

    const form = new formidable.IncomingForm();

    return new Promise((resolve, reject) => {
      form.parse(request, async (err, fields, files) => {
        if (err) {
          return reject(err);
        }

        const file = files.file;
        if (!file) {
          return reject(new Error("No file to upload, please choose a file"));
        }

        const filePath = file.path;
        console.log("File path : " + filePath);

        const bucket = admin.storage().bucket();

        // Specify the file path in the bucket (e.g., 'folderName/fileName')
        const storagePath = `sdk-files/${uuid}`;

        const [uploadedFile] = await bucket.upload(filePath, {
          destination: storagePath,
          resumable: false,
          public: true,
          contentType: file.type,
          metadata: {
            metadata: {
              firebaseStorageDownloadTokens: uuid,
            },
          },
        });

        console.log(uploadedFile.name);

        const fileUrl = `https://firebasestorage.googleapis.com/v0/b/${
          bucket.name
        }/o/${encodeURIComponent(storagePath)}?alt=media&token=${uuid}`;

        // console.log("uploadedFile metadata : ", uploadedFile.metadata);
        // console.log("uploadedFile mediaLink : ", uploadedFile.metadata.mediaLink);

        // const fullMediaLink = uploadedFile.metadata.mediaLink + "";
        // const mediaLinkPath = fullMediaLink.substring(
        //   0,
        //   fullMediaLink.lastIndexOf("/") + 1
        // );

        // const downloadUrl =
        //   mediaLinkPath +
        //   encodeURIComponent(uploadedFile.name) +
        //   "?alt=media&token=" +
        //   uuid;

        console.log("fileUrl : ", fileUrl);

        resolve(fileUrl);
      });
    });
  } catch (error) {
    console.error("Error handling file upload:", error);
    throw new Error(`Error handling file upload: ${(error as Error).message}`);
  }
};

module.exports = {
  fileUpload,
};
