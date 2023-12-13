import 'dart:convert';
import 'package:crel_mobile/config/api_provider.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TeamRepo {
  Future<List<Team>> getStaffTeam() async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    String url = APIProvider().url + 'teams?StaffId=$id';

    String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{
      // "Content-Type": "application/json",
      "accept": "text/plain",
      'Authorization': "Bearer " + token!
    };
    // headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        // var team = Team.fromJson(jsonDecode(response.body));

        var team = data.map((json) => Team.fromJson(json)).toList();
        return team;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }
}
