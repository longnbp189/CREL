import 'package:crel_mobile/common/widgets/stateless/tab_pft_avaiable.dart';
import 'package:crel_mobile/common/widgets/stateless/tab_pft_rented.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
import 'package:crel_mobile/modules/home/repos/property_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PropertyStatus {
  final String name;
  final int? status;
  PropertyStatus({required this.name, required this.status});
}

List<PropertyStatus> propertyStatus = [
  PropertyStatus(name: "Đang hoạt động", status: 2),
  PropertyStatus(name: "Đã cho thuê", status: 3),
  // PropertyStatus(name: "Quá hạn thuê", status: 4),
  // PropertyStatus(name: "Chờ xử lý", status: 4),
  // PropertyStatus(name: "Bị từ chối", status: null),
];

class CustomTabBarManagerProperty extends StatefulWidget {
  const CustomTabBarManagerProperty({Key? key}) : super(key: key);

  @override
  State<CustomTabBarManagerProperty> createState() =>
      _CustomTabBarManagerPropertyState();
}

class _CustomTabBarManagerPropertyState
    extends State<CustomTabBarManagerProperty>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  // late PropertyForRentBloc _propertyForRentBloc;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    // _propertyForRentBloc = context.read<PropertyForRentBloc>()
    //   ..add(const GetPropertyForRentRequested(2, "", true));
    // _scrollController.addListener(_onScroll);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // _propertyForRentBloc.dispose();
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  // int current = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.backgroundColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 8, top: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  width: AppFormat.width(context) * 0.8,
                  height: AppFormat.heightWithoutStatusbar(context) * 0.06,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.boderColor, width: 1)),
                  child: TabBar(
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
                            "Đang hoạt động",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Đã cho thuê",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        )
                      ]),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                BlocProvider<PropertyForRentBloc>(
                  create: (context) => PropertyForRentBloc(
                      propertyForRentRepo:
                          RepositoryProvider.of<PropertyRepo>(context)),
                  child: const TabPFRAvaiable(),
                ),
                const TabPFRRented(),
              ],
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          //   child: SizedBox(
          //     width: double.infinity,
          //     height: 45,
          //     child: ListView.builder(
          //         physics: const BouncingScrollPhysics(),
          //         itemCount: propertyStatus.length,
          //         scrollDirection: Axis.horizontal,
          //         itemBuilder: (ctx, index) {
          //           return Column(
          //             children: [
          //               BlocProvider<PropertyForRentBloc>(
          //                 create: (context) => PropertyForRentBloc(
          //                     propertyForRentRepo:
          //                         RepositoryProvider.of<PropertyRepo>(context)),
          //                 child: GestureDetector(
          //                   onTap: () {
          //                     setState(() {
          //                       current = index;
          //                       _propertyForRentBloc.add(
          //                           GetPropertyForRentRequested(
          //                               propertyStatus[index].status, "", true));
          //                     });
          //                   },
          //                   child: AnimatedContainer(
          //                     duration: const Duration(milliseconds: 300),
          //                     margin: const EdgeInsets.all(2),
          //                     width: 120,
          //                     height: 35,
          //                     decoration: BoxDecoration(
          //                       color: current == index
          //                           ? AppColor.primaryColor
          //                           : Colors.transparent,
          //                       borderRadius: current == index
          //                           ? BorderRadius.circular(15)
          //                           : BorderRadius.circular(10),
          //                       // border: current == index
          //                       //     ? Border.all(
          //                       //         color: Colors.deepPurpleAccent, width: 2)
          //                       //     : null,
          //                     ),
          //                     child: Center(
          //                       child: Text(
          //                         propertyStatus[index].name,
          //                         style: TxtStyle.heading4.copyWith(
          //                             fontWeight: FontWeight.w500,
          //                             color: current == index
          //                                 ? Colors.white
          //                                 : Colors.grey),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           );
          //         }),
          //   ),
          // ),

          // BlocListener<PropertyForRentBloc, PropertyForRentState>(
          //   listener: (context, state) {
          //     if (state is PropertyForRentError) {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //           const SnackBar(content: Text("PropertyForRentError")));
          //     }
          //   },
          //   child: BlocBuilder<PropertyForRentBloc, PropertyForRentState>(
          //       builder: (context, state) {
          //     if (state is PropertyForRentLoading) {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //     if (state is PropertyForRentLoaded) {
          //       if (state.propertyForRents.isEmpty) {
          //         return Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             SvgPicture.asset(
          //               'assets/images/empty.svg',
          //               height: 300,
          //             ),
          //             const Text(
          //               "Danh sách trống",
          //               style: TxtStyle.heading2,
          //             ),
          //           ],
          //         );
          //       }
          //       return PropertyForRentList(
          //         onRefresh: _onRefresh,
          //         scrollController: _scrollController,
          //         state: state,
          //       );
          //     } else {
          //       return Text("$state");
          //     }
          //   }),
          // ),
          // _itemTabBarHome[current]
        ],
      ),
    );
  }

  // final List<BlocListener> _itemTabBarHome = [
  //   BlocListener<PropertyForRentBloc, PropertyForRentState>(
  //     listener: (context, state) {
  //       if (state is PropertyForRentError) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(content: Text("PropertyForRentError")));
  //       }
  //     },
  //     child: BlocBuilder<PropertyForRentBloc, PropertyForRentState>(
  //         builder: (context, state) {
  //       if (state is PropertyForRentLoading) {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //       if (state is PropertyForRentLoaded) {
  //         return PropertyForRentList(
  //           onRefresh: _onRefresh,
  //           scrollController: _scrollController,
  //           state: state,
  //         );
  //       } else {
  //         return Text("$state");
  //       }
  //     }),
  //   ),
  //   BlocListener<PropertyForRentBloc, PropertyForRentState>(
  //     listener: (context, state) {
  //       if (state is PropertyForRentError) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(content: Text("PropertyForRentError")));
  //       }
  //     },
  //     child: BlocBuilder<PropertyForRentBloc, PropertyForRentState>(
  //         builder: (context, state) {
  //       if (state is PropertyForRentLoading) {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //       if (state is PropertyForRentLoaded) {
  //         return PropertyForRentList(
  //           propertyForRents: state.propertyForRents
  //               .where((element) => element.status == 2)
  //               .toList(),
  //         );
  //       } else {
  //         return Text("$state");
  //       }
  //     }),
  //   ),
  //   BlocListener<PropertyForRentBloc, PropertyForRentState>(
  //     listener: (context, state) {
  //       if (state is PropertyForRentError) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(content: Text("PropertyForRentError")));
  //       }
  //     },
  //     child: BlocBuilder<PropertyForRentBloc, PropertyForRentState>(
  //         builder: (context, state) {
  //       if (state is PropertyForRentLoading) {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //       if (state is PropertyForRentLoaded) {
  //         return PropertyForRentList(
  //           propertyForRents: state.propertyForRents
  //               .where((element) => element.status == 4)
  //               .toList(),
  //         );
  //       } else {
  //         return Text("$state");
  //       }
  //     }),
  //   ),
  //   BlocListener<PropertyForRentBloc, PropertyForRentState>(
  //     listener: (context, state) {
  //       if (state is PropertyForRentError) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(content: Text("PropertyForRentError")));
  //       }
  //     },
  //     child: BlocBuilder<PropertyForRentBloc, PropertyForRentState>(
  //         builder: (context, state) {
  //       if (state is PropertyForRentLoading) {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //       if (state is PropertyForRentLoaded) {
  //         return PropertyForRentList(
  //           propertyForRents: state.propertyForRents
  //               .where((element) => element.status == 5)
  //               .toList(),
  //         );
  //       } else {
  //         return Text("$state");
  //       }
  //     }),
  //   ),
  // ];

  // Future<void> _onRefresh() async {
  //   _propertyForRentBloc.add(
  //       RefreshPropertyForRentRequested(propertyStatus[current].status, ""));
  // }

  // void _onScroll() {
  //   print('tab1');

  //   double maxScroll = _scrollController.position.maxScrollExtent;
  //   double currentScroll = _scrollController.position.pixels;
  //   if (currentScroll == maxScroll) {
  //     // ignore: avoid_single_cascade_in_expression_statements
  //     _propertyForRentBloc
  //       ..add(GetPropertyForRentRequested(
  //           propertyStatus[current].status, "", false));
  //   }
  // }
}




// import 'package:crel_mobile/config/app_format.dart';
// import 'package:crel_mobile/config/configs.dart';
// import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
// import 'package:crel_mobile/modules/home/widgets/property_for_rent_list.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// // class PropertyStatus {
// //   final String name;
// //   final int? status;
// //   PropertyStatus({required this.name, required this.status});
// // }

// // List<PropertyStatus> propertyStatus = [
// //   PropertyStatus(name: "Đang hoạt động", status: 2),
// //   PropertyStatus(name: "Đã cho thuê", status: 3),
// //   // PropertyStatus(name: "Quá hạn thuê", status: 4),
// //   // PropertyStatus(name: "Chờ xử lý", status: 4),
// //   // PropertyStatus(name: "Bị từ chối", status: null),
// // ];

// class CustomTabBarManagerProperty extends StatefulWidget {
//   const CustomTabBarManagerProperty({Key? key}) : super(key: key);

//   @override
//   State<CustomTabBarManagerProperty> createState() =>
//       _CustomTabBarManagerPropertyState();
// }

// class _CustomTabBarManagerPropertyState
//     extends State<CustomTabBarManagerProperty>
//     with SingleTickerProviderStateMixin {
//   final ScrollController _scrollController = ScrollController();
//   late PropertyForRentBloc _propertyForRentBloc;
//   late TabController _tabController;
//   @override
//   void initState() {
//     super.initState();
//     _propertyForRentBloc = context.read<PropertyForRentBloc>()
//       ..add(const GetPropertyForRentRequested(2, "", true));
//     _scrollController.addListener(_onScroll);
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     // _propertyForRentBloc.dispose();
//     _scrollController.dispose();
//     _tabController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 16, right: 8),
//           child: Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(5),
//                 width: AppFormat.width(context) * 0.65,
//                 height: AppFormat.heightWithoutStatusbar(context) * 0.06,
//                 decoration: BoxDecoration(
//                     // color: AppColor.primaryColor,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: AppColor.boderColor, width: 2)),
//                 child: TabBar(
//                     controller: _tabController,
//                     unselectedLabelColor: AppColor.secondColor,
//                     indicatorColor: Colors.transparent,
//                     labelColor: Colors.white,
//                     indicator: BoxDecoration(
//                         color: AppColor.primaryColor,
//                         borderRadius: BorderRadius.circular(10)),
//                     tabs: const [
//                       Tab(
//                         child: Text(
//                           "Đang hoạt động",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 14),
//                         ),
//                       ),
//                       Tab(
//                         child: Text(
//                           "Đã có chủ",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 14),
//                         ),
//                       )
//                     ]),
//               ),
              
//             ],
//           ),
//         ),
//         Expanded(
//           child: TabBarView(
//             controller: _tabController,
//             children: const [
//               TabPFRHome(),
//               TabBrandHome(),
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
//           child: SizedBox(
//             width: double.infinity,
//             height: 45,
//             child: ListView.builder(
//                 physics: const BouncingScrollPhysics(),
//                 itemCount: propertyStatus.length,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (ctx, index) {
//                   return Column(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             current = index;
//                             _propertyForRentBloc.add(
//                                 GetPropertyForRentRequested(
//                                     propertyStatus[index].status, "", true));
//                           });
//                         },
//                         child: AnimatedContainer(
//                           duration: const Duration(milliseconds: 300),
//                           margin: const EdgeInsets.all(2),
//                           width: 120,
//                           height: 35,
//                           decoration: BoxDecoration(
//                             color: current == index
//                                 ? AppColor.primaryColor
//                                 : Colors.transparent,
//                             borderRadius: current == index
//                                 ? BorderRadius.circular(15)
//                                 : BorderRadius.circular(10),
//                             // border: current == index
//                             //     ? Border.all(
//                             //         color: Colors.deepPurpleAccent, width: 2)
//                             //     : null,
//                           ),
//                           child: Center(
//                             child: Text(
//                               propertyStatus[index].name,
//                               style: TxtStyle.heading4.copyWith(
//                                   fontWeight: FontWeight.w500,
//                                   color: current == index
//                                       ? Colors.white
//                                       : Colors.grey),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 }),
//           ),
//         ),

//         BlocListener<PropertyForRentBloc, PropertyForRentState>(
//           listener: (context, state) {
//             if (state is PropertyForRentError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text("PropertyForRentError")));
//             }
//           },
//           child: BlocBuilder<PropertyForRentBloc, PropertyForRentState>(
//               builder: (context, state) {
//             if (state is PropertyForRentLoading) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             if (state is PropertyForRentLoaded) {
//               if (state.propertyForRents.isEmpty) {
//                 return Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SvgPicture.asset(
//                       'assets/images/empty.svg',
//                       height: 300,
//                     ),
//                     const Text(
//                       "Danh sách trống",
//                       style: TxtStyle.heading2,
//                     ),
//                   ],
//                 );
//               }
//               return PropertyForRentList(
//                 onRefresh: _onRefresh,
//                 scrollController: _scrollController,
//                 state: state,
//               );
//             } else {
//               return Text("$state");
//             }
//           }),
//         ),
//         // _itemTabBarHome[current]
//       ],
//     );
//   }

//   // final List<BlocListener> _itemTabBarHome = [
//   //   BlocListener<PropertyForRentBloc, PropertyForRentState>(
//   //     listener: (context, state) {
//   //       if (state is PropertyForRentError) {
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //             const SnackBar(content: Text("PropertyForRentError")));
//   //       }
//   //     },
//   //     child: BlocBuilder<PropertyForRentBloc, PropertyForRentState>(
//   //         builder: (context, state) {
//   //       if (state is PropertyForRentLoading) {
//   //         return const Center(
//   //           child: CircularProgressIndicator(),
//   //         );
//   //       }
//   //       if (state is PropertyForRentLoaded) {
//   //         return PropertyForRentList(
//   //           onRefresh: _onRefresh,
//   //           scrollController: _scrollController,
//   //           state: state,
//   //         );
//   //       } else {
//   //         return Text("$state");
//   //       }
//   //     }),
//   //   ),
//   //   BlocListener<PropertyForRentBloc, PropertyForRentState>(
//   //     listener: (context, state) {
//   //       if (state is PropertyForRentError) {
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //             const SnackBar(content: Text("PropertyForRentError")));
//   //       }
//   //     },
//   //     child: BlocBuilder<PropertyForRentBloc, PropertyForRentState>(
//   //         builder: (context, state) {
//   //       if (state is PropertyForRentLoading) {
//   //         return const Center(
//   //           child: CircularProgressIndicator(),
//   //         );
//   //       }
//   //       if (state is PropertyForRentLoaded) {
//   //         return PropertyForRentList(
//   //           propertyForRents: state.propertyForRents
//   //               .where((element) => element.status == 2)
//   //               .toList(),
//   //         );
//   //       } else {
//   //         return Text("$state");
//   //       }
//   //     }),
//   //   ),
//   //   BlocListener<PropertyForRentBloc, PropertyForRentState>(
//   //     listener: (context, state) {
//   //       if (state is PropertyForRentError) {
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //             const SnackBar(content: Text("PropertyForRentError")));
//   //       }
//   //     },
//   //     child: BlocBuilder<PropertyForRentBloc, PropertyForRentState>(
//   //         builder: (context, state) {
//   //       if (state is PropertyForRentLoading) {
//   //         return const Center(
//   //           child: CircularProgressIndicator(),
//   //         );
//   //       }
//   //       if (state is PropertyForRentLoaded) {
//   //         return PropertyForRentList(
//   //           propertyForRents: state.propertyForRents
//   //               .where((element) => element.status == 4)
//   //               .toList(),
//   //         );
//   //       } else {
//   //         return Text("$state");
//   //       }
//   //     }),
//   //   ),
//   //   BlocListener<PropertyForRentBloc, PropertyForRentState>(
//   //     listener: (context, state) {
//   //       if (state is PropertyForRentError) {
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //             const SnackBar(content: Text("PropertyForRentError")));
//   //       }
//   //     },
//   //     child: BlocBuilder<PropertyForRentBloc, PropertyForRentState>(
//   //         builder: (context, state) {
//   //       if (state is PropertyForRentLoading) {
//   //         return const Center(
//   //           child: CircularProgressIndicator(),
//   //         );
//   //       }
//   //       if (state is PropertyForRentLoaded) {
//   //         return PropertyForRentList(
//   //           propertyForRents: state.propertyForRents
//   //               .where((element) => element.status == 5)
//   //               .toList(),
//   //         );
//   //       } else {
//   //         return Text("$state");
//   //       }
//   //     }),
//   //   ),
//   // ];

//   Future<void> _onRefresh() async {
//     _propertyForRentBloc.add(
//         RefreshPropertyForRentRequested(propertyStatus[current].status, ""));
//   }

//   void _onScroll() {
//     print('tab1');

//     double maxScroll = _scrollController.position.maxScrollExtent;
//     double currentScroll = _scrollController.position.pixels;
//     if (currentScroll == maxScroll) {
//       // ignore: avoid_single_cascade_in_expression_statements
//       _propertyForRentBloc
//         ..add(GetPropertyForRentRequested(
//             propertyStatus[current].status, "", false));
//     }
//   }
// }
