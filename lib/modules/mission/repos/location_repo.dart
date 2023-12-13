import 'dart:convert';

import 'package:crel_mobile/config/api_provider.dart';
import 'package:crel_mobile/models/location.dart';
import 'package:http/http.dart' as http;

class LocationRepo {
  Future<Location> getLocationById(int id) async {
    String url = APIProvider().url + 'locations/$id';

    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    // headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var location = Location.fromJson(jsonDecode(response.body));
        return location;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }
}
