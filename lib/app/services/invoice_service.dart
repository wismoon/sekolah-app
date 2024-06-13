import 'dart:convert';

import 'package:sekolah_app/app/core/constant/api_constant.dart';
import 'package:sekolah_app/app/models/invoice_model.dart';
import 'package:http/http.dart' as http;

class InvoiceService {
  Future<List<Invoice>> fetchInvoicePembayaran() async {
    final response = await http.get(
      Uri.parse(
          '${BaseUrlConstants.baseUrl}${InvoiceEndpoints.invoicePembayaran}'),
      headers: {
        'Authorization': 'Bearer ${AuthConstants.bearerToken}',
      },
    );

    print('API Response: ${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = jsonResponse['data']['invoice'];
      if (data != null) {
        return data
            .map<Invoice>((item) => Invoice.fromJson(item))
            .toList();
      } else {
        throw Exception('Data is null');
      }
    } else {
      throw Exception('Failed to load jenis pembayaran');
    }
  }

  Future<void> createInvoicePembayaran(Invoice invoicePembayaran) async {
    final response = await http.post(
      Uri.parse(
          '${BaseUrlConstants.baseUrl}${InvoiceEndpoints.invoicePembayaran}'),
      headers: <String, String>{
        'Content-Type': BaseUrlConstants.contentTypeJson,
        'Authorization': 'Bearer ${AuthConstants.bearerToken}'
      },
      body: jsonEncode(invoicePembayaran.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Request was successful, no need to throw an exception
      print('Invoice Pembayaran created successfully');
    } else {
      // Handle other status codes as errors
      final responseJson = jsonDecode(response.body);
      final errorMessage = responseJson['data']['message'] ?? 'Unknown error';
      print('Server Error: $responseJson');
      throw Exception('Failed to create invoice pembayaran: $errorMessage');
    }
  }

  Future<void> createInvoiceBulkPembayaran(Invoice invoicePembayaran) async {
    final response = await http.post(
      Uri.parse(
          '${BaseUrlConstants.baseUrl}${InvoiceEndpoints.invoicePembayaran}'),
      headers: <String, String>{
        'Content-Type': BaseUrlConstants.contentTypeJson,
        'Authorization': 'Bearer ${AuthConstants.bearerToken}'
      },
      body: jsonEncode(invoicePembayaran.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Request was successful, no need to throw an exception
      print('Invoice Pembayaran created successfully');
    } else {
      // Handle other status codes as errors
      final responseJson = jsonDecode(response.body);
      final errorMessage = responseJson['data']['message'] ?? 'Unknown error';
      print('Server Error: $responseJson');
      throw Exception('Failed to create invoice pembayaran: $errorMessage');
    }
  }

  Future<void> updatePembayaran(Invoice pembayaran) async {
    // Code to update an existing pembayaran
  }

  Future<void> deletePembayaran(int id) async {
    // Code to delete a pembayaran
  }

  Future<List<Invoice>> fetchStudentInvoice(String nim) async {
    final response = await http.get(
      Uri.parse('${BaseUrlConstants.baseUrl}${InvoiceEndpoints.invoicePembayaran}?nim=$nim'),
      headers: {
        'Authorization': 'Bearer ${AuthConstants.bearerToken}',
      },
    );

    // print('API Response: ${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = jsonResponse['data']['invoice'];
      if (data != null) {
        return data.map<Invoice>((item) => Invoice.fromJson(item)).toList();
      } else {
        throw Exception('Data is null');
      }
    } else {
      throw Exception('Failed to load student payments');
    }
  }
}
