import 'dart:convert';

import 'package:crel_mobile/config/api_provider.dart';
import 'package:crel_mobile/models/ward.dart';
import 'package:http/http.dart' as http;

class WardRepo {
  Future<List<Ward>> getWardByDistrictId(int id) async {
    String url =
        APIProvider().url + 'wards?DistrictId=$id&PageNumber=1&PageSize=30';

    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    // headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        var wards = data.map((json) => Ward.fromJson(json)).toList();

        return wards;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }
}
