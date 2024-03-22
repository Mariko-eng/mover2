const dotenv = require('dotenv');
const assert = require('assert');

dotenv.config();

const {
  PORT,
  HOST,
  HOST_URL,
  // API_KEY,
  // AUTH_DOMAIN,
  // PROJECT_ID,
  // STORAGE_BUCKET,
  // MESSAGING_SENDER_ID,
  // APP_ID,
} = process.env;


assert(PORT, 'Port is required');
assert(HOST, 'Host is required');

export default {
  port: PORT,
  host: HOST,
  hostUrl: HOST_URL,
  firebaseConfig: {
    type: "service_account",
    project_id: "straeto-2c817",
    private_key_id: "0675f71168ee4b3f69b2a0703a037f82ef3c2b6a",
    private_key: "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDgyIhva6KbhFP4\n9an0PS6j7YnlNAECDR9C1Kxf7WVlug61A7Eewt3WyWwO1UxaAum0C+iQ4p8JzJ4S\nU4TRC0RHL2UXOZctJaJt5uADNePTfbUVCKo4AIL5D/JT/nXnekFiKnv5XRFl7SUf\nWKOFMAyGwZY8ybcbsTnyrIII+k/60PzTRpWJpflK7k9sCGICsoSM4ZBYHGtaEyBC\nW43pEcbOEkU/n6pTcpNf3pC+m0r3VgUr3Eq2CtCw7cFuy5ymnEiQmy3R5DLZ37lj\nXQRNiUYUEVbd1Ev4Q65QgP1xuGMchiC/zc1Mdaes3XQXwEVbNbwVDs1/13o7Bhtd\nW6EAV3JVAgMBAAECggEAUoJJUly3+02/ZQsHr1cl35Y5n6BPHmmip+1YuH1zUrvQ\n2jDYuuncdBLLT0aMGB4pmqUkYMpOhlJNU3zEq9bu4RJMkRHao//Ed4Lfh04oqmDi\nLy5XDOdjK/jmgl5M+QKvLVFa4FWBJWC+15q5qxHQB0bX1shUJh4PnzwjHxiCcxXC\n9V01XELUBbAUYdbcmeSutqcv5zPSO1JbcZ5MwF198HANSVIa5nj+qAVnETF7hxhI\noCIZsosMNhlYH1vwjuAC3AoyS3RCL4CQj+puiRvu2I4BE4co7o9wP6WK4sZgoTUP\neFFTM5gnrEpcjRZnkjCqY+d2n2CvOZvKc30K0cWHoQKBgQD6G8deIiHkK2zQPRUu\nqbFa6cskpXjHdB+ynNTA+3ar7NC94859rv4GmShfUaty3mH20vNU7DNI9hhN5YFP\nUlfRv17GMEEHtNz99A+rMt4XXjtmgVOHvrS1SeS80PhJI1kfZTdOr12oFFZ6UPC0\nRxRlEq4bA0Adv2438lYpnGBPZwKBgQDmFAlcbBx4eEH23MKwvjdNReMvWr2XTrPu\nU/LwW78MxQM7//aWts2L1DR1H1+TYzxA0+aOjkhDA5CYpcRi1ppC7Vyae1eYE7L1\n1QGYPIapAEblMUCHCYngmhZPAycUBLGNg3Gtz6DGbFIZHK4k84Vo1sTftJ4EQkP8\ny71gE4Jm4wKBgQDIWwB29DjaI79jgcs6Ok4NWkSV8siyXuAVoXT9s3P5fhgqRhfg\nrxJoDsE8upvxxRwNMigj26OpyxrlK/lOpdQb/oXZlkZB+i0ecykqJ/GqHp7PGsLj\nd24j3DIU4AJF9L8sW1TW/7yzLLep/LUWdepsnW5DzXLLYdLVlphXdSHh+QKBgQC1\n0TOsk8rT8MTAHqjEHy14pTfpXh3hClLqjfC3vOj3YGEz8wydAYzhaSqjO829nXgq\nCspx8UJtos2Ls8PED68MIKNDeSE5jqen2VJPSdVojE16JTfG/uS0V1A11Fn3WdYt\n7KfTIPb+lu8x5RZBIShWNxKRbhxJZUxw41ieKgys3QKBgQDyG3Os3j7WEP63tS93\nxExH+1lBLFhv2IEAQark0B7BVqjSwxWcyQYiLRJNxUVFvg9U75DeGZGVy2dwFl6p\nkXZKMU0NrUvlkfw0QrEJ15rhPahutPO2OddpoYFck7JJao8C03BvNq7MM6HviUrM\nCVAFJkPnvC4Cj1JPGr4eSHAhvA==\n-----END PRIVATE KEY-----\n",
    client_email: "firebase-adminsdk-2hvjl@straeto-2c817.iam.gserviceaccount.com",
    client_id: "117958067338930050669",
    auth_uri: "https://accounts.google.com/o/oauth2/auth",
    token_uri: "https://oauth2.googleapis.com/token",
    auth_provider_x509_cert_url: "https://www.googleapis.com/oauth2/v1/certs",
    client_x509_cert_url: "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-2hvjl%40straeto-2c817.iam.gserviceaccount.com",
    universe_domain: "googleapis.com"
  },
};