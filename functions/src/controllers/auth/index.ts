import * as admin from "firebase-admin";
import { UserRecord, getAuth } from "firebase-admin/auth";
import {
  DocumentData,
  DocumentSnapshot,
  QuerySnapshot,
} from "firebase-admin/firestore";

const getAdmins = async ({ env }: { env: string }) => {
  try {
    let collectionName =
      env === "dev" ? "test_admin_accounts" : "admin_accounts";
    let results: QuerySnapshot = await admin
      .firestore()
      .collection(collectionName)
      .get();

    let data: object[] = [];
    results.docs.forEach((item: DocumentSnapshot) => {
      data.push({ id: item.id, ...item.data() });
    });

    // console.log(data)
    return data;
  } catch (error) {
    // Throw an error if any occurs
    throw new Error(`Error changing Admin email: ${(error as Error).message}`);
  }
};

const createAdminAccount = async ({
  // Both Super_Bus_Admin & Bus_Admin
  env,
  name,
  accountEmail,
  contactEmail,
  phoneNumber,
  password,
  companyId,
  group,
  isMainAccount,
}: {
  env: string;
  id: string;
  name: string;
  accountEmail: string;
  contactEmail: string;
  phoneNumber: string;
  password: string;
  companyId: string;
  group: string;
  isMainAccount: boolean;
}): Promise<{ message: string }> => {
  try {
    let collectionName =
      env === "dev" ? "test_admin_accounts" : "admin_accounts";

    let userRecord: UserRecord = await getAuth().createUser({
      email: accountEmail,
      password: password,
      displayName: name,
      emailVerified: true,
      disabled: false,
    });

    // console.log(results.uid);

    let docId = userRecord.uid;

    if (group === "super_bus_admin") {
      await admin.firestore().collection(collectionName).doc(docId).set({
        name: name,
        email: accountEmail,
        contactEmail: contactEmail,
        phoneNumber: phoneNumber,
        password: password,
        group: group,
        isActive: true,
      });
    } else {
      let companyCollectionName =
        env === "dev" ? "test_companies" : "companies";

      const companySnapshot = await admin
        .firestore()
        .collection(companyCollectionName)
        .doc(companyId)
        .get();

      if (companySnapshot.exists == false) {
        throw new Error(`Company Does not exist!`);
      }

      let companyData = companySnapshot.data();

      await admin.firestore().collection(collectionName).doc(docId).set({
        name: name,
        email: accountEmail,
        contactEmail: contactEmail,
        phoneNumber: phoneNumber,
        password: password,
        companyId: companyId,
        company: companyData,
        group: group,
        isMainAccount: isMainAccount,
        isActive: true,
      });
    }

    // Return success message
    return {
      message: "Admin User Added Successfully!",
    };
  } catch (error) {
    // Throw an error if any occurs
    throw new Error(`Error Added Admin: ${(error as Error).message}`);
  }
};

const updateAdminAccountById = async ({
  env,
  id,
  newName,
  newAccountEmail,
  newContactEmail,
  newPhoneNumber,
  newPassword,
  newGroup,
}: {
  env: string;
  id: string;
  newName: string;
  newAccountEmail: string;
  newContactEmail: string;
  newPhoneNumber: string;
  newPassword: string;
  newGroup: string;
}): Promise<{ message: string }> => {
  try {
    let collectionName =
      env === "dev" ? "test_admin_accounts" : "admin_accounts";

    // Update user in Firebase Authentication
    await admin.auth().updateUser(id, {
      email: newAccountEmail,
      password: newPassword,
      displayName: newName,
      // phoneNumber: '', // Must an un empty string & also Include A country code to be valid eg +2561234567890
      // photoURL: '',
      emailVerified: true,
      disabled: false,
    });

    let doc: DocumentSnapshot = await admin
      .firestore()
      .collection(collectionName)
      .doc(id)
      .get();

    let adminData: DocumentData | undefined = doc.data();

    if (adminData?.group === "super_bus_admin") {
      // Update user in Firestore
      await admin.firestore().collection(collectionName).doc(id).update({
        name: newName,
        email: newAccountEmail,
        phoneNumber: newPhoneNumber,
        contactEmail: newContactEmail,
        password: newPassword,
      });
    } else {
      // Update user in Firestore
      await admin
        .firestore()
        .collection(collectionName)
        .doc(id)
        .update({
          name: newName,
          email: newAccountEmail,
          phoneNumber: newPhoneNumber,
          contactEmail: newContactEmail,
          password: newPassword,
          group: newGroup,
          isMainAccount: newGroup === "bus_admin" ? true : false,
        });
    }

    // Return success message
    return {
      message: "Admin User Updated Successfully!",
    };
  } catch (error) {
    // Throw an error if any occurs
    throw new Error(`Error Updating Admin: ${(error as Error).message}`);
  }
};

const deleteAdminById = async ({
  env,
  id,
}: {
  env: string;
  id: string;
}): Promise<{ message: string }> => {
  try {
    let collectionName =
      env === "dev" ? "test_admin_accounts" : "admin_accounts";

    await admin.firestore().collection(collectionName).doc(id).delete();
    await admin.auth().deleteUser(id);

    return {
      message: "Admin User Deleted Successfully!",
    };
  } catch (error) {
    throw new Error(`Error deleting Admin: ${(error as Error).message}`);
  }
};

module.exports = {
  getAdmins,
  createAdminAccount,
  updateAdminAccountById,
  deleteAdminById,
};
