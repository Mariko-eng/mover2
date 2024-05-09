import 'package:dio/dio.dart';

class PaymentModel {
  String culipaTxId;
  PaymentDetails payment;
  String transactionId;
  String status;

  PaymentModel({
    required this.culipaTxId,
    required this.payment,
    required this.transactionId,
    required this.status,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      PaymentModel(
        culipaTxId: json["culipaTxID"],
        payment: PaymentDetails.fromJson(json["payment"]),
        transactionId: json["transactionID"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "culipaTxID": culipaTxId,
    "payment": payment.toJson(),
    "transactionID": transactionId,
    "status": status,
  };
}

class PaymentDetails {
  int amount;
  String wallet;
  String currency;
  String account;

  PaymentDetails({
    required this.amount,
    required this.wallet,
    required this.currency,
    required this.account,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) => PaymentDetails(
    amount: json["amount"],
    wallet: json["wallet"],
    currency: json["currency"],
    account: json["account"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "wallet": wallet,
    "currency": currency,
    "account": account,
  };
}

Future<PaymentModel> initiateTransaction({
  required String account, // Phone Number
  required int amount,
  required String wallet, // 'mtnug' | 'airtelug'
  required String transactionID,
  required String memo,
  String currency = "UGX",
  String merchant = "BusStop",
}) async {
  try {
    Dio dio = Dio();
    String url = "https://test.culipay.ug/initiate";

    Map payload = {
      "account": account,
      "amount": amount,
      "currency": "UGX",
      "wallet": wallet,
      "transactionID": transactionID,
      "merchant": merchant,
      "memo": memo
    };

    print("Be4 response");
    print(payload);
    Response response = await dio.post(url, data: payload,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'Connection': 'keep-alive',
            'api-key': '183F45697BE7F79B5C827595867AE23A0245591E8EA46658FC84080011903087',
            'merchant': 'BusStop'
            // 'Cookie': accessToken, // Corrected header name
          },
        )
    );

    PaymentModel data = PaymentModel.fromJson(response.data);

    return data;
  } on DioException catch (error) {
    print("DIO Error : " + error.toString());
    throw Exception('DIO Error: $error');
  } catch (e) {
    print(e.toString());
    throw e.toString();
  }
}

Future<PaymentModel> checkPaymentTransactionStatus({
  required PaymentModel paymentModel,
}) async {
  try {
    Dio dio = Dio();
    String url = "https://test.culipay.ug/status/${paymentModel.culipaTxId}";

    while (true) {
      Response response = await dio.get(url,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': '*/*',
              'Connection': 'keep-alive',
              'api-key': '183F45697BE7F79B5C827595867AE23A0245591E8EA46658FC84080011903087',
              'merchant': 'BusStop'
              // 'Cookie': accessToken, // Corrected header name
            },
          )
      );
      PaymentModel data = PaymentModel.fromJson(response.data);

      if (data.status.toUpperCase() != "PENDING") {
        return data; // Transaction status is no longer "Pending", return the data
      }

      // Wait for 10 seconds before checking again
      await Future.delayed(const Duration(seconds: 5));
    }
  } on DioException catch (error) {
    print('DIO Error: $error');
    paymentModel.status = "ERROR";
    return paymentModel;
  } catch (e) {
    print('Error: $e');
    // throw e.toString();
    paymentModel.status = "ERROR";
    return paymentModel;
  }
}
