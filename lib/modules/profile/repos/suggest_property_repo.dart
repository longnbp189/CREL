import 'dart:convert';
import 'package:crel_mobile/config/api_provider.dart';
import 'package:crel_mobile/models/suggest_property.dart';
import 'package:http/http.dart' as http;

class SuggestPropertyRepo {
  Future<List<SuggestProperty>> getListSuggestProperty(
    int brandId,
    int pageNum,
    int pageSize,
  ) async {
    String url = APIProvider().url +
        'property_brands?BrandId=$brandId&PageNumber=$pageNum&PageSize=$pageSize&ListType=1&ListType=3';

    // String? token = prefs.getString('token');
    // Map<String, String> headers = <String, String>{};
    // headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(
        Uri.parse(url),
        //  headers: headers
      );
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        var properties =
            data.map((json) => SuggestProperty.fromJson(json)).toList();

        return properties;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  Future<void> addListSuggestProperty(
      int id, List<int> idPropertyBefore, List<int> idPropertyAfter) async {
    List<int> listAdd = [];
    listAdd.addAll(idPropertyAfter);
    // listAdd.removeWhere((element) => idPropertyBefore.contains(element));
    String url = APIProvider().url + 'brands/$id/recommend-properties';

    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{
      "Content-Type": "application/json",
      "accept": "text/plain",
    };
    // Map<String, String> heads = Map<String, String>();
    // headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(listAdd));
      // headers: headers);
      if (response.statusCode == 200) {
        print("add success");
        //  List data = jsonDecode(response.body);
        // var appointments =
        //     data.map((json) => Appointment.fromJson(json)).toList();

        // return appointments;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  Future<void> removeListSuggestProperty(
      int id, List<int> idPropertyBefore, List<int> idPropertyAfter) async {
    List<int> listRemove = [];
    listRemove.addAll(idPropertyBefore);
    listRemove.removeWhere((element) => idPropertyAfter.contains(element));
    String url = APIProvider().url + 'brands/$id/recommend-properties';

    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{
      "Content-Type": "application/json",
      "accept": "text/plain",
    };
    // Map<String, String> heads = Map<String, String>();
    // headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.delete(Uri.parse(url),
          headers: headers, body: jsonEncode(listRemove));
      // headers: headers);
      if (response.statusCode == 200) {
        print("delete success");
        //  List data = jsonDecode(response.body);
        // var appointments =
        //     data.map((json) => Appointment.fromJson(json)).toList();

        // return appointments;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }
}
