import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:html/parser.dart';

import 'dart:math' show sin, cos, sqrt, atan2;
import 'package:vector_math/vector_math.dart' as vector;

class Distance {
  final double la;
  final double lo;

  Distance(this.la, this.lo);
}

class AppFormat {
  // String parseDate(DateTime date) {
  //   String formattedDate = DateFormat.yMMMEd().format(date);
  //   return formattedDate;
  // }
  static List<String> getListCertificate() {
    List<String> certificates = ['Đang chờ sổ', 'Đã có sổ', 'Giấy tờ khác'];
    return certificates;
  }

  static List<String> getListStatusProperty() {
    List<String> certificates = ['Đợi cập nhật', 'Đợi cho thuê'];
    return certificates;
  }

//   static bool caculatorDistance(List<Property> property) {
//     // bool isTrue = false;
//     // distance = [
//     //   Distance(10.841705315866355, 106.8377540833799), //2
//     //   Distance(11.07391184889043, 107.0881370203988), //3
//     //   Distance(10.738608224116575, 106.71027928474346), //1
//     // ];
//     double earthRadius = 6371000; //bán kính trái đất
// //first
//     // double currentPositionLatitude = 10.841705315866355;
//     // double currentPositionLongitude = 106.8377540833799;
//     double currentPositionLatitude = property[0].location!.latitude!;
//     double currentPositionLongitude = property[0].location!.longitude!;
// //second
//     // double pLat = 10.7391849890335;
//     // double pLng = 106.70994735184875;

//     // for (var element in property) {

//     // }
//     if (property.length >= 2) {
//       for (var i = 0; i < property.length - 1; i++) {
//         var dLat = vector.radians(
//             currentPositionLatitude - property[i + 1].location!.latitude!);
//         var dLng = vector.radians(
//             currentPositionLongitude - property[i + 1].location!.longitude!);
//         var a = sin(dLat / 2) * sin(dLat / 2) +
//             cos(vector.radians(property[i + 1].location!.latitude!)) *
//                 cos(vector.radians(currentPositionLatitude)) *
//                 sin(dLng / 2) *
//                 sin(dLng / 2);
//         var c = 2 * atan2(sqrt(a), sqrt(1 - a));
//         var d = earthRadius * c / 1000;
//         if (d >= 10) {
//           print(d);
//           return false;
//         }
//         print(d);
//       }

//       var dLat = vector.radians(
//           property[2].location!.latitude! - property[1].location!.latitude!);
//       var dLng = vector.radians(
//           property[2].location!.longitude! - property[1].location!.longitude!);
//       var a = sin(dLat / 2) * sin(dLat / 2) +
//           cos(vector.radians(property[1].location!.latitude!)) *
//               cos(vector.radians(currentPositionLatitude)) *
//               sin(dLng / 2) *
//               sin(dLng / 2);
//       var c = 2 * atan2(sqrt(a), sqrt(1 - a));
//       var d = earthRadius * c / 1000;
//       if (d >= 10) {
//         print(d);
//         return false;
//       }
//     }
//     // for (var i = 0; i < property.length - 1; i++) {
//     //   var dLat = vector.radians(currentPositionLatitude - property[i + 1].location!.latitude!);
//     //   var dLng = vector.radians(currentPositionLongitude - property[i + 1].location!.longitude!);
//     //   var a = sin(dLat / 2) * sin(dLat / 2) +
//     //       cos(vector.radians(property[i + 1].location!.latitude!)) *
//     //           cos(vector.radians(currentPositionLatitude)) *
//     //           sin(dLng / 2) *
//     //           sin(dLng / 2);
//     //   var c = 2 * atan2(sqrt(a), sqrt(1 - a));
//     //   var d = earthRadius * c / 1000;
//     //   if (d >= 10) {
//     //     print(d);
//     //     // return false;
//     //   }
//     //   print(d);
//     // }
//     // print(d);

//     return true;

// //Calculating the distance between two points
//     // getDistance() {
//     // var dLat = vector.radians(currentPositionLatitude - pLat);
//     // var dLng = vector.radians(currentPositionLongitude - pLng);
//     // var a = sin(dLat / 2) * sin(dLat / 2) +
//     //     cos(vector.radians(pLat)) *
//     //         cos(vector.radians(currentPositionLatitude)) *
//     //         sin(dLng / 2) *
//     //         sin(dLng / 2);
//     // var c = 2 * atan2(sqrt(a), sqrt(1 - a));
//     // var d = earthRadius * c / 1000;
//     // print(d); //d is the distance in meters
//     // // }

//     // return d;
//   }

  static bool caculatorDistance(List<Distance> distance) {
    // bool isTrue = false;
    // distance = [
    //   Distance(10.841705315866355, 106.8377540833799), //2
    //   Distance(11.07391184889043, 107.0881370203988), //3
    //   Distance(10.738608224116575, 106.71027928474346), //1
    // ];
    double earthRadius = 6371000; //bán kính trái đất
//first
    // double currentPositionLatitude = 10.841705315866355;
    // double currentPositionLongitude = 106.8377540833799;
    double currentPositionLatitude = distance[0].la;
    double currentPositionLongitude = distance[0].lo;
//second
    // double pLat = 10.7391849890335;
    // double pLng = 106.70994735184875;

    // for (var element in property) {

    // }
    if (distance.length >= 2) {
      for (var i = 0; i < distance.length - 1; i++) {
        var dLat = vector.radians(currentPositionLatitude - distance[i + 1].la);
        var dLng =
            vector.radians(currentPositionLongitude - distance[i + 1].lo);
        var a = sin(dLat / 2) * sin(dLat / 2) +
            cos(vector.radians(distance[i + 1].la)) *
                cos(vector.radians(currentPositionLatitude)) *
                sin(dLng / 2) *
                sin(dLng / 2);
        var c = 2 * atan2(sqrt(a), sqrt(1 - a));
        var d = earthRadius * c / 1000;
        if (d >= 10) {
          print(d);
          print("vòng1");

          return false;
        }
        print("vòng1.1");

        print(d);
      }
      if (distance.length == 3) {
        var dLat = vector.radians(distance[2].la - distance[1].la);
        var dLng = vector.radians(distance[2].lo - distance[1].lo);
        var a = sin(dLat / 2) * sin(dLat / 2) +
            cos(vector.radians(distance[1].la)) *
                cos(vector.radians(currentPositionLatitude)) *
                sin(dLng / 2) *
                sin(dLng / 2);
        var c = 2 * atan2(sqrt(a), sqrt(1 - a));
        var d = earthRadius * c / 1000;
        if (d >= 10) {
          print(d);
          print("vòng2");
          return false;
        }
      }
      print("vòng3");
    }
    print("Pass");

    // for (var i = 0; i < property.length - 1; i++) {
    //   var dLat = vector.radians(currentPositionLatitude - property[i + 1].location!.latitude!);
    //   var dLng = vector.radians(currentPositionLongitude - property[i + 1].location!.longitude!);
    //   var a = sin(dLat / 2) * sin(dLat / 2) +
    //       cos(vector.radians(property[i + 1].location!.latitude!)) *
    //           cos(vector.radians(currentPositionLatitude)) *
    //           sin(dLng / 2) *
    //           sin(dLng / 2);
    //   var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    //   var d = earthRadius * c / 1000;
    //   if (d >= 10) {
    //     print(d);
    //     // return false;
    //   }
    //   print(d);
    // }
    // print(d);

    return true;

//Calculating the distance between two points
    // getDistance() {
    // var dLat = vector.radians(currentPositionLatitude - pLat);
    // var dLng = vector.radians(currentPositionLongitude - pLng);
    // var a = sin(dLat / 2) * sin(dLat / 2) +
    //     cos(vector.radians(pLat)) *
    //         cos(vector.radians(currentPositionLatitude)) *
    //         sin(dLng / 2) *
    //         sin(dLng / 2);
    // var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    // var d = earthRadius * c / 1000;
    // print(d); //d is the distance in meters
    // // }

    // return d;
  }

  static List<String> getListGender() {
    List<String> genders = ['Nam', 'Nữ'];
    return genders;
  }

  static List<String> getListDirection() {
    List<String> certificates = [
      'Bắc',
      'Đông Bắc',
      'Đông',
      'Đông Nam',
      'Nam',
      'Tây Nam',
      'Tây',
      'Tây Bắc'
    ];
    return certificates;
  }

  static List<String> getListFreeTimeAppointment(DateTime date) {
    List<String> freeTimeAppointment = [
      // '08:00 - 10:00',
      // '10:00 - 12:00',
      // '13:00 - 15:00',
      // '15:00 - 17:00',
      // '17:00 - 19:00',
      // '19:00 - 21:00',
      '08:00',
      '09:00',
      '10:00',
      '11:00',
      '12:00',
      '13:00',
      '14:00',
      '15:00',
      '16:00',
      '17:00',
      '18:00',
      '19:00'
    ];
    // List<String> freeTimeCurrent = [];

    // for (var element in freeTimeAppointment) {
    //   // if (DateTime(date.year, date.month, date.day).compareTo(DateTime(
    //   //         DateTime.now().year, DateTime.now().month, DateTime.now().day)) ==
    //   //     0) {
    //   //   if (DateTime.now().hour.compareTo(int.parse(element.substring(0, 2))) <
    //   //       0) {
    //   //     freeTimeCurrent.add(element);
    //   //   }
    //   // } else {
    //   //   freeTimeCurrent.add(element);
    //   // }
    //   DateTime validTime = DateTime.now().add(const Duration(hours: 1));
    //   date = DateTime(date.year, date.month, date.day,
    //       int.parse(element.substring(0, 2)), DateTime.now().minute);
    //   if (DateTime(date.year, date.month, date.day,
    //               int.parse(element.substring(0, 2)), DateTime.now().minute)
    //           .compareTo(DateTime(validTime.year, validTime.month,
    //               validTime.day, validTime.hour, DateTime.now().minute)) >
    //       0) {
    //     // if (DateTime.now().hour.compareTo(int.parse(element.substring(0, 2))) <
    //     //     0) {
    //     freeTimeCurrent.add(element);
    //     // }
    //   }
    //   //  else {
    //   // freeTimeCurrent.add(element);
    //   // }
    //   // if (date.compareTo(DateTime(DateTime.now().year, DateTime.now().month,
    //   //         DateTime.now().day, int.parse(element.substring(0, 2)))) >
    //   //     0) {
    //   //   freeTimeCurrent.add(element);
    //   // }
    // }
    // return freeTimeCurrent;
    return freeTimeAppointment;
  }

  static List<String> getListRefuseAppointmnet() {
    List<String> refuses = ['Có việc bận đột xuất', 'Bị hỏng xe'];
    return refuses;
  }

  static List<String> getListBanking() {
    List<String> banking = [
      'BIDV (Đầu tư và Phát triển Việt Nam)',
      'VietinBank (Công thương Việt Nam)',
      'Vietcombank (Ngoại Thương Việt Nam)',
      'VPBank (Việt Nam Thịnh Vượng)',
      'MB (Quân Đội)',
      'Techcombank (Kỹ Thương)',
      'Agribank (NN&PT Nông thôn Việt Nam)',
      'ACB (Á Châu)',
      'SHB (Sài Gòn – Hà Nội)',
      'Sacombank (Sài Gòn Thương Tín)',
      'VBSP (Chính sách xã hội Việt Nam)',
      'VIB (Quốc Tế)',
      'MSB (Hàng Hải)',
      'SCB (Sài Gòn)',
      'VDB (Phát triển Việt Nam)',
      'SeABank (Đông Nam Á)',
      'OCB (Phương Đông)',
      'TPBank (Tiên Phong)',
      'Bac A Bank (Bắc Á)',
      'HSBC (HSBC Việt Nam)',
      'DongA Bank (Đông Á)',
      'VietABank (Việt Á)',
      'Nam A Bank (Nam Á)',
      'OceanBank (Đại Dương)',
      'SAIGONBANK (Sài Gòn Công Thương)',
      'Vietbank (Việt Nam Thương Tín)',
      'HDBank (Phát triển Thành phố Hồ Chí Minh)'
    ];
    return banking;
  }

  static List<String> getListStatusAppointment() {
    List<String> refuses = ['Không diễn ra', 'Đã diễn ra'];
    return refuses;
  }

  static List<String> getListDeleteContract() {
    List<String> refuses = [
      'Bên thương hiệu hủy hợp đồng',
      'Bên thương hiệu phá sản'
    ];
    return refuses;
  }

  static List<String> getListParking() {
    List<String> parkings = ['Không', 'Có'];
    return parkings;
  }

  static String parseDate(String date) {
    DateTime dt = DateTime.parse(date);
    String formattedDate = DateFormat('dd/MM/yyyy').format(dt);
    return formattedDate;
  }

  static String parseDateContract(String date) {
    DateTime dt = DateTime.parse(date);
    String formattedDate = DateFormat('dd-MM-yyyy').format(dt);
    return formattedDate;
  }

  static String statusAppointment(String status) {
    switch (int.parse(status.toString())) {
      // case 0:
      //   status = "Bị từ chối";
      //   break;
      case 1:
        status = "Chờ duyệt";
        break;
      case 2:
        status = "Được duyệt";
        break;
      case 4:
        status = "Đã diễn ra";
        break;
      case 5:
        status = "Không diễn ra";

        break;
      case 3:
        status = "Từ chối";

        break;
      case 6:
        status = "Chờ duyệt";
        break;
    }

    return status;
  }

  static Widget statusIconNoti(int status) {
    switch (status) {
      // case 0:
      //   status = "Bị từ chối";
      //   break;
      // case 1:
      //   SvgPicture.asset(pictureProvider);
      //   break;
      case 1:
        return SvgPicture.asset("assets/icons/clock.svg");
      case 2:
        return SvgPicture.asset("assets/icons/clock.svg");
      case 12:
        return SvgPicture.asset("assets/icons/info-circle.svg");

      //  case 2:
      // return SvgPicture.asset("assets/icons/mission.svg");
      // case 4:
      //   status = "Đã diễn ra";
      //   break;
      case 5:
        return SvgPicture.asset("assets/icons/building.svg");

      // case 3:
      //   status = "Từ chối";

      //   break;
      default:
        return SvgPicture.asset("assets/icons/close.svg");
    }
  }

  static Color statusColorAppointment(int status) {
    Color? color;
    switch (int.parse(status.toString())) {
      case 2:
        color = AppColor.blue;
        break;
      case 4:
        color = AppColor.green;
        break;
      case 5:
        color = AppColor.red;

        break;
      case 3:
        color = AppColor.red;

        break;
      case 6:
        color = AppColor.yellow;
        break;
    }

    return color!;
  }

  static String parseFormatDateAndTimeNoti(String date) {
    DateTime dt = DateTime.parse(date);
    String formattedDate = DateFormat('HH:mm, dd/MM/yyyy').format(dt);
    return formattedDate;
  }

  static DateTime parseDateNoti(String date) {
    DateTime tempDate = DateFormat("yyyy/MM/dd HH:mm").parse(date);
    return tempDate;
  }

  static String parseMonth(String date) {
    DateTime dt = DateTime.parse(date);
    String formattedDate = DateFormat('MM/yyyy').format(dt);
    return formattedDate;
  }

  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  static String parseYear(String date) {
    DateTime dt = DateTime.parse(date);
    String formattedDate = DateFormat('yyyy').format(dt);
    return formattedDate;
  }

  static String parseTime(String date) {
    DateTime dt = DateTime.parse(date);
    String formattedTime = DateFormat('HH:mm').format(dt);
    return formattedTime;
  }

  static DateTime getDateNow() {
    DateTime now = DateTime.now();
    DateTime dateNow = DateTime(now.year, now.month, now.day);
    return dateNow;
  }

  static DateTime getYearAndMonthNow() {
    DateTime now = DateTime.now();
    DateTime dateNow = DateTime(now.year, now.month);
    return dateNow;
  }

  static DateTime getYear18() {
    DateTime now = DateTime.now();
    DateTime date18 = DateTime(now.year - 18, now.month, now.day);
    return date18;
  }

  static DateTime getYear18Before100() {
    DateTime now = DateTime.now();
    DateTime date18 = DateTime(now.year - 100, now.month, now.day);
    return date18;
  }

  static DateTime connectDateTime(DateTime date, TimeOfDay time) {
    DateTime dt =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    return dt;
  }

  static DateTime startDayOfMonth(DateTime date) {
    DateTime dt = DateTime(date.year, date.month, 1);
    return dt;
  }

  static DateTime endDayOfMonth(DateTime date) {
    DateTime dt = DateTime(date.year, date.month + 1, 0);
    return dt;
  }

  static DateTime currentDateTime(DateTime date) {
    DateTime dt =
        DateTime(date.year, date.month, date.day, date.hour, date.minute);
    return dt;
  }
  // static String parseTimeOfDay(String date) {
  //   DateTime dt = DateTime.parse(date);
  //   String formattedTime = DateFormat('HH:mm').format(dt);
  //   return formattedTime;
  // }

  static String parseDateAndTime(String date) {
    DateTime dt = DateTime.parse(date);
    String formattedTime = DateFormat('dd-MM-yyyy HH:mm').format(dt);
    return formattedTime;
  }

  static String parseTimeAndDate(String date) {
    DateTime dt = DateTime.parse(date);
    String formattedTime = DateFormat('HH:mm dd-MM-yyyy').format(dt);
    return formattedTime;
  }

  static void showSnackBar(BuildContext context, int color, String name) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color == 1 ? Colors.green : Colors.red,
      content:
          Text(name, style: TxtStyle.heading4.copyWith(color: Colors.white)),
    ));
  }

  static String parseDay(String date) {
    DateTime dt = DateTime.parse(date);
    String formattedTime = DateFormat('EEEE').format(dt);
    switch (formattedTime) {
      case "Monday":
        formattedTime = "Thứ 2";
        break;
      case "Tuesday":
        formattedTime = "Thứ 3";
        break;
      case "Wednesday":
        formattedTime = "Thứ 4";
        break;
      case "Thursday":
        formattedTime = "Thứ 5";
        break;
      case "Friday":
        formattedTime = "Thứ 6";
        break;
      case "Saturday":
        formattedTime = "Thứ 7";
        break;
      case "Sunday":
        formattedTime = "Chủ nhật";
        break;
      // default:
    }
    return formattedTime;
  }

  static bool validatePassword(String password) {
    RegExp regex = RegExp(
        // r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_()[]]).{8,}$');
        r"^(?=.*[A-Z])(?=.*[!@#$%^&*()\-_=+{}[\]?<>.,])(?=.*[0-9])(?=.*[a-z]).{8,}$");
    if (regex.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  static bool validateEmail(String email) {
    RegExp regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (regex.hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  static String tryParseDate(String date) {
    try {
      var inputFormat = DateFormat('dd/MM/yyyy');
      DateTime dt = inputFormat.parse(date);
      String formattedDate = inputFormat.format(dt);
      return formattedDate;
    } catch (e) {
      return "";
    }
  }

  static String parseDateTime(String dateTime) {
    DateTime dt = DateTime.parse(dateTime);
    var duration = DateTime.now().difference(dt);
    if (duration < const Duration(hours: 1)) {
      return '${duration.inMinutes.remainder(60)} phút trước';
    }
    if (duration < const Duration(days: 1)) {
      return '${duration.inHours} giờ trước';
    }
    if (duration < const Duration(days: 15)) {
      return '${duration.inDays} ngày trước';
    }
    String formattedDate = DateFormat('HH:mm dd/MM/yyyy').format(dt);

    return formattedDate;
  }

  static String priceFormat(double price) {
    final currencyFormatter = NumberFormat('#,###');
    var r = currencyFormatter.format(price);
    return r;
  }

  static String getName(String fullName) {
    List<String> h = fullName.split(" ");
    String name = h.last;

    return name;
  }

  static String getAddress(Property property) {
    String address = property.location!.address.toString() +
        ", " +
        property.location!.ward!.name.toString() +
        ", " +
        property.location!.ward!.district!.name.toString() +
        ", tp. Hồ Chí Minh";

    return address;
  }

  static String phoneFormat(String phone) {
    String formatter = phone.substring(0, 3) +
        " " +
        phone.substring(3, 6) +
        " " +
        phone.substring(6, phone.length);
    return formatter;
  }

  static String savePhone(var phone) {
    return phone.replaceAll(" ", "");
  }

  static String changePriceVN(var price) {
    // var numbers = price.replaceAll(" ", '').split('.');
    var numbers = ((double.parse(price)) / 1000000).toString().split('.');
    final chars = numbers[0];
    String newString = '';
    for (int i = chars.length - 1; i >= 0; i--) {
      if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1) {
        newString = " " + newString;
      }
      newString = chars[i] + newString;
    }

    if (!numbers[1].endsWith("0") && !numbers[1].endsWith("00")) {
      return newString + "," + numbers[1];
    }
    return newString;
  }

  static String changeMeterVN(var meter) {
    if (meter.endsWith(".0") || meter.endsWith(".00")) {
      return double.parse(meter.toString()).toInt().toString();
    }
    return meter.replaceAll(".", ",");
  }

  static String saveMeterVN(var meter) {
    // meter = meter.replaceAll(" ", "");
    if (meter.endsWith(",")) {
      meter = meter + "0";
    }
    return meter.replaceAll(",", ".");
  }

  static String savePrice(var price) {
    price = price.replaceAll(" ", "");
    if (price.endsWith(",")) {
      price = price + "0";
    }
    return price.replaceAll(",", ".");
  }

  static width(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return size;
  }

  static height(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return size;
  }

  static heightWithoutAppBar(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    var appBar = AppBar().preferredSize.height;
    size = size - appBar;
    return size;
  }

  static heightWithoutAppBarAndStatusbar(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    var appBar = AppBar().preferredSize.height;
    var height = MediaQuery.of(context).viewPadding.top;
    size = size - appBar - height;
    return size;
  }

  static heightWithoutStatusbar(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    var height = MediaQuery.of(context).viewPadding.top;
    size = size - height;
    return size;
  }

  static String nonUnicode(String text) {
    var arr1 = [
      "á",
      "à",
      "ả",
      "ã",
      "ạ",
      "â",
      "ấ",
      "ầ",
      "ẩ",
      "ẫ",
      "ậ",
      "ă",
      "ắ",
      "ằ",
      "ẳ",
      "ẵ",
      "ặ",
      "đ",
      "é",
      "è",
      "ẻ",
      "ẽ",
      "ẹ",
      "ê",
      "ế",
      "ề",
      "ể",
      "ễ",
      "ệ",
      "í",
      "ì",
      "ỉ",
      "ĩ",
      "ị",
      "ó",
      "ò",
      "ỏ",
      "õ",
      "ọ",
      "ô",
      "ố",
      "ồ",
      "ổ",
      "ỗ",
      "ộ",
      "ơ",
      "ớ",
      "ờ",
      "ở",
      "ỡ",
      "ợ",
      "ú",
      "ù",
      "ủ",
      "ũ",
      "ụ",
      "ư",
      "ứ",
      "ừ",
      "ử",
      "ữ",
      "ự",
      "ý",
      "ỳ",
      "ỷ",
      "ỹ",
      "ỵ"
    ];
    var arr2 = [
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "d",
      "e",
      "e",
      "e",
      "e",
      "e",
      "e",
      "e",
      "e",
      "e",
      "e",
      "e",
      "i",
      "i",
      "i",
      "i",
      "i",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "u",
      "u",
      "u",
      "u",
      "u",
      "u",
      "u",
      "u",
      "u",
      "u",
      "u",
      "y",
      "y",
      "y",
      "y",
      "y"
    ];
    for (int i = 0; i < arr1.length; i++) {
      text = text.replaceAll(arr1[i], arr2[i]);
      text = text.replaceAll(arr1[i].toUpperCase(), arr2[i]);
    }
    return text.toLowerCase();
  }
}
