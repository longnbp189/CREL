import 'dart:convert';

import 'package:crel_mobile/config/api_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepo {
  // Future<void> signUp({required String email, required String password}) async {
  //   try {
  //     await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       throw Exception('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       throw Exception('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  // Future<void> signIn({
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       throw Exception('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       throw Exception('Wrong password provided for that user.');
  //     }
  //   }
  // }

  Future<void> signOut() async {
    try {
      // GoogleSignIn().disconnect();
      // await _firebaseAuth.signOut();
      final prefs = await SharedPreferences.getInstance();
      String? id = prefs.getString("id");
      FirebaseMessaging.instance.unsubscribeFromTopic("Broker" + id.toString());
      // FirebaseMessaging.instance.unsubscribeFromTopic(topic);
      prefs.clear();
    } catch (e) {
      throw Exception(e);
    }
  }

  static String url = APIProvider().url + 'brokers/authenticate';

  Future<int> loginAPI(
      // String? accessToken,
      String? username,
      String? password) async {
    Map<String, String> bodys = <String, String>{};
    Map<String, String> headers = <String, String>{
      "Content-Type": "application/json",
      "accept": "text/plain",
    };
    // bodys['token'] = accessToken!;
    bodys['userName'] = username!;
    bodys['password'] = password!;
    // print(accessToken);

    try {
      final response = await http.post(
          Uri.parse(url
              // + "?Token=$accessToken"
              ),
          headers: headers,
          body: jsonEncode(bodys));
      if (response.statusCode == 200) {
        String token = jsonDecode(response.body)["token"];
        String id = jsonDecode(response.body)["user"]["id"].toString();
        int status =
            int.parse(jsonDecode(response.body)["user"]["status"].toString());
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", token);
        await prefs.setString("id", id);
        debugPrint(token);
        // var broker = Broker.fromJson(jsonDecode(response.body));
        FirebaseMessaging.instance.subscribeToTopic("Broker" + id.toString());

        return status;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  // Future<void> signInWithUsernamePassword(
  //     {required String username, required String password}) async {
  //   try {
  //     await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: username, password: password);

  //     // await loginAPI(await FirebaseAuth.instance.currentUser!.getIdToken());
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       throw Exception('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       throw Exception('Wrong password provided for that user.');
  //     } else {
  //       throw Exception(e.toString());
  //     }
  //   }
  // }
}
