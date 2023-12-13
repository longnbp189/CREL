// import 'package:crel_mobile/common/widgets/stateful/chose_brand.dart';
// import 'package:crel_mobile/common/widgets/stateful/chose_district.dart';
// import 'package:crel_mobile/common/widgets/stateful/chose_month.dart';
// import 'package:crel_mobile/common/widgets/stateful/chose_project.dart';
// import 'package:crel_mobile/common/widgets/stateful/chose_ward.dart';
// import 'package:crel_mobile/config/configs.dart';
// import 'package:crel_mobile/models/brand.dart';
// import 'package:crel_mobile/models/district.dart';
// import 'package:crel_mobile/models/project.dart';
// import 'package:crel_mobile/models/ward.dart';
// import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
// import 'package:crel_mobile/modules/mission/blocs/ward/ward_bloc.dart';
// import 'package:crel_mobile/modules/mission/repos/ward_repo.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class Filter extends StatefulWidget {
//   const Filter({Key? key}) : super(key: key);

//   @override
//   State<Filter> createState() => _FilterState();
// }

// class _FilterState extends State<Filter> {
//   Brand returnBrand = Brand();
//   callbackBrand(returnData) {
//     setState(() {
//       returnBrand = returnData;
//     });
//   }

//   Project returnProject = Project();
//   callbackProject(returnData) {
//     setState(() {
//       returnProject = returnData;
//     });
//   }

//   District returnDistrict = District();
//   callbackDistrict(returnData) {
//     setState(() {
//       returnDistrict = returnData;
//     });
//   }

//   Ward returnWard = Ward();
//   callbackWard(returnData) {
//     setState(() {
//       returnWard = returnData;
//     });
//   }

//   DateTime? returnMonth;
//   callbackDate(returnData) {
//     setState(() {
//       returnMonth = returnData;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             ChoseBrand(
//               callback: callbackBrand,
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             ChoseProject(
//               callback: callbackProject,
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             ChoseDistrict(
//               callback: callbackDistrict,
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             BlocProvider<WardBloc>(
//               create: (context) => WardBloc(
//                 wardRepo: RepositoryProvider.of<WardRepo>(context),
//               ),
//               child: ChoseWard(
//                 callback: callbackWard,
//               ),
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             ChoseMonth(callback: callbackDate),
//             const SizedBox(
//               height: 8,
//             ),
//             Padding(
//                 padding: const EdgeInsets.only(top: 8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       flex: 5,
//                       child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           style: ButtonStyle(
//                               foregroundColor: MaterialStateProperty.all<Color>(
//                                   Colors.white),
//                               backgroundColor: MaterialStateProperty.all<Color>(
//                                   AppColor.primaryColor),
//                               shape: MaterialStateProperty.all(
//                                   RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ))),
//                           child: Text('Hủy',
//                               style: TxtStyle.heading4
//                                   .copyWith(color: Colors.white))),
//                     ),
//                     const Expanded(child: SizedBox()),
//                     Expanded(
//                       flex: 5,
//                       child: ElevatedButton(
//                           onPressed: () {
//                             BlocProvider.of<PropertyForRentBloc>(context).add(
//                                 const SearchProperty(name: "name", status: 1));
//                             // Navigator.of(context).pushAndRemoveUntil(
//                             //   MaterialPageRoute(
//                             //       builder: (context) => const CustomNavBar()),
//                             //   (route) => false,
//                             // );
//                           },
//                           style: ButtonStyle(
//                               foregroundColor: MaterialStateProperty.all<Color>(
//                                   Colors.white),
//                               backgroundColor: MaterialStateProperty.all<Color>(
//                                   AppColor.primaryColor),
//                               shape: MaterialStateProperty.all(
//                                   RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ))),
//                           child: Text('Xác nhận',
//                               style: TxtStyle.heading4
//                                   .copyWith(color: Colors.white))),
//                     )
//                   ],
//                 ))
//           ],
//         ),
//       ),
//     ));
//   }
// }

import 'package:crel_mobile/config/app_format.dart';
import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<Distance> distance = [
    Distance(10.841705315866355, 106.8377540833799), //2
    Distance(11.07391184889043, 107.0881370203988), //3
    Distance(10.738608224116575, 106.71027928474346), //1
  ];
  // var a;

  // @override
  // void initState() {
  //   super.initState();
  //   a = AppFormat.caculatorDistance();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
            // children: [Text(AppFormat.caculatorDistance(distance).toString())],
            ),
      ),
    ));
  }
}
