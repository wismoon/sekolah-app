import 'dart:convert';
import 'package:sekolah_app/app/core/constant/api_constant.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PaymentService {
  static Future<Map<String, dynamic>> createPayment(String nomorPembayaran) async {
    final url = Uri.parse('${BaseUrlConstants.baseUrl}${InvoiceEndpoints.paymentCreate}/$nomorPembayaran');
    final headers = {
      'Content-Type': BaseUrlConstants.contentTypeJson,
      'Authorization': 'Bearer ${AuthConstants.bearerToken}'
    };

    print('Request URL: $url');
    print('Request Headers: $headers');

    try {
      final response = await http.get(url, headers: headers);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        final responseJson = jsonDecode(response.body);
        final errorMessage = responseJson['data']['message'] ?? 'Unknown error';
        throw Exception('Failed to create payment: $errorMessage');
      }
    } catch (e) {
      print('Payment error: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> getPaymentStatus(String transactionId) async {
    final response = await http.get(
      Uri.parse('${BaseUrlConstants.baseUrl}${InvoiceEndpoints.paymentStatus}/$transactionId'),
      headers: {
        'Authorization': 'Bearer ${AuthConstants.bearerToken}',
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get payment status');
    }
  }

  static Future<void> launchPaymentUrl(String paymentUrl) async {
     if (await canLaunchUrl(Uri.parse(paymentUrl))) {
      await launchUrl(Uri.parse(paymentUrl));
    } else {
      throw 'Could not launch $paymentUrl';
    }
  }
}
