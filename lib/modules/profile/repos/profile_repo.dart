import 'dart:convert';
import 'dart:io';
import 'package:crel_mobile/models/broker.dart';
import 'package:crel_mobile/config/api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileRepo {
  Future<Broker> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    // String? userName = prefs.getString("userName");
    // String? password = prefs.getString("password");
    // if (id == null) {
    //   await AuthenticationRepo().loginAPI(
    //       // await FirebaseAuth.instance.currentUser!.getIdToken(),
    //       userName,
    //       password);
    //   id = prefs.getString("id");
    // }

    String url = APIProvider().url + 'brokers/$id';

    String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var user = Broker.fromJson(jsonDecode(response.body));
        // FirebaseMessaging.instance
        //     .subscribeToTopic("Broker" + user.id.toString());

        // final prefs = await SharedPreferences.getInstance();
        // prefs.setString('staffId', user.id.toString());
        // prefs.setString('mediaId', user.mediaId.toString());

        // prefs.setString('token', user.token.toString());

        return user;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  // Future<model.User> updateProfile(model.User user) async {
  Future<Broker> updateProfile(Broker user) async {
    final prefs = await SharedPreferences.getInstance();

    String url = APIProvider().url + 'brokers';

    String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{
      "Content-Type": "application/json",
      "accept": "text/plain",
    };
    // Map<String, String> heads = Map<String, String>();
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.put(Uri.parse(url),
          headers: headers, body: jsonEncode(user.toJson()));
      // headers: headers);
      if (response.statusCode == 200) {
        var user = Broker.fromJson(json.decode(response.body));
        // await FirebaseMessaging.instance
        //     .subscribeToTopic("Staff" + user.id.toString());

        // final prefs = await SharedPreferences.getInstance();
        // prefs.setString('staffId', user.id.toString());
        // prefs.setString('token', user.token.toString());

        return user;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  Future<void> updateAvatar(File image) async {
    final prefs = await SharedPreferences.getInstance();
    // String? id = prefs.getString("id");

    String url = APIProvider().url + 'brokers/profile/avatar';

    String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{
      "Content-Type": "multipart/form-data",
      "accept": "text/plain",
    };
    // Map<String, String> heads = Map<String, String>();
    headers['Authorization'] = "Bearer " + token!;

    try {
      var request = http.MultipartRequest('PUT', Uri.parse(url));
      request.headers.addAll(headers);
      request.files.add(http.MultipartFile.fromBytes(
          'file', await image.readAsBytes(),
          filename: "file"));
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
  }

  Future<void> updatePassword(String oldPassword, String newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    String url = APIProvider().url + "brokers/profile/password";

    Map<String, String> headers = <String, String>{
      "Content-Type": "application/json",
      "accept": "text/plain",
    };
    // Map<String, String> heads = Map<String, String>();
    headers['Authorization'] = "Bearer " + token!;
    Map<String, String> bodys = <String, String>{};

    bodys['oldPassword'] = oldPassword;
    bodys['newPassword'] = newPassword;

    try {
      final response = await http.put(Uri.parse(url),
          headers: headers, body: jsonEncode(bodys));
      if (response.statusCode == 200) {
        print("updatedPassword");
        return;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  Future<void> resetPassword(String email) async {
    // final prefs = await SharedPreferences.getInstance();

    String url = APIProvider().url + "brokers/reset-password";

    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{
      "Content-Type": "application/json",
      "accept": "text/plain",
    };
    // Map<String, String> heads = Map<String, String>();
    // headers['Authorization'] = "Bearer " + token!;
    // Map<String, String> bodys = <String, String>{};

    // bodys[''] = email;

    try {
      final response = await http.put(Uri.parse(url),
          headers: headers, body: jsonEncode(email));
      if (response.statusCode == 200) {
        print("updatedPassword");
        return;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }
}
