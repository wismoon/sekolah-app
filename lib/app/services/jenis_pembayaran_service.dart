import 'dart:convert';

import 'package:sekolah_app/app/core/constant/api_constant.dart';
import 'package:sekolah_app/app/models/jenis_pembayaran_model.dart';
import 'package:http/http.dart' as http;

class JenisPembayaranService {
  Future<List<JenisPembayaran>> fetchJenisPembayaran() async {
    final response = await http.get(
      Uri.parse(
          '${BaseUrlConstants.baseUrl}${TransaksiEndpoints.jenisPembayaran}'),
      headers: {
        'Authorization': 'Bearer ${AuthConstants.bearerToken}',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = jsonResponse['data']['jenisPembayaran'];
      if (data != null) {
        return data
            .map<JenisPembayaran>((item) => JenisPembayaran.fromJson(item))
            .toList();
      } else {
        throw Exception('Data is null');
      }
    } else {
      throw Exception('Failed to load jenis pembayaran');
    }
  }

  Future<void> createJenisPembayaran(JenisPembayaran jenisPembayaran) async {
    final response = await http.post(
      Uri.parse(
          '${BaseUrlConstants.baseUrl}${TransaksiEndpoints.jenisPembayaran}'),
      headers: <String, String>{
        'Content-Type': BaseUrlConstants.contentTypeJson,
        'Authorization': 'Bearer ${AuthConstants.bearerToken}'
      },
      body: jsonEncode(jenisPembayaran.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Request was successful, no need to throw an exception
      print('Jenis Pembayaran created successfully');
    } else {
      // Handle other status codes as errors
      final responseJson = jsonDecode(response.body);
      final errorMessage = responseJson['data']['message'] ?? 'Unknown error';
      throw Exception('Failed to create jenis pembayaran: $errorMessage');
    }
  }

  Future<void> updateJenisPembayaran(JenisPembayaran jenisPembayaran, String? id_akun) async {
    final baseUrl = Uri.parse(
        '${BaseUrlConstants.baseUrl}${TransaksiEndpoints.jenisPembayaran}/${jenisPembayaran.id}?id_akun=$id_akun');
    final url = id_akun != null;
    print(url);

    final payload = jsonEncode(jenisPembayaran.toJson());
    print('Payload: $payload');

    final response = await http.put(
      baseUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${AuthConstants.bearerToken}'
      },
      body: payload,
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to update jenis pembayaran');
    }
  }

  Future<void> deleteJenisPembayaran(int id) async {
    final response = await http.delete(
      Uri.parse(
          '${BaseUrlConstants.baseUrl}${TransaksiEndpoints.jenisPembayaran}/$id'),
      headers: <String, String>{
        'Authorization': 'Bearer ${AuthConstants.bearerToken}'
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update jenis pembayaran');
    }
  }
}
