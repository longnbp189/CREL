import 'dart:isolate';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/modules/appointment/blocs/appointment_confirm/appointment_confirm_bloc.dart';
import 'package:crel_mobile/modules/appointment/pages/appointment_page.dart';
import 'package:crel_mobile/modules/authentication/blocs/authentication_bloc.dart';
import 'package:crel_mobile/modules/home/pages/home_page.dart';
import 'package:crel_mobile/modules/mission/pages/mission_page.dart';
import 'package:crel_mobile/modules/notification/pages/notification_page.dart';
import 'package:crel_mobile/modules/profile/blocs/profile/profile_bloc.dart';
import 'package:crel_mobile/modules/profile/pages/profile_page.dart';
import 'package:crel_mobile/modules/property_management/pages/property_management_page.dart';
import 'package:crel_mobile/modules/unauthentication/pages/welcome_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';

class CustomNavBar extends StatefulWidget {
  // final Widget a;
  final int? index;
  const CustomNavBar({Key? key, this.index}) : super(key: key);
  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int currentTab = 0;

  final PageStorageBucket bucket = PageStorageBucket();
  // Widget currentScreen = const HomePage();

  List<Widget> currentScreens = [
    const HomePage(),
    const PropertyManagementPage(),
    const MissionPage(),
    const AppointmentPage(),
    const ProfilePage()
  ];

  final ReceivePort _port = ReceivePort();

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      if (status == DownloadTaskStatus.complete) {
        print("Download Complete");
      }
      setState(() {});
    });
    FlutterDownloader.registerCallback(downloadCallback);

    if (widget.index != null) {
      currentTab = widget.index!;
    }
    // context.read<ProfileBloc>().add(GetProfileRequested());
    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        print("terminated");
        if (message != null) {
          print("New Notification");
          print("1");

          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }

          // LocalNotification.createanddisplaynotification(message);
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        print("forground");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          print("message.data11 ${message.notification}");
          print("2");

          // final user = Userrr(
          //   title: message.notification!.title!.toString(),
          //   body: message.notification!.body!,
          //   type: message.data['Type'] != ""
          //       ? int.parse(message.data['Type'])
          //       : 0,
          //   onDatetime: Timestamp.fromDate(DateTime.now()),
          //   brandId: message.data['BrandId'] != ""
          //       ? int.parse(message.data['BrandId'])
          //       : 0,
          //   brokerId: message.data['BrokerId'] != ""
          //       ? int.parse(message.data['BrokerId'])
          //       : 0,
          //   propertyId: message.data['PropertyId'] != ""
          //       ? int.parse(message.data['PropertyId'])
          //       : 0,
          //   appointmentId: message.data['AppointmentId'] != ""
          //       ? int.parse(message.data['AppointmentId'])
          //       : 0,
          //   contractId: message.data['ContractId'] != ""
          //       ? int.parse(message.data['ContractId'])
          //       : 0,
          //   teamId: message.data['TeamId'] != ""
          //       ? int.parse(message.data['TeamId'])
          //       : 0,
          // );
          // print(user);
          // createUser(user: user);
          LocalNotification.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        print("background");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['Type']}");
          print("3");
          // final json = message.data.toJson();

          Userrr userrr = Userrr(
              type: message.data["Type"] != ""
                  ? int.parse(message.data['Type'])
                  : null,
              brokerId: message.data["BrokerId"] != ""
                  ? int.parse(message.data['BrokerId'])
                  : null,
              appointmentId: message.data["AppointmentId"] != ""
                  ? int.parse(message.data['AppointmentId'])
                  : null,
              contractId: message.data["ContractId"] != ""
                  ? int.parse(message.data['ContractId'])
                  : null,
              teamId: message.data["TeamId"] != ""
                  ? int.parse(message.data['TeamId'])
                  : null,
              brandId: message.data["BrandId"] != ""
                  ? int.parse(message.data['BrandId'])
                  : null,
              propertyId: message.data["PropertyId"] != ""
                  ? int.parse(message.data['PropertyId'])
                  : null,
              // status: message.data["status"] != ""
              //     ? int.parse(message.data['status'])
              //     : null,
              body: message.notification!.body.toString(),
              title: message.notification!.title.toString(),
              sendDateTime: message.data["OnDateTime"]);
          navigatorNotification(userrr, context);

          // final user = Userrr(
          //   title: message.notification!.title!.toString(),
          //   body: message.notification!.body!,
          //   type: message.data['Type'] != ""
          //       ? int.parse(message.data['Type'])
          //       : 0,
          //   sendDateTime: Timestamp.fromDate(DateTime.now()),
          //   brandId: message.data['BrandId'] != ""
          //       ? int.parse(message.data['BrandId'])
          //       : 0,
          //   brokerId: message.data['BrokerId'] != ""
          //       ? int.parse(message.data['BrokerId'])
          //       : 0,
          //   propertyId: message.data['PropertyId'] != ""
          //       ? int.parse(message.data['PropertyId'])
          //       : 0,
          //   appointmentId: message.data['AppointmentId'] != ""
          //       ? int.parse(message.data['AppointmentId'])
          //       : 0,
          //   contractId: message.data['ContractId'] != ""
          //       ? int.parse(message.data['ContractId'])
          //       : 0,
          //   teamId: message.data['TeamId'] != ""
          //       ? int.parse(message.data['TeamId'])
          //       : 0,
          //   // title: message.notification!.title!.toString(),
          //   // description: message.notification!.body!,
          //   // type: int.parse(message.data['Type']),
          //   // onDatetime: Timestamp.fromDate(DateTime.now()),
          //   // brandId: int.parse(message.data['BrandId']),
          //   // brokerId: int.parse(message.data['BrokerId']),
          //   // propertyId: int.parse(message.data['PropertyId']),
          // );
          // createUser(user: user);
          // LocalNotification.showNotification(message);
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => NotificationPage(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');

    super.dispose();
  }

  Future createUser({required Userrr user}) async {
    final noti = FirebaseFirestore.instance
        .collection("notification")
        .doc(AppFormat.parseDateAndTime(DateTime.now().toString()));

    // final json = {
    //   'description': des,
    //   "refId": 2,
    //   "title": "hi",
    //   "status": 2,
    //   "type": 2
    // };

    final json = user.toJson();

    await noti.set(json);
  }

// Future<void> updateUser() {
//   return users
//     .doc('ABC123')
//     .update({'info.address.zipcode': 90210})
//     .then((value) => print("User Updated"))
//     .catchError((error) => print("Failed to update user: $error"));
// }

  // Future updateUser({required Userrr user}) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? id = prefs.getString("id");
  //   CollectionReference users =
  //       FirebaseFirestore.instance.collection("Broker$id");

  //   final noti = users.doc().update("status" : 2);

  //   // final json = {
  //   //   'description': des,
  //   //   "refId": 2,
  //   //   "title": "hi",
  //   //   "status": 2,
  //   //   "type": 2
  //   // };

  //   final json = user.toJson();

  //   await noti.update(json);
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Bạn có muốn thoát khỏi ứng dụng?',
                style: TxtStyle.heading3,
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text('Không'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text('Có'),
                    ),
                  ],
                )
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        body: SafeArea(
          child: PageStorage(
            bucket: bucket,
            child: currentScreens[currentTab],
          ),
        ),
        bottomNavigationBar:
            BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is UnAuthenticated || state is AuthenticatedError) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const WelcomePage()),
                (route) => false,
              );
            }
          },
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            // notchMargin: 10,
            child: SizedBox(
              height: size.height / 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      context
                          .read<AppointmentConfirmBloc>()
                          .add(GetAppointmentConfirm());
                      setState(() {
                        currentTab = 0;
                        currentScreens[currentTab];
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(
                        //   Iconsax.home,
                        //   color: currentTab == 0
                        //       ? AppColor.primaryColor
                        //       : AppColor.textColor,
                        // ),
                        SvgPicture.asset(
                          'assets/icons/home-2.svg',
                          color: currentTab == 0
                              ? AppColor.primaryColor
                              : AppColor.textColor,
                          height: currentTab == 0 ? 30 : 24,
                        ),
                        // FaIcon(
                        //   FontAwesomeIcons.house,
                        //   color: currentTab == 0
                        //       ? AppColor.primaryColor
                        //       : AppColor.textColor,
                        // ),
                        // Icon(
                        //   Icons.home_outlined,
                        //   color: currentTab == 0
                        //       ? AppColor.primaryColor
                        //       : AppColor.textColor,
                        // )
                        // ,
                        const SizedBox(
                          height: 4,
                        ),
                        Text('Trang chủ',
                            style: currentTab == 0
                                ? const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: AppColor.primaryColor)
                                : const TextStyle(
                                    fontSize: 14, color: AppColor.textColor)),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context
                          .read<AppointmentConfirmBloc>()
                          .add(GetAppointmentConfirm());
                      setState(() {
                        currentTab = 1;

                        currentScreens[currentTab];
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/building.svg',
                          color: currentTab == 1
                              ? AppColor.primaryColor
                              : AppColor.textColor,
                          height: currentTab == 1 ? 30 : 24,
                        ),
                        // FaIcon(
                        //   FontAwesomeIcons.building,
                        //   color: currentTab == 1
                        //       ? AppColor.primaryColor
                        //       : AppColor.textColor,
                        // ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Mặt bằng',
                          style: currentTab == 1
                              ? const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: AppColor.primaryColor)
                              : const TextStyle(
                                  fontSize: 14, color: AppColor.textColor),
                        ),
                      ],
                    ),
                  ),
                  // const Expanded(flex: 2, child: SizedBox()),
                  InkWell(
                    onTap: () {
                      context
                          .read<AppointmentConfirmBloc>()
                          .add(GetAppointmentConfirm());
                      setState(() {
                        currentTab = 2;

                        currentScreens[currentTab];
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/mission.svg',
                          color: currentTab == 2
                              ? AppColor.primaryColor
                              : AppColor.textColor,
                          height: currentTab == 2 ? 30 : 24,
                        ),
                        // FaIcon(
                        //   FontAwesomeIcons.briefcase,
                        //   color: currentTab == 2
                        //       ? AppColor.primaryColor
                        //       : AppColor.textColor,
                        // ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Nhiệm vụ',
                          style: currentTab == 2
                              ? const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: AppColor.primaryColor)
                              : const TextStyle(
                                  fontSize: 14, color: AppColor.textColor),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context
                          .read<AppointmentConfirmBloc>()
                          .add(GetAppointmentConfirm());
                      setState(() {
                        currentTab = 3;

                        currentScreens[currentTab];
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder<AppointmentConfirmBloc,
                            AppointmentConfirmState>(
                          buildWhen: (previous, current) =>
                              previous != current &&
                              current is AppointmentComfirmLoaded,
                          builder: (context, state) {
                            // BlocProvider.of<AppointmentBloc>(context)
                            //     .add(const GetAppointmentRequested(1, "", true));

                            if (state is AppointmentComfirmLoaded) {
                              if (state.number != 0) {
                                return Badge(
                                  toAnimate: false,
                                  position:
                                      BadgePosition.topEnd(top: -4, end: -12),
                                  child: SvgPicture.asset(
                                    'assets/icons/calendar.svg',
                                    color: currentTab == 3
                                        ? AppColor.primaryColor
                                        : AppColor.textColor,
                                    height: currentTab == 3 ? 30 : 24,
                                  ),
                                  // FaIcon(
                                  //   FontAwesomeIcons.calendarDay,
                                  //   color: currentTab == 3
                                  //       ? AppColor.primaryColor
                                  //       : AppColor.textColor,
                                  // ),
                                );
                              }
                            }
                            return SvgPicture.asset(
                              'assets/icons/calendar.svg',
                              color: currentTab == 3
                                  ? AppColor.primaryColor
                                  : AppColor.textColor,
                              height: currentTab == 3 ? 30 : 24,
                            );

                            //  FaIcon(
                            //   FontAwesomeIcons.calendarDay,
                            //   color: currentTab == 3
                            //       ? AppColor.primaryColor
                            //       : AppColor.textColor,
                            // );
                          },
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Lịch hẹn',
                          style: currentTab == 3
                              ? const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: AppColor.primaryColor)
                              : const TextStyle(
                                  fontSize: 14, color: AppColor.textColor),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context
                          .read<AppointmentConfirmBloc>()
                          .add(GetAppointmentConfirm());
                      context.read<ProfileBloc>().add(GetProfileRequested());
                      setState(() {
                        currentTab = 4;

                        currentScreens[currentTab];
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/user.svg',
                          color: currentTab == 4
                              ? AppColor.primaryColor
                              : AppColor.textColor,
                          height: currentTab == 4 ? 30 : 24,
                        ),
                        // FaIcon(
                        //   FontAwesomeIcons.user,
                        //   color: currentTab == 4
                        //       ? AppColor.primaryColor
                        //       : AppColor.textColor,
                        // ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Cá nhân',
                          style: currentTab == 4
                              ? const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: AppColor.primaryColor)
                              : const TextStyle(
                                  fontSize: 14, color: AppColor.textColor),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
