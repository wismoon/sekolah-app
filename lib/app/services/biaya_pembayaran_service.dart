import 'dart:convert';
import 'package:sekolah_app/app/core/constant/api_constant.dart';
import 'package:sekolah_app/app/models/biayapembayaran_model.dart';
import 'package:http/http.dart' as http;

class BiayaPembayaranService {
  Future<List<Biayapembayaran>> fetchBiayaPembayaran() async {
    final response = await http.get(
      Uri.parse(
          '${BaseUrlConstants.baseUrl}${PembayaranEndpoints.biayaPembayaran}'),
      headers: {
        'Authorization': 'Bearer ${AuthConstants.bearerToken}',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = jsonResponse['data']['biayaPembayaran'];
      // print('Data: $data');
      if (data != null) {
        return data
            .map<Biayapembayaran>((item) => Biayapembayaran.fromJson(item))
            .toList();
      } else {
        throw Exception('Data is null');
      }
    } else {
      throw Exception('Failed to load jenis pembayaran');
    }
  }

  Future<void> createBiayaPembayaran(Biayapembayaran biayaPembayaran) async {
    final response = await http.post(
      Uri.parse('${BaseUrlConstants.baseUrl}${PembayaranEndpoints.biayaPembayaran}'),
      headers: <String, String>{
        'Content-Type': BaseUrlConstants.contentTypeJson,
        'Authorization': 'Bearer ${AuthConstants.bearerToken}'
      },
      body: jsonEncode(biayaPembayaran.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Request was successful, no need to throw an exception
      // print('Biaya Pembayaran created successfully');
    } else {
      // Handle other status codes as errors
      final responseJson = jsonDecode(response.body);
      final errorMessage = responseJson['data']['message'] ?? 'Unknown error';
      throw Exception('Failed to create jenis pembayaran: $errorMessage');
    }
  }

  Future<void> updateBiayaPembayaran(Biayapembayaran biayaPembayaran) async {
    final response = await http.put(
      Uri.parse('${BaseUrlConstants.baseUrl}${PembayaranEndpoints.biayaPembayaran}/${biayaPembayaran.id}'),
      headers: <String, String>{
        'Content-Type': BaseUrlConstants.contentTypeJson,
        'Authorization': 'Bearer ${AuthConstants.bearerToken}'
      },
      body: jsonEncode(biayaPembayaran.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update jenis pembayaran');
    }
  }

  Future<void> deleteBiayaPembayaran(int id) async {
    final response = await http.delete(
      Uri.parse('${BaseUrlConstants.baseUrl}${PembayaranEndpoints.biayaPembayaran}/$id'),
      headers: <String, String>{'Authorization': 'Bearer ${AuthConstants.bearerToken}'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete jenis pembayaran');
    }
  }
}
