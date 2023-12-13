import 'dart:convert';

import 'package:crel_mobile/config/api_provider.dart';
import 'package:crel_mobile/models/project.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProjectRepo {
  Future<Project> getProjectById(int id) async {
    String url = APIProvider().url + 'projects/$id';
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var project = Project.fromJson(jsonDecode(response.body));
        return project;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  Future<List<Project>> getProject() async {
    String url =
        APIProvider().url + 'projects?Status=1&PageNumber=1&PageSize=50';
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        var projects = data.map((json) => Project.fromJson(json)).toList();

        return projects;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<Project>> getProjectByDistrict(int id) async {
    String url = APIProvider().url +
        'projects?Status=1&PageNumber=1&PageSize=50&DistrictId=$id';
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        var projects = data.map((json) => Project.fromJson(json)).toList();

        return projects;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // Future<List<Project>> searchProperty(
  //     int pageNum, int pageSize, String name) async {
  //   String url = "";
  //   if (name != null) {
  //     url = APIProvider().url +
  //         'projects?Status=1&Name=$name&PageNumber=$pageNum&PageSize=$pageSize';
  //   } else {
  //     url = APIProvider().url +
  //         'projects?Status=1&PageNumber=$pageNum&PageSize=$pageSize';
  //   }

  //   // String? token = prefs.getString('token');
  //   Map<String, String> headers = <String, String>{};
  //   // headers['Authorization'] = "Bearer " + token!;

  //   try {
  //     final response = await http.get(Uri.parse(url), headers: headers);
  //     if (response.statusCode == 200) {
  //       List data = jsonDecode(response.body);

  //       var project = data.map((json) => Project.fromJson(json)).toList();
  //       return project;
  //     } else {
  //       throw Exception('Not 200');
  //     }
  //   } catch (e) {
  //     throw Exception('Not Found');
  //   }
  // }
}
