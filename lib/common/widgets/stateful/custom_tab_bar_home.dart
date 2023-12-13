import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crel_mobile/common/widgets/stateless/tab_pft_home.dart';
import 'package:crel_mobile/common/widgets/stateless/tab_brand_home.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/modules/notification/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTabBarHome extends StatefulWidget {
  const CustomTabBarHome({Key? key}) : super(key: key);

  @override
  State<CustomTabBarHome> createState() => _CustomTabBarHomeState();
}

class _CustomTabBarHomeState extends State<CustomTabBarHome>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        id = value.getString("id");
      });
    });
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  String? id;

//  final prefs = await SharedPreferences.getInstance();
  // id = prefs.getString("id");
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(top: 8),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: Container(
        //           height: 40,
        //           alignment: Alignment.centerLeft,
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(10),
        //               border: Border.all(width: 1, color: AppColor.boderColor)),
        //           child: TextFormField(
        //             controller: controller,
        //             cursorColor: AppColor.secondColor,
        //             style: const TextStyle(color: AppColor.secondColor),
        //             decoration: const InputDecoration(
        //               isDense: true,
        //               border: InputBorder.none,
        //               hintText: 'ádasdas',
        //               hintStyle: TxtStyle.heading5Gray,
        //               prefixIcon: Icon(
        //                 Icons.search,
        //                 color: AppColor.textColor,
        //                 size: 24,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //       GestureDetector(
        //         onTap: () {
        //           BlocProvider.of<PropertyForRentBloc>(context)
        //               .add(SearchProperty(name: controller.text));
        //           BlocProvider.of<BrandBloc>(context)
        //               .add(SearchBrand(name: controller.text));
        //         },
        //         child: const Padding(
        //             padding: EdgeInsets.only(left: 8),
        //             child: Icon(
        //               Icons.filter_list_outlined,
        //               color: AppColor.textColor,
        //             )),
        //       ),
        //     ],
        //   ),
        // ),
        // const SearchBarBrand(title: 'ádaa'),

        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                width: AppFormat.width(context) * 0.65,
                height: AppFormat.heightWithoutStatusbar(context) * 0.06,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.boderColor, width: 1)),
                child: TabBar(
                    // onTap: (value) {
                    //   // .add(GetBrandByIdRequested(state1.appointments[0].brandId!));
                    //   switch (value) {
                    //     // Popular
                    //     case 0:
                    //       context.read<PropertyForRentBloc>().add(
                    //           const GetPropertyForRentRequested(2, "", true));
                    //       // BlocProvider.of<AppointmentBloc>(context)
                    //       //     .add(const GetAppointmentRequested(2, "", true));
                    //       break;

                    //     // Recent
                    //     case 1:
                    //       context
                    //           .read<BrandBloc>()
                    //           .add(const GetBrandRequested(true));
                    //       // context
                    //       //     .read<AppointmentConfirmBloc>()
                    //       //     .add(GetAppointmentConfirm());
                    //       // BlocProvider.of<AppointmentBloc>(context)
                    //       //     .add(const GetAppointmentRequested(1, "", true));
                    //       // BlocProvider.of<AppointmentConfirmBloc>(context)
                    //       //     .add(GetAppointmentConfirm());
                    //       break;
                    //   }
                    // },
                    controller: _tabController,
                    unselectedLabelColor: AppColor.secondColor,
                    indicatorColor: Colors.transparent,
                    labelColor: Colors.white,
                    indicator: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    tabs: const [
                      Tab(
                        child: Text(
                          "Mặt bằng",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Thương hiệu",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      )
                    ]),
              ),
              GestureDetector(
                onTap: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  final prefs = await SharedPreferences.getInstance();
                  String? id = prefs.getString("id");
                  Navigator.pushNamed(context, AppRouter.notificationPage,
                      arguments: id);
                },
                child: SizedBox(
                  child: StreamBuilder<List<Userrr>>(
                    stream: readUser(id ?? ""),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasData) {
                        final data = snapshot.data;
                        if (data!.isEmpty) {
                          return IconButton(
                            alignment: Alignment.centerRight,
                            onPressed: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              final prefs =
                                  await SharedPreferences.getInstance();
                              String? id = prefs.getString("id");
                              Navigator.pushNamed(
                                  context, AppRouter.notificationPage,
                                  arguments: id);
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) {
                              //   // do something
                              //   return const LoadingSpinner();
                              // }));
                            },
                            splashColor: Colors.transparent,
                            icon: const FaIcon(FontAwesomeIcons.bell,
                                color: AppColor.primaryColor),
                          );
                        }
                        return Badge(
                          toAnimate: false,
                          position: BadgePosition.topEnd(top: -12, end: -12),
                          badgeContent: Text(
                            data.length.toString(),
                            style: TxtStyle.heading5Blue.copyWith(fontSize: 10),
                          ),
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: AppColor.boderColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: FaIcon(FontAwesomeIcons.bell,
                                    size: 18, color: AppColor.primaryColor),
                              ),
                            ),
                          ),
                        );
                      }
                      return const Text("data");
                    },
                  ),
                ),
              )
            ],
          ),
        ),

        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              TabPFRHome(),
              TabBrandHome(),
            ],
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<String> getBrokerId() async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString("id");
    return id!;
  }

  Stream<List<Userrr>> readUser(String id) {
    // var id = getBrokerId();

    return FirebaseFirestore.instance
        .collection("Broker$id")
        .where('status', isEqualTo: 1)
        // .orderBy("SendDateTime", descending: true)
        // .where('status', isEqualTo: 6)
        // .where("lastChat", isNotEqualTo: "")
        // .limit(50)
        // .where('status', isEqualTo: 1)
        // .where("status")
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Userrr.fromJson(e.data())).toList());
  }

//  void readData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (prefs.getInt('currPage') == null)
//       setState(() => page = 0);
//     else
//       setState(() => page = prefs.getInt('currPage')!);
//   }

  // Future<String> getBrokerId() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? id = prefs.getString("id");
  //   return id!;
  // }
}
