import 'dart:convert';

import 'package:crel_mobile/config/api_provider.dart';
import 'package:crel_mobile/models/district.dart';
import 'package:http/http.dart' as http;

class DistrictRepo {
  Future<List<District>> getDistrict() async {
    String url = APIProvider().url + 'districts?PageNumber=1&PageSize=30';

    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    // headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        var districts = data.map((json) => District.fromJson(json)).toList();

        return districts;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  Future<District> getDistrictById(int id) async {
    String url = APIProvider().url + 'districts/$id';

    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    // headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var district = District.fromJson(jsonDecode(response.body));
        return district;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }
}
