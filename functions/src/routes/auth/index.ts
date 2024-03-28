const express = require("express");
import { Request, Response } from "express";
const controllers = require("../../controllers/auth");
const router = express.Router();

router.get("/admins/", async (req: Request, res: Response) => {
    try {
        const { env } = req.query;

        if (!env) {
            return res
                .status(400)
                .json({ error: "Env name is required in the query parameters." });
        }

        if (env !== "dev" && env !== "prod") {
            return res
                .status(400)
                .json({ error: 'Invalid value for env. It must be "dev" or "prod".' });
        }

        const results = await controllers.getAdmins({ env: env });
        return res.json(results);
    } catch (error) {
        console.error("Error fetching admins:", error);
        return res
            .status(500)
            .json({ error: "An error occurred while fetching admins." });
    }
});

interface PostAdminRequest extends Request {
    body: {
        name: string;
        accountEmail: string;
        contactEmail: string;
        phoneNumber: string;
        password: string;
        companyId: string;
        group: string;
        isMainAccount: boolean;
    };
}

router.post("/admins/", async (req: PostAdminRequest, res: Response) => {
    try {
        const { env } = req.query;

        if (!env) {
            return res
                .status(400)
                .json({ error: "Env name is required in the query parameters." });
        }

        if (env !== "dev" && env !== "prod") {
            return res
                .status(400)
                .json({ error: 'Invalid value for env. It must be "dev" or "prod".' });
        }

        const {
            name,
            accountEmail,
            contactEmail,
            phoneNumber,
            password,
            companyId,
            group,
            isMainAccount,
        } = req.body;

        // Check if any required field is missing
        const missingFields: string[] = [];
        if (!name) missingFields.push("name");
        if (!accountEmail) missingFields.push("accountEmail");
        if (!contactEmail) missingFields.push("contactEmail");
        if (!phoneNumber) missingFields.push("phoneNumber");
        if (!password) missingFields.push("password");
        if (!companyId) missingFields.push("companyId");
        if (!group) missingFields.push("group");
        if (isMainAccount === undefined) missingFields.push("isMainAccount");

        if (missingFields.length > 0) {
            return res
                .status(400)
                .json({ error: `Missing fields: ${missingFields.join(", ")}` });
        }

        const result = await controllers.createAdminAccount({
            env: env,
            name: name,
            accountEmail: accountEmail,
            contactEmail: contactEmail,
            phoneNumber: phoneNumber,
            password: password,
            companyId: companyId,
            group: group,
            isMainAccount: isMainAccount,
        });
        return res.status(200).json({ message: result.message });
    } catch (error) {
        console.error("Error adding admin:", error);
        return res.status(500).json({ message: (error as Error).message });
    }
});

interface PutAdminRequest extends Request {
    body: {
        name: string;
        accountEmail: string;
        contactEmail: string;
        phoneNumber: string;
        password: string;
        group: string;
    };
}

router.put("/admins/:id", async (req: PutAdminRequest, res: Response) => {
    try {
        const { env } = req.query;

        if (!env) {
            return res
                .status(400)
                .json({ error: "Env name is required in the query parameters." });
        }

        if (env !== "dev" && env !== "prod") {
            return res
                .status(400)
                .json({ error: 'Invalid value for env. It must be "dev" or "prod".' });
        }

        const id = req.params.id;

        if (!id) {
            return res.status(400).json({ error: "Document ID is required." });
        }

        const { name, accountEmail, contactEmail, phoneNumber, password, group } =
            req.body;

        // Check if any required field is missing
        const missingFields: string[] = [];
        if (!name) missingFields.push("name");
        if (!accountEmail) missingFields.push("accountEmail");
        if (!contactEmail) missingFields.push("contactEmail");
        if (!phoneNumber) missingFields.push("phoneNumber");
        if (!password) missingFields.push("password");
        if (!group) missingFields.push("group");

        if (missingFields.length > 0) {
            return res
                .status(400)
                .json({ error: `Missing fields: ${missingFields.join(", ")}` });
        }

        const result = await controllers.updateAdminAccountById({
            env: env,
            id: id,
            newName: name,
            newAccountEmail: accountEmail,
            newContactEmail: contactEmail,
            newPhoneNumber: phoneNumber,
            newPassword: password,
            newGroup: group,
        });
        return res.status(200).json({ message: result.message });
    } catch (error) {
        console.error("Error Updating admin:", error);
        return res.status(500).json({ message: (error as Error).message });
    }
});

router.delete("/admins/:id", async (req: Request, res: Response) => {
    try {
        const { env } = req.query;

        if (!env) {
            return res
                .status(400)
                .json({ error: "Env name is required in the query parameters." });
        }

        if (env !== "dev" && env !== "prod") {
            return res
                .status(400)
                .json({ error: 'Invalid value for env. It must be "dev" or "prod".' });
        }

        const id = req.params.id;

        if (!id) {
            return res.status(400).json({ error: "Document ID is required." });
        }

        const result = await controllers.deleteAdminById({
            env: env,
            id: id,
        });
        return res.status(200).json({ message: result.message });
    } catch (error) {
        return res.status(500).json({ message: (error as Error).message });
    }
});

module.exports = router;
