import 'dart:convert';

import 'package:crel_mobile/config/api_provider.dart';
import 'package:crel_mobile/models/brand.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BrandRepo {
  Future<List<Brand>> getListBrand(int pageNum, int pageSize) async {
    String url = APIProvider().url +
        'brands?PageNumber=$pageNum&PageSize=$pageSize&Status=2';
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        var pft = data.map((json) => Brand.fromJson(json)).toList();
        return pft;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  Future<List<Brand>> searchBrand(
      int pageNum, int pageSize, String name) async {
    String url = "";
    if (name != "") {
      url = APIProvider().url +
          'brands?Name=$name&PageNumber=$pageNum&PageSize=$pageSize&Status=2';
    } else {
      url = APIProvider().url +
          'brands?PageNumber=$pageNum&PageSize=$pageSize&Status=2';
    }
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        var brand = data.map((json) => Brand.fromJson(json)).toList();
        return brand;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  Future<Brand> getBrandById(int id) async {
    String url = APIProvider().url + 'brands/$id';
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var brand = Brand.fromJson(jsonDecode(response.body));
        return brand;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }
}
