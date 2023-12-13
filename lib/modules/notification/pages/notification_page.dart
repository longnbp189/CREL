import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/modules/appointment/blocs/contract/contract_bloc.dart';
import 'package:crel_mobile/modules/appointment/repos/contract_repo.dart';
import 'package:crel_mobile/modules/home/blocs/brand/brand_bloc.dart';
import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Stream<List<Userrr>> readUser() {
    return FirebaseFirestore.instance
        .collection("Broker${widget.id}")
        .orderBy("SendDateTime", descending: true)
        .limit(30)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Userrr.fromJson(e.data())).toList());
  }

  List<String> docIds = [];

  // CollectionReference writeUser =
  //     FirebaseFirestore.instance.collection("notification");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thông báo",
          style: TxtStyle.textAppBar,
        ),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: AppColor.backgroundColor,
          child: StreamBuilder<List<Userrr>>(
            stream: readUser(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                final data = snapshot.data;

                if (data!.isEmpty) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Center(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/empty.svg',
                            height: 250,
                          ),
                          const Text(
                            "Danh sách trống",
                            style: TxtStyle.heading2,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: GestureDetector(
                          onTap: () async {
                            if (data[index].status == 1) {
                              // var user = FirebaseFirestore.instance
                              //     .collection("Broker1")
                              //     .doc(docIds[index]);

                              // user.update({"status": 0});
                              await updateStatusNoti(
                                  data[index].status!.toInt(), index);
                            }
                            // // user.doc(user.id).update({'status': 0});
                            // .orderBy("SendDateTime", descending: true)
                            // .limit(30).get().then((value) => snapshot.)
                            // .snapshots();
                            // .map((event) => event.docs
                            //     .map((e) => Userrr.fromJson(e.data()))
                            //     .toList());
                            // print(user);
                            // print(user.id);

                            // var user = FirebaseFirestore.instance
                            //     .collection("Broker1")
                            //     .orderBy("SendDateTime", descending: true)
                            //     .limit(30)
                            //     .snapshots()
                            //     .map((event) => event.docs
                            //         .map((e) => Userrr.fromJson(e.data()))
                            //         .toList());
                            // print(user);

                            // querySnapshots.docs[0].id
                            // String? documentID;
                            // for (var snapshot in querySnapshots.docs) {
                            //   documentID = snapshot.id; // <-- Document ID
                            // }

                            // print(documentID);
                            // print("object");

                            // user.doc(user.id).update({'status': 0});

                            // switch (data[index].type) {
                            //   case 10:
                            //     context.read<BrandBloc>().add(
                            //         GetBrandByIdRequested(
                            //             data[index].brandId!.toInt()));
                            //     Navigator.pushNamedAndRemoveUntil(context,
                            //         AppRouter.brandDetail, (route) => false,
                            //         arguments: 1);
                            //     // Navigator.pushNamed(
                            //     // context, AppRouter.brandDetail,
                            //     // arguments: 1);
                            //     break;
                            //   // return;
                            //   case 2:
                            //     Navigator.pushNamedAndRemoveUntil(context,
                            //         AppRouter.customNavBar, (route) => false,
                            //         arguments: 3);
                            //     break;
                            //   case 4:
                            //     context.read<PropertyForRentBloc>().add(
                            //         GetPropertyForRentByIdRequested(
                            //             data[index].propertyId!.toInt()));
                            //     Navigator.pushNamedAndRemoveUntil(context,
                            //         AppRouter.propertyDetail, (route) => false,
                            //         arguments: 1);
                            //     break;

                            //   case 5:
                            //     // context.read<PropertyForRentBloc>().add(
                            //     //     GetPropertyForRentByIdRequested(
                            //     //         data[index].propertyId!.toInt()));
                            //     Navigator.pushNamedAndRemoveUntil(context,
                            //         AppRouter.customNavBar, (route) => false,
                            //         arguments: 2);
                            //     break;

                            //   case 7:
                            //     var contract = await ContractRepo()
                            //         .getContractById(
                            //             data[index].contractId!.toInt());
                            //     context.read<ContractBloc>().add(
                            //         GetContractByIdRequested(
                            //             data[index].contractId!.toInt()));
                            //     Navigator.pushNamedAndRemoveUntil(
                            //         context,
                            //         AppRouter.contractDetailPage,
                            //         (route) => false,
                            //         arguments:
                            //             ScreenContractArguments(contract, 1));
                            //     break;

                            //   // return;

                            //   // case 5:
                            //   //   Navigator.pushNamed(
                            //   //       context, AppRouter.);
                            //   //   break;
                            //   // case myPI:
                            //   //   break;
                            // }

                            navigatorNotification(data[index], context);

                            // print("object");
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              width: AppFormat.width(context),
                              decoration: BoxDecoration(
                                color: data[index].status == 1
                                    ? Colors.white
                                    : AppColor.backgroundColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColor.boderColor),
                              ),
                              child: Row(
                                children: [
                                  AppFormat.statusIconNoti(
                                      data[index].type!.toInt()),
                                  // data[index].type == 5
                                  //     ? const FaIcon(FontAwesomeIcons.briefcase)
                                  //     : data[index].type == 2
                                  //         ? const FaIcon(FontAwesomeIcons.clock)
                                  //         : const FaIcon(
                                  //             FontAwesomeIcons.accessibleIcon),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data[index].title.toString(),
                                          style: TxtStyle.heading4.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          data[index].body.toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TxtStyle.heading4.copyWith(
                                              color: AppColor.textColor),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            AppFormat
                                                .parseFormatDateAndTimeNoti(
                                                    AppFormat.parseDateNoti(
                                                            data[index]
                                                                .sendDateTime
                                                                .toString())
                                                        .toString()),
                                            style: TxtStyle.heading4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      );
                    },
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Future updateStatusNoti(int status, int index) async {
    docIds = [];
    await FirebaseFirestore.instance
        .collection("Broker1")
        .orderBy("SendDateTime", descending: true)
        .limit(30)
        .get()
        .then((value) => value.docs.forEach((element) {
              // print(element.reference);
              docIds.add(element.reference.id);
            }));
// update
    if (status == 1) {
      var user =
          FirebaseFirestore.instance.collection("Broker1").doc(docIds[index]);

      user.update({"status": 0});
    }
  }

  // Future createUser({required Userrr user}) async {
  //   final noti = FirebaseFirestore.instance.collection("notification").doc();
  //   print(FirebaseFirestore.instance.collection("notification").doc().id);
  //   // final json = {
  //   //   'description': des,
  //   //   "refId": 2,
  //   //   "title": "hi",
  //   //   "status": 2,
  //   //   "type": 2
  //   // };

  //   final json = user.toJson();

  //   await noti.set(json);
  // }
}

class Userrr extends Equatable {
  final String? body;
  final String? title;
  final num? type;
  final num? brandId;
  final num? brokerId;
  final num? propertyId;
  final num? teamId;
  final num? appointmentId;
  final num? contractId;
  final num? status;
  final String sendDateTime;

  const Userrr({
    this.title,
    this.teamId,
    this.body,
    this.brandId,
    this.appointmentId,
    this.contractId,
    this.brokerId,
    this.propertyId,
    this.status,
    required this.sendDateTime,
    this.type,
  });

  @override
  List<Object?> get props => [
        title,
        body,
        type,
        sendDateTime,
        brandId,
        brokerId,
        propertyId,
        appointmentId,
        contractId,
        status,
        teamId
      ];

  static Userrr fromJson(Map<String, dynamic> json) {
    Userrr category = Userrr(
        title: json["Title"],
        body: json["Body"],
        brandId: json["BrandId"],
        brokerId: json["BrokerId"],
        propertyId: json["PropertyId"],
        sendDateTime: json["SendDateTime"],
        teamId: json["TeamId"],
        appointmentId: json["AppointmentId"],
        contractId: json["ContractId"],
        status: json["status"],
        type: json["Type"]);

    return category;
  }

  Map<String, dynamic> toJson() => {
        "Title": title,
        "Body": body,
        "Type": type,
        "BrandId": brandId,
        "BrokerId": brokerId,
        "PropertyId": propertyId,
        "SendDateTime": sendDateTime,
        "TeamId": teamId,
        "status": status,
        "AppointmentId": appointmentId,
        "ContractId": contractId,
      };
}

// Future<String> get_data(DocumentReference doc_ref) async {
//   DocumentSnapshot docSnap = await doc_ref.get();
//   var doc_id2 = docSnap.reference.documentID;
//   return doc_id2;
// }
Future<void> navigatorNotification(Userrr userrr, BuildContext context) async {
  switch (userrr.type) {
    case 10:
      context
          .read<BrandBloc>()
          .add(GetBrandByIdRequested(userrr.brandId!.toInt()));
      Navigator.pushNamedAndRemoveUntil(
          context, AppRouter.brandDetail, (route) => false,
          arguments: 1);
      // Navigator.pushNamed(
      // context, AppRouter.brandDetail,
      // arguments: 1);
      break;
    // return;
    case 2:
      Navigator.pushNamedAndRemoveUntil(
          context, AppRouter.customNavBar, (route) => false,
          arguments: 3);
      break;
    case 4:
      context
          .read<PropertyForRentBloc>()
          .add(GetPropertyForRentByIdRequested(userrr.propertyId!.toInt()));
      Navigator.pushNamedAndRemoveUntil(
          context, AppRouter.propertyDetail, (route) => false,
          arguments: 1);
      break;

    case 5:
      // context.read<PropertyForRentBloc>().add(
      //     GetPropertyForRentByIdRequested(
      //         data[index].propertyId!.toInt()));
      Navigator.pushNamedAndRemoveUntil(
          context, AppRouter.customNavBar, (route) => false,
          arguments: 2);
      break;

    case 7:
      var contract =
          await ContractRepo().getContractById(userrr.contractId!.toInt());
      context
          .read<ContractBloc>()
          .add(GetContractByIdRequested(userrr.contractId!.toInt()));
      Navigator.pushNamedAndRemoveUntil(
          context, AppRouter.contractDetailPage, (route) => false,
          arguments: ScreenContractArguments(contract, 1));
      break;
  }
}
