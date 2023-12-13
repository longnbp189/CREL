import 'dart:io';

import 'package:crel_mobile/config/api_provider.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/models/contract.dart';
import 'package:crel_mobile/models/media.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ContractRepo {
  late String _localPath;
  late bool _permissionReady;
  late TargetPlatform? platform;
  final Dio dio = Dio();

  Future<List<Contract>> getListContract(int pageNum, int pageSize) async {
    String url = APIProvider().url +
        'contracts?OrderBy=28&PageNumber=$pageNum&PageSize=$pageSize';
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        var contract = data.map((json) => Contract.fromJson(json)).toList();
        return contract;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  Future<Contract> getContractByBrand(int brandId) async {
    String url = APIProvider().url + 'contracts?BrandId=$brandId';
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var contract = Contract.fromJson(jsonDecode(response.body));
        return contract;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  // Future<List<Contract>> getListContractByBrokerId(
  //     int pageNum, int pageSize) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? id = prefs.getString("id");
  //   String url = APIProvider().url +
  //       'contracts?PageNumber=$pageNum&PageSize=$pageSize$id';
  //   String? token = prefs.getString('token');
  //   // String? token = prefs.getString('token');
  //   Map<String, String> headers = <String, String>{};
  //   headers['Authorization'] = "Bearer " + token!;

  //   try {
  //     final response = await http.get(Uri.parse(url), headers: headers);
  //     if (response.statusCode == 200) {
  //       List data = jsonDecode(response.body);

  //       var contract = data.map((json) => Contract.fromJson(json)).toList();
  //       return contract;
  //     } else {
  //       throw Exception('Not 200');
  //     }
  //   } catch (e) {
  //     throw Exception('Not Found');
  //   }
  // }

  Future<Contract> getContractById(int id) async {
    String url = APIProvider().url + 'contracts/$id';
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var contract = Contract.fromJson(jsonDecode(response.body));
        return contract;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  // Future<Contract> getContractByIdFile(int id) async {
  //   String url = APIProvider().url + 'contracts/$id/word-file';

  //   // String? token = prefs.getString('token');
  //   Map<String, String> headers = <String, String>{
  //     "accept": "*/*",
  //   };
  //   // headers['Authorization'] = "Bearer " + token!;

  //   try {
  //     final response = await http.get(Uri.parse(url), headers: headers);
  //     if (response.statusCode == 200) {
  //       // Directory tempDir = await getTemporaryDirectory();
  //       // String tempPath = tempDir.path;
  //       // _permissionReady = await _checkPermission();
  //       // if (_permissionReady) {
  //       await _prepareSaveDir();
  //       print("Downloading");
  //       try {
  //         await Dio().download(url, _localPath + "hopdong.pdf");
  //         print("Download Completed.");
  //       } catch (e) {
  //         print("Download Failed.\n\n" + e.toString());
  //       }
  //       // }
  //       // down
  //       // print(tempPath);
  //       var contract = Contract.fromJson(jsonDecode(response.body));
  //       return contract;
  //     } else {
  //       throw Exception('Not 200');
  //     }
  //   } catch (e) {
  //     throw Exception('Not Found');
  //   }
  // }

  Future openFilee(Contract contract) async {
    int id = contract.id!;
    String brandName = contract.brand!.name!;
    String startTime =
        AppFormat.parseDateContract(contract.startDate.toString());
    String nameFile = brandName + "_" + startTime;
    final file = await downloadFilee(
        APIProvider().url + "contracts/$id/pdf-file", nameFile);
    if (file == null) return;
    OpenFile.open(file.path);
  }

  Future<File?> downloadFilee(String url, String name) async {
    final store = await getApplicationDocumentsDirectory();
    final file = File('${store.path}/$name');
    Dio dio = Dio();
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      // await Dio().download(url, "aaa/a.png");
      // return null;
      dio.options.headers['Authorization'] = "Bearer " + token!;
      final response = await dio.get(url,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0));
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (e) {
      return null;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  // Future<bool> downloadFile(Contract contract) async {
  //   // setState(() {
  //   //   loading = true;
  //   //   progress = 0;
  //   // });
  //   int id = contract.id!;
  //   bool downloaded =
  //       await saveFile(APIProvider().url + "contracts/$id/word-file");
  //   if (downloaded) {
  //     print("File Downloaded");
  //     return true;
  //   } else {
  //     print("Problem Downloading File");
  //     return false;
  //   }
  //   // setState(() {
  //   //   loading = false;
  //   // });
  // }

  Future downloadNoti(Contract contract) async {
    int id = contract.id!;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers['accept'] = '*/*';
    headers['Authorization'] = "Bearer " + token!;
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final baseStorage = await getExternalStorageDirectory();

      await FlutterDownloader.enqueue(
        url: APIProvider().url + 'contracts/$id/word-file',
        headers: headers, // optional: header send with url (auth token etc)
        savedDir: baseStorage!.path,
        saveInPublicStorage: true,
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );
    }
  }

  Future<bool> saveFile(String url) async {
    Directory? directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          String newPath = "";
          print(directory);
          List<String> paths = directory!.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/CREL";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      File saveFile = File(directory.path);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        await dio.download(url, saveFile.path
            // ,
            //     onReceiveProgress: (value1, value2) {
            //   // setState(() {
            //   //   progress = value1 / value2;
            //   // });
            // }
            );
        // if (Platform.isIOS) {
        //   await ImageGallerySaver.saveFile(saveFile.path,
        //       isReturnPathOfIOS: true);
        // }
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Contract> getContractByIdFile(int id) async {
    String url = APIProvider().url + 'contracts/$id/word-file';
    Map<String, String> headers = <String, String>{
      "accept": "*/*",
    };
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        var contract = Contract.fromJson(jsonDecode(response.body));
        return contract;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;

    print(_localPath);
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<bool> _checkPermission() async {
    if (platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<String?> _findLocalPath() async {
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
    if (platform == TargetPlatform.android) {
      // return "/sdcard/download/";
      // } else {
      // var p = await Androi
      var directory = await getApplicationDocumentsDirectory();
      return directory.path + Platform.pathSeparator + 'Download';
    }
    return null;
  }

  Future<Contract> createContract(Contract contract) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String url = APIProvider().url + 'contracts';

    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{
      "Content-Type": "application/json",
      "accept": "text/plain",
    };
    headers['Authorization'] = "Bearer " + token!;
    try {
      final response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(contract.toJson()));
      if (response.statusCode == 200) {
        var contract = Contract.fromJson(jsonDecode(response.body));
        return contract;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  Future<void> updateImageContract(List<XFile> image, int id) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (image.isNotEmpty) {
      String url = APIProvider().url + 'contracts/$id/media';

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

  Future<void> deleteMediaContract(
      List<Media> mediaAdd, List<Media> mediaSaved) async {
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

  Future<Contract> updateContract(Contract contract) async {
    String url = APIProvider().url + 'contracts';
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    // String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{
      "Content-Type": "application/json",
      "accept": "text/plain",
    };
    headers['Authorization'] = "Bearer " + token!;
    try {
      final response = await http.put(Uri.parse(url),
          headers: headers, body: jsonEncode(contract.toJson()));
      if (response.statusCode == 200) {
        var contract = Contract.fromJson(jsonDecode(response.body));
        return contract;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  // Future<Store> createStore(Store store) async {
  //   String url = APIProvider().url + 'stores';

  //   // String? token = prefs.getString('token');
  //   Map<String, String> headers = <String, String>{
  //     "Content-Type": "application/json",
  //     "accept": "text/plain",
  //   };
  //   // headers['Authorization'] = "Bearer " + token!;

  //   try {
  //     final response = await http.post(Uri.parse(url),
  //         headers: headers, body: jsonEncode(store.toJson()));
  //     if (response.statusCode == 200) {
  //       var store = Store.fromJson(jsonDecode(response.body));
  //       return store;
  //     } else {
  //       throw Exception('Not 200');
  //     }
  //   } catch (e) {
  //     throw Exception('Not Found');
  //   }
  // }

  Future<List<Contract>> searchContractByMonth(
      int pageNum, int pageSize, DateTime startMonth, DateTime endMonth) async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    String url = APIProvider().url +
        'contracts?BrokerId=$id&OrderBy=20&PageNumber=$pageNum&PageSize=$pageSize&MaxCreateDate=$endMonth&MinCreateDate=$startMonth';

    String? token = prefs.getString('token');
    Map<String, String> headers = <String, String>{};
    headers['Authorization'] = "Bearer " + token!;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        var appointments = data.map((json) => Contract.fromJson(json)).toList();

        return appointments;
      } else {
        throw Exception('Not 200');
      }
    } catch (e) {
      throw Exception('Not Found');
    }
  }

  // Future<List<Contract>> searchPropertyByMonthOfContract(int pageNum,
  //     int pageSize, DateTime startDate, DateTime endDate, int property) async {
  //   // final prefs = await SharedPreferences.getInstance();
  //   // String? id = prefs.getString("id");
  //   String url = APIProvider().url +
  //       'contracts?OrderBy=22&PropertyId=$property&Status=1&PageNumber=$pageNum&PageSize=$pageSize&MaxEndDate=$endDate&MinEndDate=$startDate';

  //   // String? token = prefs.getString('token');
  //   Map<String, String> headers = <String, String>{};
  //   // headers['Authorization'] = "Bearer " + token!;
  //   List<Contract> contractProperty = [];
  //   try {
  //     final response = await http.get(Uri.parse(url), headers: headers);
  //     if (response.statusCode == 200) {
  //       String url1 = APIProvider().url +
  //           'contracts?OrderBy=22&PropertyId=$property&Status=1&PageNumber=$pageNum&PageSize=$pageSize&MaxStartDate=$endDate&MinStartDate=$startDate';
  //       final response1 = await http.get(Uri.parse(url1), headers: headers);

  //       List data = jsonDecode(response.body);
  //       var contracts = data.map((json) => Contract.fromJson(json)).toList();
  //       List data1 = jsonDecode(response1.body);
  //       var contracts1 = data1.map((json) => Contract.fromJson(json)).toList();
  //       contractProperty = contracts + contracts1;
  //       return contractProperty;
  //     } else {
  //       throw Exception('Not 200');
  //     }
  //   } catch (e) {
  //     throw Exception('Not Found');
  //   }
  // }
}
