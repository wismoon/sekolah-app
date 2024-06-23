import 'package:cloud_firestore/cloud_firestore.dart';

class SiswaTransaction {
  String? transactionTime;
  String? customField1;
  String? customField2;
  String? customField3;
  String? grossAmount;
  String? currency;
  String? orderId;
  String? paymentType;
  String? signatureKey;
  String? statusCode;
  String? transactionId;
  String? transactionStatus;
  String? fraudStatus;
  String? expiryTime;
  String? settlementTime;
  String? statusMessage;
  String? merchantId;
  String? transactionType;

  SiswaTransaction({
    this.transactionTime,
    this.customField1,
    this.customField2,
    this.customField3,
    this.grossAmount,
    this.currency,
    this.orderId,
    this.paymentType,
    this.signatureKey,
    this.statusCode,
    this.transactionId,
    this.transactionStatus,
    this.fraudStatus,
    this.expiryTime,
    this.settlementTime,
    this.statusMessage,
    this.merchantId,
    this.transactionType,
  });

  SiswaTransaction.fromJson(Map<String, dynamic> json) {
    transactionTime = json['transaction_time'];
    customField1 = json['custom_field1'];
    customField2 = json['custom_field2'];
    customField3 = json['custom_field3'];
    grossAmount = json['gross_amount'];
    currency = json['currency'];
    orderId = json['order_id'];
    paymentType = json['payment_type'];
    signatureKey = json['signature_key'];
    statusCode = json['status_code'];
    transactionId = json['transaction_id'];
    transactionStatus = json['transaction_status'];
    fraudStatus = json['fraud_status'];
    expiryTime = json['expiry_time'];
    settlementTime = json['settlement_time'];
    statusMessage = json['status_message'];
    merchantId = json['merchant_id'];
    transactionType = json['transaction_type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['transaction_time'] = transactionTime;
    data['custom_field1'] = customField1;
    data['custom_field2'] = customField2;
    data['custom_field3'] = customField3;
    data['gross_amount'] = grossAmount;
    data['currency'] = currency;
    data['order_id'] = orderId;
    data['payment_type'] = paymentType;
    data['signature_key'] = signatureKey;
    data['status_code'] = statusCode;
    data['transaction_id'] = transactionId;
    data['transaction_status'] = transactionStatus;
    data['fraud_status'] = fraudStatus;
    data['expiry_time'] = expiryTime;
    data['settlement_time'] = settlementTime;
    data['status_message'] = statusMessage;
    data['merchant_id'] = merchantId;
    data['transaction_type'] = transactionType;
    return data;
  }

  factory SiswaTransaction.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SiswaTransaction(
      transactionTime: data['transaction_time'],
      customField1: data['custom_field1'],
      customField2: data['custom_field2'],
      customField3: data['custom_field3'],
      grossAmount: data['gross_amount'],
      currency: data['currency'],
      orderId: data['order_id'],
      paymentType: data['payment_type'],
      signatureKey: data['signature_key'],
      statusCode: data['status_code'],
      transactionId: data['transaction_id'],
      transactionStatus: data['transaction_status'],
      fraudStatus: data['fraud_status'],
      expiryTime: data['expiry_time'],
      settlementTime: data['settlement_time'],
      statusMessage: data['status_message'],
      merchantId: data['merchant_id'],
      transactionType: data['transaction_type'],
    );
  }
}
