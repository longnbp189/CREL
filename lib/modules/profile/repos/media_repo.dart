import 'dart:convert';

import 'package:crel_mobile/config/api_provider.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MediaRepo {
  // Future<Media> getMediaById() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? id = prefs.getString("mediaId");

  //   String url = APIProvider().url + 'media/$id';

  //   String? token = prefs.getString('token');
  //   Map<String, String> headers = <String, String>{};
  //   headers['Authorization'] = "Bearer " + token!;

  //   try {
  //     final response = await http.get(Uri.parse(url), headers: headers);
  //     if (response.statusCode == 200) {
  //       var media = Media.fromJson(jsonDecode(response.body));

  //       // final prefs = await SharedPreferences.getInstance();
  //       // prefs.setString('staffId', user.id.toString());
  //       // prefs.setString('token', user.token.toString());

  //       return media;
  //     } else {
  //       throw Exception('Not 200');
  //     }
  //   } catch (e) {
  //     throw Exception('Not Found');
  //   }
  // }

  Future<List<Media>> getMediaByPropertyId(int id) async {
    String url = APIProvider().url + 'media?PropertyId=$id';

    Map<String, String> headers = <String, String>{};

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        var media = data.map((json) => Media.fromJson(json)).toList();
        // final prefs = await SharedPreferences.getInstance();
        // prefs.setString('staffId', user.id.toString());
        // prefs.setString('token', user.token.toString());

        return media;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  // Future<Media> updateMedia(Media user) async {
  //   String url = APIProvider().url + 'file';

  //   // String? token = prefs.getString('token');
  //   Map<String, String> headers = <String, String>{
  //     "Content-Type": "application/json",
  //     "accept": "text/plain",
  //   };
  //   // Map<String, String> heads = Map<String, String>();
  //   // headers['Authorization'] = "Bearer " + token!;

  //   try {
  //     final response = await http.put(Uri.parse(url),
  //         headers: headers, body: jsonEncode(user.toJson()));
  //     // headers: headers);
  //     if (response.statusCode == 200) {
  //       var user = Media.fromJson(json.decode(response.body));
  //       return user;
  //     } else {
  //       throw Exception('Not 200');
  //     }
  //   } catch (e) {
  //     throw Exception('Not Found');
  //   }
  // }

  Future<void> deleteMedia(List<Media> mediaAdd, List<Media> mediaSaved) async {
    mediaSaved.removeWhere((element) => mediaAdd.contains(element));
    List<int> ids = [];
    for (var item in mediaSaved) {
      ids.add(item.id!);
    }

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    String url = APIProvider().url + 'media';
    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{
      "Content-Type": "application/json",
      "accept": "text/plain",
    };
    // Map<String, String> heads = Map<String, String>();
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response =
          await http.delete(Uri.parse(url), headers: headers, body: ids);
      // headers: headers);
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }
}
