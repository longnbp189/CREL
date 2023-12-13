import 'dart:convert';

import 'package:crel_mobile/config/api_provider.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PropertyRepo {
  Future<List<Property>> getPropertyForRent(
      int pageNum, int pageSize, int? status, String name) async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");

    String? token = prefs.getString('token');
    String url = "";

    if (status == null) {
      url = APIProvider().url +
          'properties?BrokerId=$id&PageNumber=$pageNum&PageSize=$pageSize&Name=$name&OrderBy=10';
    } else {
      url = APIProvider().url +
          'properties?BrokerId=$id&Status=$status&OrderBy=10&PageNumber=$pageNum&PageSize=$pageSize&Name=$name';
    }

    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        var pft = data.map((json) => Property.fromJson(json)).toList();
        return pft;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  Future<List<Property>> getPropertyRented(
      int pageNum, int pageSize, String name) async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    String url = APIProvider().url +
        'properties?BrokerId=$id&Status=3&PageNumber=$pageNum&PageSize=$pageSize&Name=$name';

    String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        var pft = data.map((json) => Property.fromJson(json)).toList();
        return pft;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  Future<List<Property>> searchProperty(
      int pageNum, int pageSize, int? status, String name) async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    String url = "";
    if (name != null) {
      url = APIProvider().url +
          'properties?BrokerId=$id&Status=$status&OrderBy=10&Name=$name&PageNumber=$pageNum&PageSize=$pageSize';
    } else {
      url = APIProvider().url +
          'properties?BrokerId=$id&Status=$status&OrderBy=10&PageNumber=$pageNum&PageSize=$pageSize';
    }

    String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        var pft = data.map((json) => Property.fromJson(json)).toList();
        return pft;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  Future<Property> getPropertyForRentById(int id) async {
    String url = APIProvider().url + 'properties/$id';
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var property = Property.fromJson(jsonDecode(response.body));

        return property;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  Future<Property> updateProperty(Property property) async {
    String url = APIProvider().url + 'properties';
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{
      "Content-Type": "application/json",
      "accept": "text/plain",
    };
    // Map<String, String> heads = Map<String, String>();
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.put(Uri.parse(url),
          headers: headers, body: jsonEncode(property.toJson()));
      // headers: headers);
      if (response.statusCode == 200) {
        var property = Property.fromJson(json.decode(response.body));
        return property;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  Future<Property> updateStatusProperty(Property property) async {
    String url = APIProvider().url + 'properties';
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{
      "Content-Type": "application/json",
      "accept": "text/plain",
    };
    // Map<String, String> heads = Map<String, String>();
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.put(Uri.parse(url),
          headers: headers, body: jsonEncode(property.toJson()));
      // headers: headers);
      if (response.statusCode == 200) {
        var property = Property.fromJson(json.decode(response.body));
        return property;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  Future<void> updateImage(List<XFile> image, int id) async {
    if (image.isNotEmpty) {
      String url = APIProvider().url + 'properties/$id/media';
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      // String? token = prefs.getString('token');
      Map<String, String> headers = <String, String>{
        "Content-Type": "multipart/form-data",
        "accept": "text/plain",
      };
      // Map<String, String> heads = Map<String, String>();
      headers['Authorization'] = "Bearer " + token!;

      try {
        var request = http.MultipartRequest('POST', Uri.parse(url));
        request.headers.addAll(headers);
        for (var element in image) {
          request.files.add(http.MultipartFile.fromBytes(
              'files', await element.readAsBytes(),
              filename: "files"));
        }
        final response = await request.send();
        if (response.statusCode == 200) {
          print("updated");
          return;
        } else {
          throw Exception('Not 200');
        }
      } catch (e) {
        throw Exception('Not Found');
      }
    } else {
      return;
    }
  }

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
      final response = await http.delete(Uri.parse(url),
          headers: headers, body: jsonEncode(ids));
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

  // Future<Contact> addContact(int id) async {
  //   String url = APIProvider().url + 'properties/$id/Contacts';

  //   // String? token = prefs.getString('token');
  //   Map<String, String> headers = <String, String>{
  //     "Content-Type": "multipart/form-data",
  //     "accept": "text/plain",
  //   };
  //   // headers['Authorization'] = "Bearer " + token!;

  //   try {
  //     final response = await http.post(Uri.parse(url), headers: headers);
  //     if (response.statusCode == 200) {
  //       var contact = Contact.fromJson(jsonDecode(response.body));
  //       return contact;
  //     } else {
  //       throw Exception('Not 200');
  //     }
  //   } catch (e) {
  //     throw Exception('Not Found');
  //   }
  // }

  // Future<Contact> deleteContact(int id) async {
  //   String url = APIProvider().url + 'properties/$id/Contacts';

  //   // String? token = prefs.getString('token');
  //   Map<String, String> headers = <String, String>{
  //     "Content-Type": "multipart/form-data",
  //     "accept": "text/plain",
  //   };
  //   // headers['Authorization'] = "Bearer " + token!;

  //   try {
  //     final response = await http.delete(Uri.parse(url), headers: headers);
  //     if (response.statusCode == 200) {
  //       var contact = Contact.fromJson(jsonDecode(response.body));
  //       return contact;
  //     } else {
  //       throw Exception('Not 200');
  //     }
  //   } catch (e) {
  //     throw Exception('Not Found');
  //   }
  // }

  // Future<List<Property>> getPropertyForRentByStatus(
  //     int status, int pageNum, int pageSize) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? id = prefs.getString("id");
  //   String url = APIProvider().url +
  //       'property-for-rents?AssignToStaffId=$id&Status=$status$pageNum&PageSize=$pageSize';

  //   // String? token = prefs.getString('token');
  //   Map<String, String> headers = <String, String>{};
  //   // headers['Authorization'] = "Bearer " + token!;

  //   try {
  //     final response = await http.get(Uri.parse(url), headers: headers);
  //     if (response.statusCode == 200) {
  //       List data = jsonDecode(response.body);

  //       var pft = data.map((json) => Property.fromJson(json)).toList();
  //       return pft;
  //     } else {
  //       throw Exception('Not 200');
  //     }
  //   } catch (e) {
  //     throw Exception('Not Found');
  //   }
  // }
}
