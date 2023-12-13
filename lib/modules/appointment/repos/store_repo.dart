import 'dart:convert';

import 'package:crel_mobile/config/api_provider.dart';
import 'package:crel_mobile/models/store.dart';
import 'package:http/http.dart' as http;

class StoreRepo {
  Future<Store> getStoreById(int id) async {
    String url = APIProvider().url + 'stores/$id';

    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    // headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var store = Store.fromJson(jsonDecode(response.body));
        return store;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  Future<Store> createStore() async {
    String url = APIProvider().url + 'stores';

    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{
      "Content-Type": "multipart/form-data",
      "accept": "text/plain",
    };
    // headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.post(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var store = Store.fromJson(jsonDecode(response.body));
        return store;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  Future<List<Store>> getStore(int pageNum, int pageSize, int id) async {
    String url = APIProvider().url +
        'stores?Status=2&BrandId=$id&PageNumber=$pageNum&PageSize=$pageSize';

    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    // headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        var stores = data.map((json) => Store.fromJson(json)).toList();
        return stores;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }
}
