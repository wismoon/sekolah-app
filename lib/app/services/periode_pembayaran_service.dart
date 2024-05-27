import 'dart:convert';

import 'package:sekolah_app/app/core/constant/api_constant.dart';
import 'package:sekolah_app/app/models/periode_pembayaran_model.dart';
import 'package:http/http.dart' as http;

class PeriodePembayaranService {
  Future<List<PeriodePembayaran>> fetchPeriodePembayaran() async {
    final response = await http.get(
      Uri.parse('${BaseUrlConstants.baseUrl}${PeriodeEndpoints.periodePembayaran}'),
      headers: {
        'Authorization': 'Bearer ${AuthConstants.bearerToken}',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = jsonResponse['data']['periodePembayaran'];
      // print('Data: $data');
      if (data != null) {
        return data.map<PeriodePembayaran>((item) => PeriodePembayaran.fromJson(item)).toList();
      } else {
        throw Exception('Data is null');
      }
    } else {
      throw Exception('Failed to load periode pembayaran');
    }
  }

  Future<void> createPeriodePembayaran(PeriodePembayaran periodePembayaran) async {
    final response = await http.post(
      Uri.parse('${BaseUrlConstants.baseUrl}${PeriodeEndpoints.periodePembayaran}'),
      headers: <String, String>{
        'Content-Type': BaseUrlConstants.contentTypeJson,
        'Authorization': 'Bearer ${AuthConstants.bearerToken}'
      },
      body: jsonEncode(periodePembayaran.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Request was successful, no need to throw an exception
      // print('Periode Pembayaran created successfully');
    } else {
      // Handle other status codes as errors
      final responseJson = jsonDecode(response.body);
      final errorMessage = responseJson['data']['message'] ?? 'Unknown error';
      throw Exception('Failed to create jenis pembayaran: $errorMessage');
    }
  }

  Future<void> updatePeriodePembayaran(PeriodePembayaran PeriodePembayaran) async {
    final response = await http.put(
      Uri.parse('${BaseUrlConstants.baseUrl}${PeriodeEndpoints.periodePembayaran}/${PeriodePembayaran.id}'),
      headers: <String, String>{
        'Content-Type': BaseUrlConstants.contentTypeJson,
        'Authorization': 'Bearer ${AuthConstants.bearerToken}'
      },
      body: jsonEncode(PeriodePembayaran.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update periode pembayaran');
    }
  }

  Future<void> deletePeriodePembayaran(int id) async {
    final response = await http.delete(
      Uri.parse('${BaseUrlConstants.baseUrl}${PeriodeEndpoints.periodePembayaran}/$id'),
      headers: <String, String>{
        'Authorization': 'Bearer ${AuthConstants.bearerToken}'
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete periode pembayaran');
    }
  }
}
