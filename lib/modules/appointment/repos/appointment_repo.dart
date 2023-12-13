import 'dart:convert';

import 'package:crel_mobile/config/api_provider.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentRepo {
  Future<Appointment> getAppointmentById(int id) async {
    String url = APIProvider().url + 'appointments/$id';
    final prefs = await SharedPreferences.getInstance();
    //   String? id = prefs.getString("id");
    String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var appointment = Appointment.fromJson(jsonDecode(response.body));
        return appointment;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  Future<List<Appointment>> getListToCreateAppointment(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    String url = APIProvider().url +
        "appointments?BrokerId=$id&MaxOnDateTime=$endDate&MinOnDateTime=$startDate&Status=2&PageSize=200";
    // 'appointments?OrderBy=2&BrokerId=$id&Status=1&PageNumber=$pageNum&PageSize=$pageSize';

    String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        var appointments =
            data.map((json) => Appointment.fromJson(json)).toList();

        return appointments;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // Future<List<Appointment>> getListAppointment(
  //     int pageNum, int pageSize, int? status, String name) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? id = prefs.getString("id");
  //   String url = "";

  //   if (status == null) {
  //     url = APIProvider().url +
  //         'appointments?OrderBy=2&BrokerId=$id&PageNumber=$pageNum&PageSize=$pageSize';
  //   } else {
  //     url = APIProvider().url +
  //         'appointments?OrderBy=2&BrokerId=$id&Status=$status&PageNumber=$pageNum&PageSize=$pageSize';
  //   }

  //   // String? token = prefs.getString('token');
  //   Map<String, String> headers = <String, String>{};
  //   // headers['Authorization'] = "Bearer " + token!;

  //   try {
  //     final response = await http.get(Uri.parse(url), headers: headers);
  //     if (response.statusCode == 200) {
  //       List data = jsonDecode(response.body);
  //       var appointments =
  //           data.map((json) => Appointment.fromJson(json)).toList();

  //       return appointments;
  //     } else {
  //       return [];
  //     }
  //   } catch (e) {
  //     return [];
  //   }
  // }

  Future<List<Appointment>> getListAppointment(
      int pageNum, int pageSize) async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    String url = APIProvider().url +
        'appointments?OrderBy=2&BrokerId=$id&Status=2&PageNumber=$pageNum&PageSize=$pageSize';

    String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        var appointments =
            data.map((json) => Appointment.fromJson(json)).toList();

        return appointments;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<Appointment>> getListConfirmAppointment(
      int pageNum, int pageSize) async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    String url = APIProvider().url +
        'appointments?OrderBy=10&BrokerId=$id&Status=1&PageNumber=$pageNum&PageSize=$pageSize';

    String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        var appointments =
            data.map((json) => Appointment.fromJson(json)).toList();

        return appointments;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<Appointment>> getListAppointmentCalendar(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    String url = APIProvider().url +
        "appointments?BrokerId=$id&MaxOnDateTime=$endDate&MinOnDateTime=$startDate&ListStatus=2&ListStatus=4&PageSize=200";
    // 'appointments?OrderBy=2&BrokerId=$id&Status=1&PageNumber=$pageNum&PageSize=$pageSize';

    String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        var appointments =
            data.map((json) => Appointment.fromJson(json)).toList();

        return appointments;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<int> getListAppointmentConfirm() async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    String url = APIProvider().url +
        'appointments?BrokerId=$id&Status=1&PageNumber=0&PageSize=0';

    String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        // List data = jsonDecode(response.body);
        var header =
            jsonDecode(response.headers["pagination"]!) as Map<String, dynamic>;
        var count = header["totalItems"];
        // var count = header["pagination" "totalItems"].toString();
        // final xPaginacao =
        //     jsonDecode(response.headers["pagination"]!["totalItems"])
        // as Map<String, dynamic>;
        // var appointments =
        //     data.map((json) => Appointment.fromJson(json)).toList();

        return int.parse(count.toString());
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  Future<List<Appointment>> searchAppointmentByMonth(
      int pageNum, int pageSize, DateTime startMonth, DateTime endMonth) async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    String url = APIProvider().url +
        'appointments?BrokerId=$id&OrderBy=10&ListStatus=2&ListStatus=4&ListStatus=5&ListStatus=3&PageNumber=$pageNum&PageSize=$pageSize&MaxOnDateTime=$endMonth&MinOnDateTime=$startMonth';

    String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        var appointments =
            data.map((json) => Appointment.fromJson(json)).toList();

        return appointments;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  Future<Appointment> updateAppointment(Appointment appointment) async {
    String url = APIProvider().url + 'appointments';
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{
      "Content-Type": "application/json",
      "accept": "text/plain",
    };
    // Map<String, String> heads = Map<String, String>();
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.put(Uri.parse(url),
          headers: headers, body: jsonEncode(appointment.toJson()));
      // headers: headers);
      if (response.statusCode == 200) {
        var appointment = Appointment.fromJson(json.decode(response.body));
        return appointment;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  Future<Appointment> createAppointment(Appointment appointment) async {
    String url = APIProvider().url + 'appointments';
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{
      "Content-Type": "application/json",
      "accept": "text/plain",
    };
    // Map<String, String> heads = Map<String, String>();
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(appointment.toJson()));
      // headers: headers);
      if (response.statusCode == 200) {
        var appointment = Appointment.fromJson(json.decode(response.body));

        return appointment;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  // Future<void> addListPropertyToAppointment(
  //     int id, List<int> idProperty) async {
  //   List<int> ids = [];
  //   for (var item in idProperty) {
  //     ids.add(item);
  //   }
  //   String url = APIProvider().url + 'appointments/$id/properties';

  //   // String? token = prefs.getString('token');
  //   Map<String, String> headers = <String, String>{
  //     "Content-Type": "application/json",
  //     "accept": "text/plain",
  //   };
  //   // Map<String, String> heads = Map<String, String>();
  //   // headers['Authorization'] = "Bearer " + token!;

  //   try {
  //     final response = await http.post(Uri.parse(url),
  //         headers: headers, body: jsonEncode(ids));
  //     // headers: headers);
  //     if (response.statusCode == 200) {
  //       print("add success");
  //       //  List data = jsonDecode(response.body);
  //       // var appointments =
  //       //     data.map((json) => Appointment.fromJson(json)).toList();

  //       // return appointments;
  //     } else {
  //       throw Exception('Not 200');
  //     }
  //   } catch (e) {
  //     throw Exception('Not Found');
  //   }
  // }

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
