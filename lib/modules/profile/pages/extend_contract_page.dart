import 'package:crel_mobile/common/widgets/stateful/chose_brand_contract.dart';
import 'package:crel_mobile/common/widgets/stateful/chose_owner_contract.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/contract.dart';
import 'package:crel_mobile/models/contract_term.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:crel_mobile/models/owner.dart';
import 'package:crel_mobile/modules/appointment/blocs/contract/contract_bloc.dart';
import 'package:crel_mobile/modules/mission/widgets/choose_text_from_drop.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_required_cccd.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_required_content_term.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_required_leaselength.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_required_m.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_required_payday.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_required_phone.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_required_price.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_required_stk.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_required_tax.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_required_title_term.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExtendEditContractPage extends StatefulWidget {
  final Contract contract;
  const ExtendEditContractPage({Key? key, required this.contract})
      : super(key: key);

  @override
  State<ExtendEditContractPage> createState() => _ExtendEditContractPageState();
}

class _ExtendEditContractPageState extends State<ExtendEditContractPage> {
  bool isValidDate = true;
  bool isValidSignDate = true;

  Brand? returnBrand;
  callbackBrand(returnData) {
    setState(() {
      // returnBrand = returnData;
      // isBrand = true;
      // _renterController.text = returnBrand!.name!;
    });
  }

  Property? returnProperty;
  callbackProperty(returnData) {
    setState(() {
      // returnProperty = returnData;
      // _paymentTermController.text = returnProperty!.paymentTerm.toString();
      // _priceController.text =
      //     AppFormat.changePriceVN(returnProperty!.price.toString());
      // returnOwner = returnProperty!.owners![0];
      // isProperty = true;
      // isOwner = true;
      // _areaController.text =
      //     AppFormat.changeMeterVN(returnProperty!.area.toString());
      // _addressController.text = AppFormat.getAddress(returnProperty!);
      // // if()
      // _lessorController.text = returnProperty!.owners![0].name!;
      // _lessorPhonenumberController.text =
      //     returnProperty!.owners![0].phoneNumber!;
    });
  }

  Owner? returnOwner;
  // bool isOwner = true;

  callbackOwner(returnData) {
    setState(() {
      returnOwner = returnData;
      isOwner = true;
      // _lessorController.text = returnOwner!.name!;
      _lessorPhonenumberController.text =
          AppFormat.phoneFormat(returnOwner!.phoneNumber!);
    });
  }

  // DateTime startDate =
  //     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  // DateTime endDate = DateTime(
  //     DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);
  bool isOwner = true;
  bool isBrand = true;
  bool isProperty = true;

  Future pickDateBirthday(BuildContext context, String dateType) async {
    final chooseDate = await showDatePicker(
        context: context,
        builder: (context, child) => Theme(
              data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                primary: AppColor.primaryColor,
              )),
              child: child!,
            ),
        initialDate: AppFormat.getYear18(),
        firstDate: AppFormat.getYear18Before100(),
        lastDate: AppFormat.getYear18());

    if (chooseDate == null) return;
    setState(() {
      switch (dateType) {
        case "lessorBirthDate":
          _lessorBirthDateController.text =
              AppFormat.parseDate(chooseDate.toString());
          lessorBirthDate = chooseDate;
          break;

        case "brandRepresentativeBirthday":
          _brandRepresentativeBirthdayController.text =
              AppFormat.parseDate(chooseDate.toString());
          brandRepresentativeBirthday = chooseDate;
          break;
        // default:
      }
    });
  }

  Future pickDateCccd(BuildContext context, String dateType) async {
    final chooseDate = await showDatePicker(
        context: context,
        builder: (context, child) => Theme(
              data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                primary: AppColor.primaryColor,
              )),
              child: child!,
            ),
        initialDate: AppFormat.getDateNow(),
        firstDate: DateTime(DateTime.now().year - 60),
        lastDate: AppFormat.getDateNow());

    if (chooseDate == null) return;
    setState(() {
      switch (dateType) {
        case "lessorCccdGrantDate":
          _lessorCccdGrantDateController.text =
              AppFormat.parseDate(chooseDate.toString());
          lessorCccdGrantDate = chooseDate;
          break;
        case "registrationNumberGrantDate":
          _registrationNumberGrantDateController.text =
              AppFormat.parseDate(chooseDate.toString());
          registrationNumberGrantDate = chooseDate;

          break;
        case "brandRepresentativeCccdGrantDate":
          _brandRepresentativeCccdGrantDateController.text =
              AppFormat.parseDate(chooseDate.toString());
          brandRepresentativeCccdGrantDate = chooseDate;

          break;
        // case "handoverDate":
        //   handoverDate = chooseDate;
        //   break;
        // case "signDate":
        //   signDate = chooseDate;
        //   break;
        // default:
      }
      // if (dateType == "lessorBirthDate") {
      //   lessorBirthDate = chooseDate;
      //   // endDate = DateTime(startDate.year + 1, startDate.month, startDate.day);
      // } else {
      //   endDate = chooseDate;
      // }
    });
  }

  Future pickDateSign(BuildContext context) async {
    final chooseDate = await showDatePicker(
        context: context,
        builder: (context, child) => Theme(
              data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                primary: AppColor.primaryColor,
              )),
              child: child!,
            ),
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));

    if (chooseDate == null) return;
    setState(() {
      _signDateController.text = AppFormat.parseDate(chooseDate.toString());
      signDate = chooseDate;
    });
  }

  Future pickDate(BuildContext context, String dateType) async {
    final chooseDate = await showDatePicker(
        context: context,
        builder: (context, child) => Theme(
              data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                primary: AppColor.primaryColor,
              )),
              child: child!,
            ),
        initialDate: widget.contract.endDate!,
        firstDate: widget.contract.endDate!,
        lastDate: DateTime(2100));

    if (chooseDate == null) return;
    setState(() {
      switch (dateType) {
        case "start":
          _startDateController.text =
              AppFormat.parseDate(chooseDate.toString());
          startDate = chooseDate;

          break;
        // case "registrationNumberGrantDate":
        //   _registrationNumberGrantDateController.text =
        //       AppFormat.parseDate(chooseDate.toString());
        //   registrationNumberGrantDate = chooseDate;
        //   break;

        case "handoverDate":
          _handoverDateController.text =
              AppFormat.parseDate(chooseDate.toString());
          handoverDate = chooseDate;

          break;

        // case "signDate":
        //   _signDateController.text = AppFormat.parseDate(chooseDate.toString());
        //   signDate = chooseDate;
        //   break;
      }
    });
  }

  final _paymentTermController = TextEditingController();
  final _priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late TargetPlatform? platform;
  DateTime? lessorBirthDate;
  DateTime? brandRepresentativeBirthday;
  DateTime? signDate;
  DateTime? lessorCccdGrantDate;
  DateTime? registrationNumberGrantDate;
  DateTime? brandRepresentativeCccdGrantDate;
  DateTime? handoverDate;
  DateTime? startDate;
  final _lessorBirthDateController = TextEditingController();
  final _lessorCccdGrantDateController = TextEditingController();
  final _searchController = TextEditingController();
  final _registrationNumberGrantDateController = TextEditingController();
  final _brandRepresentativeBirthdayController = TextEditingController();
  final _brandRepresentativeCccdGrantDateController = TextEditingController();
  final _lessorCccdController = TextEditingController();
  final _lessorController = TextEditingController();
  final _lessorCccdGrantAddressController = TextEditingController();
  final _lessorAddressController = TextEditingController();
  final _lessorBankAccountNumberController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  final _lessorPhonenumberController = TextEditingController();
  final _lessorBankController = TextEditingController();
  final _renterController = TextEditingController();
  final _addressController = TextEditingController();
  final _renterOfficeAddressController = TextEditingController();
  final _registrationNumberController = TextEditingController();
  final _registrationNumberGrantAddressController = TextEditingController();
  final _brandRepresentativeNameController = TextEditingController();
  final _brandRepresentativeAddressController = TextEditingController();
  final _brandRepresentativePhoneNumberController = TextEditingController();
  final _brandRepresentativeCccdController = TextEditingController();
  final _brandRepresentativeCccdGrantAddressController =
      TextEditingController();
  final _areaController = TextEditingController();
  // final _priceInTextController = TextEditingController();
  final _payDayController = TextEditingController();
  final _leaseLengthController = TextEditingController();
  // final _contractTermsController = TextEditingController();
  final _signDateController = TextEditingController();
  final _handoverDateController = TextEditingController();
  List<String> listBanking = [];
  String banking = "Ngân hàng 1";
  List<bool> isPlus = [];
  List<TextEditingController> titles = [];
  List<TextEditingController> contents = [];
  List<ContractTerm> contractTerms = [];
  List<List<bool>> isPlusChild = [[]];
  List<List<TextEditingController>> titlesChild = [[]];
  List<List<TextEditingController>> contentsChild = [[]];

  List<Widget> listTerms() {
    List<Widget> widgetTerm = [];
    //   List<List<Widget>> widgetTermChild = [[]];
    //   for (int i = 0; i < isPlus.length; i++) {
    //     widgetTerm.add(Padding(
    //       padding: const EdgeInsets.only(bottom: 16.0),
    //       child: SizedBox(
    //         width: AppFormat.width(context) - 32,
    //         child: Row(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             GestureDetector(
    //                 onTap: () {
    //                   setState(() {
    //                     // isPlus[1] = false;
    //                     isPlus.remove(isPlus[i]);
    //                     titles.remove(titles[i]);
    //                     contents.remove(contents[i]);
    //                     // widgetTerm.remove(term);
    //                   });
    //                 },
    //                 child: const Icon(Icons.close)),
    //             isPlus.length == i + 1
    //                 ? GestureDetector(
    //                     onTap: () {
    //                       setState(() {
    //                         isPlus.add(true);
    //                         isPlusChild.add([]);
    //                         titles.add(TextEditingController()..text = "");
    //                         titlesChild.add([]);
    //                         contents.add(TextEditingController()..text = "");
    //                         contentsChild.add([]);
    //                       });
    //                     },
    //                     child: const Icon(Icons.add))
    //                 : const SizedBox(),
    //             Expanded(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Container(
    //                     decoration: BoxDecoration(
    //                         border: Border.all(color: AppColor.boderColor),
    //                         borderRadius:
    //                             const BorderRadius.all(Radius.circular(10))),
    //                     child:
    //                         Column(crossAxisAlignment: CrossAxisAlignment.start,
    //                             // mainAxisAlignment: MainAxisAlignment.start,
    //                             children: [
    //                           CustomTFFRequiredTitleTerm(
    //                             type: TextInputType.name,
    //                             textController: titles[i],
    //                             name: "Tiêu đề: ",
    //                           ),
    //                           CustomTFFRequiredContentTerm(
    //                             type: TextInputType.name,
    //                             textController: contents[i],
    //                             name: "Nội dung: ",
    //                           ),
    //                         ]),
    //                   ),
    //                   // isPlusChild.isNotEmpty ?

    //                   Row(
    //                     children: [
    //                       GestureDetector(
    //                           onTap: () {
    //                             // setState(() {
    //                             //   term = false;
    //                             //   isPlus.remove(term);
    //                             // });
    //                           },
    //                           child: const Icon(Icons.close)),
    //                       GestureDetector(
    //                           onTap: () {
    //                             setState(() {
    //                               isPlusChild[i].add(true);
    //                               titlesChild[i]
    //                                   .add(TextEditingController()..text = "");
    //                               contentsChild[i]
    //                                   .add(TextEditingController()..text = "");
    //                             });
    //                           },
    //                           child: const Icon(Icons.add)),
    //                       isPlusChild[i].isNotEmpty
    //                           ? SizedBox(
    //                               width: 300 - 36,
    //                               child: Column(
    //                                 children: [
    //                                   for (int j = 0;
    //                                       j < isPlusChild[i].length;
    //                                       j++)
    //                                     Container(
    //                                       decoration: BoxDecoration(
    //                                           border: Border.all(
    //                                               color: AppColor.boderColor),
    //                                           borderRadius:
    //                                               const BorderRadius.all(
    //                                                   Radius.circular(10))),
    //                                       child: Column(
    //                                           crossAxisAlignment:
    //                                               CrossAxisAlignment.start,
    //                                           // mainAxisAlignment: MainAxisAlignment.start,
    //                                           children: [
    //                                             CustomTFFRequiredTitleTerm(
    //                                               type: TextInputType.name,
    //                                               textController: titlesChild[i]
    //                                                   [j],
    //                                               name: "Tiêu đề: ",
    //                                             ),
    //                                             CustomTFFRequiredContentTerm(
    //                                               type: TextInputType.name,
    //                                               textController: contentsChild[i]
    //                                                   [j],
    //                                               name: "Nội dung: ",
    //                                             ),
    //                                           ]),
    //                                     ),
    //                                 ],
    //                               ),
    //                             )
    //                           : const SizedBox()
    //                     ],
    //                   )
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ));
    //   }
    //   return widgetTerm;
    // }
    List<List<Widget>> widgetTermChild = [[]];
    for (int i = 0; i < isPlus.length; i++) {
      widgetTerm.add(Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: SizedBox(
          width: AppFormat.width(context) - 32,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      // isPlus[1] = false;
                      isPlus.remove(isPlus[i]);
                      titles.remove(titles[i]);
                      contents.remove(contents[i]);
                      isPlusChild.remove(isPlusChild[i]);
                      titlesChild.remove(titlesChild[i]);
                      contentsChild.remove(contentsChild[i]);
                      // widgetTerm.remove(term);
                    });
                  },
                  child: const Icon(Icons.close)),
              isPlus.length == i + 1
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          isPlus.add(true);
                          isPlusChild.add([]);
                          titles.add(TextEditingController()..text = "");
                          titlesChild.add([]);
                          contents.add(TextEditingController()..text = "");
                          contentsChild.add([]);
                        });
                      },
                      child: const Icon(Icons.add))
                  : const SizedBox(
                      width: 24,
                    ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.boderColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child:
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                            CustomTFFRequiredTitleTerm(
                              type: TextInputType.name,
                              textController: titles[i],
                              name: "Tiêu đề: ",
                            ),
                            CustomTFFRequiredContentTerm(
                              type: TextInputType.name,
                              textController: contents[i],
                              name: "Nội dung: ",
                            ),
                          ]),
                    ),
                    // isPlusChild.isNotEmpty ?

                    Row(
                      children: [
                        // isPlusChild[i].isEmpty
                        //     ? GestureDetector(
                        //         onTap: () {
                        //           // setState(() {
                        //           //   term = false;
                        //           //   isPlus.remove(term);
                        //           // });
                        //         },
                        //         child: const Icon(Icons.close))
                        //     : const SizedBox(),
                        isPlusChild[i].isEmpty
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPlusChild[i].add(true);
                                    titlesChild[i].add(
                                        TextEditingController()..text = "");
                                    contentsChild[i].add(
                                        TextEditingController()..text = "");
                                  });
                                },
                                child: const Icon(Icons.add))
                            : const SizedBox(),
                        isPlusChild[i].isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: SizedBox(
                                  width: 308,
                                  child: Column(
                                    children: [
                                      for (int j = 0;
                                          j < isPlusChild[i].length;
                                          j++)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 16.0),
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      isPlusChild[i].remove(
                                                          isPlusChild[i][j]);
                                                      titlesChild[i].remove(
                                                          titlesChild[i][j]);
                                                      contentsChild[i].remove(
                                                          contentsChild[i][j]);
                                                      // widgetTerm.remove(term);
                                                    });
                                                  },
                                                  child:
                                                      const Icon(Icons.close)),
                                              isPlusChild[i].length == j + 1
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isPlusChild[i]
                                                              .add(true);
                                                          titlesChild[i].add(
                                                              TextEditingController()
                                                                ..text = "");
                                                          contentsChild[i].add(
                                                              TextEditingController()
                                                                ..text = "");
                                                        });
                                                      },
                                                      child:
                                                          const Icon(Icons.add))
                                                  : const SizedBox(width: 24),
                                              Container(
                                                width: 300 - 40,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColor
                                                            .boderColor),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    // mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      CustomTFFRequiredTitleTerm(
                                                        type:
                                                            TextInputType.name,
                                                        textController:
                                                            titlesChild[i][j],
                                                        name: "Tiêu đề: ",
                                                      ),
                                                      CustomTFFRequiredContentTerm(
                                                        type:
                                                            TextInputType.name,
                                                        textController:
                                                            contentsChild[i][j],
                                                        name: "Nội dung: ",
                                                      ),
                                                    ]),
                                              ),
                                            ],
                                          ),
                                        ),
                                      // const SizedBox(
                                      //   height: 16,
                                      // )
                                      // Container(
                                      //   width: 200,
                                      //   height: 50,
                                      //   decoration: const BoxDecoration(
                                      //       color: Colors.amber),
                                      //   child: GestureDetector(
                                      //     child: const Icon(Icons.plus_one),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox()
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ));
    }
    // widgetTerm.add(Container(
    //   width: 320,
    //   height: 50,
    //   decoration: const BoxDecoration(color: Colors.amber),
    //   child: GestureDetector(
    //     child: const Icon(Icons.plus_one),
    //   ),
    // ));
    return widgetTerm;
  }

  @override
  void initState() {
    // IsolateNameServer.registerPortWithName(
    //     _port.sendPort, 'downloader_send_port');
    // _port.listen((dynamic data) {
    //   String id = data[0];
    //   DownloadTaskStatus status = data[1];
    //   int progress = data[2];

    //   if (status == DownloadTaskStatus.complete) {
    //     print("Download Complete");
    //   }
    //   setState(() {});
    // });
    // FlutterDownloader.registerCallback(downloadCallback);

    _paymentTermController.text = widget.contract.paymentTerm.toString();

    returnProperty = widget.contract.property;
    returnBrand = widget.contract.brand;

    _priceController.text =
        AppFormat.changePriceVN(widget.contract.price.toString());
    returnOwner = widget.contract.owner;
    _lessorPhonenumberController.text =
        AppFormat.phoneFormat(widget.contract.owner!.phoneNumber.toString());

    if (widget.contract.startDate != null) {
      startDate = widget.contract.endDate!;
      _startDateController.text =
          AppFormat.parseDate(widget.contract.endDate.toString());
    } else {
      _startDateController.text = "";
      startDate = DateTime.now();
    }

    if (widget.contract.lessorBirthDate != null) {
      lessorBirthDate = widget.contract.lessorBirthDate;
      _lessorBirthDateController.text =
          AppFormat.parseDate(widget.contract.lessorBirthDate.toString());
    } else {
      _lessorBirthDateController.text = "";
      lessorBirthDate = DateTime.now();
    }

    if (widget.contract.lessorCccdGrantDate != null) {
      lessorCccdGrantDate = widget.contract.lessorCccdGrantDate;
      _lessorCccdGrantDateController.text =
          AppFormat.parseDate(widget.contract.lessorCccdGrantDate.toString());
    } else {
      _lessorCccdGrantDateController.text = "";
      lessorCccdGrantDate = DateTime.now();
    }

    if (widget.contract.registrationNumberGrantDate != null) {
      registrationNumberGrantDate = widget.contract.registrationNumberGrantDate;
      _registrationNumberGrantDateController.text = AppFormat.parseDate(
          widget.contract.registrationNumberGrantDate.toString());
    } else {
      _registrationNumberGrantDateController.text = "";
      registrationNumberGrantDate = DateTime.now();
    }

    if (widget.contract.brandRepresentativeBirthday != null) {
      brandRepresentativeBirthday = widget.contract.brandRepresentativeBirthday;
      _brandRepresentativeBirthdayController.text = AppFormat.parseDate(
          widget.contract.brandRepresentativeBirthday.toString());
    } else {
      _brandRepresentativeBirthdayController.text = "";
      brandRepresentativeBirthday = DateTime.now();
    }

    if (widget.contract.brandRepresentativeCccdGrantDate != null) {
      brandRepresentativeCccdGrantDate =
          widget.contract.brandRepresentativeCccdGrantDate;
      _brandRepresentativeCccdGrantDateController.text = AppFormat.parseDate(
          widget.contract.brandRepresentativeCccdGrantDate.toString());
    } else {
      _brandRepresentativeCccdGrantDateController.text = "";
      brandRepresentativeCccdGrantDate = DateTime.now();
    }

    if (widget.contract.handoverDate != null) {
      handoverDate = widget.contract.endDate;
      _handoverDateController.text =
          AppFormat.parseDate(widget.contract.endDate.toString());
    } else {
      _handoverDateController.text = "";
      handoverDate = DateTime.now();
    }

    if (widget.contract.signDate != null) {
      //   signDate = widget.contract.signDate;
      //   _signDateController.text =
      //       AppFormat.parseDate(widget.contract.signDate.toString());
      // } else {
      //   _signDateController.text = "";
      //   signDate = DateTime.now();
      _signDateController.text = AppFormat.parseDate(DateTime.now().toString());
      signDate = DateTime.now();
    }
    // _lessorBirthDateController.text = widget.contract.lessorBirthDate == null
    //     ? DateTime.now().toString()
    //     : AppFormat.parseDate(widget.contract.lessorBirthDate.toString())
    //         .toString();
    // _lessorCccdGrantDateController.text = widget.contract.lessorCccdGrantDate ==
    //         null
    //     ? DateTime.now().toString()
    //     : AppFormat.parseDate(widget.contract.lessorCccdGrantDate.toString())
    //         .toString();
    // _registrationNumberGrantDateController.text =
    //     widget.contract.registrationNumberGrantDate == null
    //         ? DateTime.now().toString()
    //         : widget.contract.registrationNumberGrantDate == null
    //             ? ""
    //             : AppFormat.parseDate(
    //                     widget.contract.registrationNumberGrantDate.toString())
    //                 .toString();
    // _brandRepresentativeBirthdayController.text =
    //     widget.contract.brandRepresentativeBirthday == null
    //         ? DateTime.now().toString()
    //         : AppFormat.parseDate(
    //                 widget.contract.brandRepresentativeBirthday.toString())
    //             .toString();
    // _brandRepresentativeCccdGrantDateController.text =
    //     widget.contract.brandRepresentativeCccdGrantDate == null
    //         ? DateTime.now().toString()
    //         : AppFormat.parseDate(
    //                 widget.contract.brandRepresentativeCccdGrantDate.toString())
    //             .toString();
    _lessorCccdController.text = widget.contract.lessorCccd.toString();
    _lessorController.text = widget.contract.lessor.toString();
    _lessorCccdGrantAddressController.text =
        widget.contract.lessorCccdGrantAddress.toString();
    _lessorAddressController.text = widget.contract.lessorAddress.toString();
    _lessorBankAccountNumberController.text =
        widget.contract.lessorBankAccountNumber.toString();
    // _startDateController.text =
    //     AppFormat.parseDate(widget.contract.startDate.toString());
    //  _endDateController.text = TextEditingController();
    // _lessorPhonenumberController.text =
    //     widget.contract.owner!.phoneNumber.toString();
    _lessorBankController.text = widget.contract.lessorBank.toString();
    contractTerms.addAll(widget.contract.contractTerms!);
    if (contractTerms.isNotEmpty) {
      for (int i = 0; i < contractTerms.length; i++) {
        isPlus.add(true);
        titles.add(TextEditingController()..text = contractTerms[i].title!);
        contents.add(TextEditingController()..text = contractTerms[i].content!);
        isPlusChild.add([]);
        titlesChild.add([]);
        contentsChild.add([]);
        if (contractTerms[i].contractTerms != null)
          // ignore: curly_braces_in_flow_control_structures
          for (int j = 0; j < contractTerms[i].contractTerms!.length; j++) {
            isPlusChild[i].add(true);
            titlesChild[i].add(TextEditingController()
              ..text = contractTerms[i].contractTerms![j].title ?? "");
            contentsChild[i].add(TextEditingController()
              ..text = contractTerms[i].contractTerms![j].content ?? "");
          }
      }
    }
    // _renterController.text = returnBrand!.name!;
    _addressController.text = AppFormat.getAddress(widget.contract.property!);
    _renterOfficeAddressController.text =
        widget.contract.renterOfficeAddress.toString();
    _registrationNumberController.text =
        widget.contract.brand!.registrationNumber == null
            ? ""
            : widget.contract.brand!.registrationNumber.toString();
    _registrationNumberGrantAddressController.text =
        widget.contract.registrationNumberGrantAddress.toString();
    _brandRepresentativeNameController.text =
        widget.contract.brandRepresentativeName.toString();
    _brandRepresentativeAddressController.text =
        widget.contract.brandRepresentativeAddress.toString();
    _brandRepresentativePhoneNumberController.text = AppFormat.phoneFormat(
        widget.contract.brandRepresentativePhoneNumber.toString());
    _brandRepresentativeCccdController.text =
        widget.contract.brandRepresentativeCccd.toString();
    _brandRepresentativeCccdGrantAddressController.text =
        widget.contract.brandRepresentativeCccdGrantAddress.toString();
    _areaController.text =
        AppFormat.changeMeterVN(widget.contract.property!.area.toString());
    _payDayController.text =
        int.parse(widget.contract.payDay.toString()).toString();
    _leaseLengthController.text =
        AppFormat.changeMeterVN(widget.contract.leaseLength.toString())
            .toString();

    // _contractTermsController = widget.contract.lessorCccd.toString();
    // _handoverDateController.text = widget.contract.handoverDate == null
    //     ? DateTime.now().toString()
    //     : AppFormat.parseDate(widget.contract.handoverDate.toString());
    super.initState();
  }

  @override
  void dispose() {
    // IsolateNameServer.removePortNameMapping('downloader_send_port');

    _priceController.dispose();
    _searchController.dispose();
    _paymentTermController.dispose();
    _registrationNumberGrantDateController.dispose();
    _lessorBirthDateController.dispose();
    _lessorPhonenumberController.dispose();
    _brandRepresentativeCccdController.dispose();
    _lessorController.dispose();
    _lessorCccdGrantDateController.dispose();
    _brandRepresentativeCccdGrantDateController.dispose();
    _lessorCccdController.dispose();
    _lessorCccdGrantAddressController.dispose();
    _lessorAddressController.dispose();
    _lessorBankAccountNumberController.dispose();
    _lessorBankController.dispose();
    _brandRepresentativeBirthdayController.dispose();
    _renterController.dispose();
    _brandRepresentativeCccdGrantAddressController.dispose();
    _addressController.dispose();
    // _contractTermsController.dispose();
    _renterOfficeAddressController.dispose();
    _registrationNumberController.dispose();
    _handoverDateController.dispose();
    _signDateController.dispose();
    _registrationNumberGrantAddressController.dispose();
    _brandRepresentativeNameController.dispose();
    _brandRepresentativeAddressController.dispose();
    _brandRepresentativePhoneNumberController.dispose();
    _areaController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _payDayController.dispose();
    _leaseLengthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Gia hạn hợp đồng",
            style: TxtStyle.textAppBar,
          ),
          backgroundColor: AppColor.primaryColor,
          centerTitle: true,
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(
              'assets/icons/arrow-left.svg',
              color: Colors.white,
              // height: 250,
            ),
          ),
          // actions: [
          //   IconButton(
          //     onPressed: () {
          //       showDialog(
          //           context: context,
          //           builder: (context) => DialogRefuseContract(
          //               contract: widget.contract,
          //               reasonRefuse: AppFormat.getListDeleteContract()));
          //     },
          //     icon: SvgPicture.asset(
          //       'assets/icons/trash.svg',
          //       color: Colors.white,
          //       // height: 250,
          //     ),
          //     //  const FaIcon(FontAwesomeIcons.trash)
          //   ),
          // ],
        ),
        body: BlocListener<ContractBloc, ContractState>(
          listener: (context, state) {
            if (state is ContractCreateSuccess) {
              AppFormat.showSnackBar(context, 1, "Gia hạn thành công");
              Navigator.pop(context);
              Navigator.pop(context);
            }
            // if (state is ContractDeleteSuccess) {
            //   AppFormat.showSnackBar(context, 1, "Hủy hợp đồng thành công");
            //   Navigator.pop(context);
            // }
            // if (state is ContractLoaded) {

            //   // Navigator.of(context).pop();
            // }
          },
          child: BlocBuilder<ContractBloc, ContractState>(
            // buildWhen: (previous, current) =>
            //     previous != current && current is ContractByIdLoaded,
            builder: (context, state) {
              if (state is ContractLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // const SizedBox(
                      //   height: 8,
                      // ),
                      Container(
                        width: AppFormat.width(context),
                        color: AppColor.boderColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            "BÊN CHO THUÊ (BÊN A)",
                            style: TxtStyle.heading5Blue.copyWith(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 16, vertical: 8),
                      //   child: ChosePropertyContract(
                      //       callback: callbackProperty,
                      //       property: widget.contract.property != null
                      //           ? widget.contract.property!
                      //           : returnProperty),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ChoseOwnerContract(
                          isDiable: false,
                          callback: callbackOwner,
                          owner: returnOwner,
                          property: returnProperty,
                        ),
                      ),
                      !isOwner
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 12, left: 24, right: 16),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Vui lòng chọn chủ sở hữu",
                                  style: TxtStyle.heading5Blue.copyWith(
                                      fontSize: 12, color: Colors.red),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: InkWell(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              pickDateBirthday(context, "lessorBirthDate");
                            },
                            child: ChooseTextFromDrop(
                              isDisable: false,
                              lable: "Ngày sinh",
                              textController: _lessorBirthDateController,
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: CustomTFFRequiredCccd(
                            isDisable: false,
                            type: TextInputType.number,
                            textController: _lessorCccdController,
                            name: "CCCD: ",
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: InkWell(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();

                            pickDateCccd(context, "lessorCccdGrantDate");
                          },
                          child: ChooseTextFromDrop(
                            isDisable: false,
                            lable: "Ngày cấp",
                            textController: _lessorCccdGrantDateController,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: CustomTFFRequiredM(
                            isDisable: false,
                            isM: 2,
                            type: TextInputType.name,
                            textController: _lessorCccdGrantAddressController,
                            name: "Nơi cấp: ",
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: CustomTFFRequiredM(
                            isDisable: false,
                            isM: 2,
                            type: TextInputType.name,
                            textController: _lessorAddressController,
                            name: "Địa chỉ thường trú: ",
                          )),
                      IgnorePointer(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: CustomTFFRequiredPhone(
                              isDisable: true,
                              // isM: 2,
                              type: TextInputType.number,
                              textController: _lessorPhonenumberController,
                              name: "Số điện thoại: ",
                            )),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: CustomTFFRequiredSTK(
                            type: TextInputType.number,
                            textController: _lessorBankAccountNumberController,
                            name: "Số tài khoản: ",
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              listBanking = AppFormat.getListBanking();
                            });
                            _lessorBankController.text =
                                await choseBanking(context) ??
                                    _lessorBankController.text;
                          },
                          child: ChooseTextFromDrop(
                            isDisable: false,
                            lable: "Ngân hàng",
                            textController: _lessorBankController,
                          ),
                        ),
                      ),
                      // Padding(
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 16, vertical: 8),
                      //     child: CustomTFFRequiredM(
                      //       isDisable: true,
                      //       isM: 2,
                      //       type: TextInputType.name,
                      //       textController: _addressController,
                      //       name: "Chủ sở hữu của căn nhà: ",
                      //     )),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: AppFormat.width(context),
                        color: AppColor.boderColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            "BÊN B",
                            style: TxtStyle.heading5Blue.copyWith(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ChoseBrandContract(
                          callback: callbackBrand,
                          brand: returnBrand,
                        ),
                      ),
                      isBrand
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 12, left: 24, right: 16),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Vui lòng chọn thương hiệu",
                                  style: TxtStyle.heading5Blue.copyWith(
                                      fontSize: 12, color: Colors.red),
                                ),
                              ),
                            ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: CustomTFFRequiredM(
                            isDisable: false,
                            isM: 2,
                            type: TextInputType.name,
                            textController: _renterOfficeAddressController,
                            name: "Địa chỉ trụ sở: ",
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: IgnorePointer(
                            child: CustomTFFRequiredTax(
                              type: TextInputType.number,
                              textController: _registrationNumberController,
                              name: "Mã số doanh nghiệp",
                            ),
                          )),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: InkWell(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();

                            pickDateCccd(
                                context, "registrationNumberGrantDate");
                          },
                          child: ChooseTextFromDrop(
                            isDisable: false,
                            lable: "Cấp ngày",
                            textController:
                                _registrationNumberGrantDateController,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: CustomTFFRequiredM(
                            isDisable: false,
                            isM: 2,
                            type: TextInputType.name,
                            textController:
                                _registrationNumberGrantAddressController,
                            name: "Nơi cấp: ",
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: CustomTFFRequiredM(
                            isDisable: false,
                            isM: 2,
                            type: TextInputType.name,
                            textController: _brandRepresentativeNameController,
                            name: "Ông/bà: ",
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: InkWell(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();

                                pickDateBirthday(
                                    context, "brandRepresentativeBirthday");
                              },
                              child: ChooseTextFromDrop(
                                isDisable: false,
                                lable: "Ngày sinh",
                                textController:
                                    _brandRepresentativeBirthdayController,
                              ))),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: CustomTFFRequiredCccd(
                            isDisable: false,
                            type: TextInputType.number,
                            textController: _brandRepresentativeCccdController,
                            name: "CCCD: ",
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: InkWell(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();

                              pickDateCccd(
                                  context, "brandRepresentativeCccdGrantDate");
                            },
                            child: ChooseTextFromDrop(
                              isDisable: false,
                              lable: "Ngày cấp",
                              textController:
                                  _brandRepresentativeCccdGrantDateController,
                            )),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: CustomTFFRequiredM(
                            isDisable: false,
                            isM: 2,
                            type: TextInputType.name,
                            textController:
                                _brandRepresentativeCccdGrantAddressController,
                            name: "Nơi cấp: ",
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: CustomTFFRequiredM(
                            isDisable: false,
                            isM: 2,
                            type: TextInputType.name,
                            textController:
                                _brandRepresentativeAddressController,
                            name: "Địa chỉ thường trú: ",
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: CustomTFFRequiredPhone(
                            isDisable: false,
                            // isM: 2,
                            type: TextInputType.number,
                            textController:
                                _brandRepresentativePhoneNumberController,
                            name: "Số điện thoại: ",
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: AppFormat.width(context),
                        color: AppColor.boderColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            "ĐIỀU 1. ĐỐI TƯỢNG CỦA HỢP ĐỒNG",
                            style: TxtStyle.heading5Blue.copyWith(fontSize: 18),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: CustomTFFRequiredM(
                            isDisable: true,
                            isM: 2,
                            type: TextInputType.name,
                            textController: _addressController,
                            name: "Chủ sở hữu của căn nhà: ",
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: CustomTFFRequiredM(
                            isDisable: true,
                            isM: 1,
                            type: TextInputType.name,
                            textController: _areaController,
                            name: "Diện tích: ",
                          )),
                      Container(
                        width: AppFormat.width(context),
                        color: AppColor.boderColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            "ĐIỀU 2. GIÁ CHO THUÊ NHÀ Ở VÀ PHƯƠNG THỨC THANH TOÁN",
                            style: TxtStyle.heading5Blue.copyWith(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: CustomTFFRequiredPrice(
                            type: TextInputType.number,
                            textController: _priceController,
                            name: "Giá"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: CustomTFFRequiredPayday(
                            type: TextInputType.number,
                            textController: _payDayController,
                            name: "Ngày trả tiền hằng tháng"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: CustomTFFRequiredM(
                          isDisable: false,
                          isM: 2,
                          type: TextInputType.name,
                          textController: _paymentTermController,
                          name: "Chính sách thanh toán",
                        ),
                      ),
                      Container(
                        width: AppFormat.width(context),
                        color: AppColor.boderColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            "ĐIỀU 3. THỜI HẠN THUÊ VÀ THỜI ĐIỂM GIAO NHẬN NHÀ Ở",
                            style: TxtStyle.heading5Blue.copyWith(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: CustomTFFRequiredLeaseLenght(
                            type: TextInputType.number,
                            textController: _leaseLengthController,
                            name: "Thời hạn thuê: ",
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: InkWell(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();

                              pickDate(context, "start");
                            },
                            child: ChooseTextFromDrop(
                              isDisable: false,
                              lable: "Ngày thuê",
                              textController: _startDateController,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: InkWell(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();

                              pickDateSign(context);
                            },
                            child: ChooseTextFromDrop(
                              isDisable: false,
                              lable: "Ngày kí",
                              textController: _signDateController,
                            )),
                      ),
                      isValidSignDate
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 12, left: 24, right: 16),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Ngày kí không được lớn hơn ngày thuê hoặc ngày bàn giao",
                                  style: TxtStyle.heading5Blue.copyWith(
                                      fontSize: 12, color: Colors.red),
                                ),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: InkWell(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();

                              pickDate(context, "handoverDate");
                            },
                            child: ChooseTextFromDrop(
                              isDisable: false,
                              lable: "Ngày bàn giao",
                              textController: _handoverDateController,
                            )),
                      ),
                      Container(
                        width: AppFormat.width(context),
                        color: AppColor.boderColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            "THÊM ĐIỀU KHOẢN (NẾU CÓ)",
                            style: TxtStyle.heading5Blue.copyWith(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      isPlus.isNotEmpty
                          ? Column(children: listTerms())
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  isPlus.add(true);
                                  titles
                                      .add(TextEditingController()..text = "");
                                  contents
                                      .add(TextEditingController()..text = "");
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColor.boderColor),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: Text(
                                        "Thêm điều khoản",
                                        style: TxtStyle.heading4.copyWith(
                                            color: AppColor.textColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: SizedBox(
                          width: AppFormat.width(context),
                          child: ElevatedButton(
                            style: TxtStyle.buttonBlue,
                            onPressed: () async {
                              contractTerms = [];

                              for (int i = 0; i < isPlus.length; i++) {
                                List<ContractTerm> contractTermsChild = [];

                                for (int j = 0;
                                    j < isPlusChild[i].length;
                                    j++) {
                                  contractTermsChild.add(ContractTerm(
                                      title: titlesChild[i][j].text,
                                      content: contentsChild[i][j].text,
                                      index: j + 1));
                                }
                                contractTerms.add(ContractTerm(
                                    title: titles[i].text,
                                    content: contents[i].text,
                                    contractTerms: contractTermsChild,
                                    index: i + 1));
                              }

                              final prefs =
                                  await SharedPreferences.getInstance();
                              String? id = prefs.getString("id");

                              if (_formKey.currentState!.validate()
                                  // a.isEmpty &&
                                  // isBrand &&
                                  // isOwner &&
                                  // isProperty &&
                                  // &&
                                  // isValidSignDate
                                  //  && isValidDate
                                  ) {
                                // showConfirmContract(context);
                                if (signDate != null) {
                                  if (signDate!.isAfter(startDate!) ||
                                      signDate!.isAfter(handoverDate!)) {
                                    setState(() {
                                      isValidSignDate = false;
                                    });
                                  } else {
                                    isValidSignDate = true;
                                  }
                                }
                                if (isValidSignDate) {
                                  BlocProvider.of<ContractBloc>(context)
                                      .add(CreateContract(
                                    Contract(
                                        status: 1,
                                        // id: widget.contract.id,
                                        // appointmentId: widget.appointment.id,
                                        // contactId: 1,
                                        // ownerId: ,
                                        property: widget.contract.property,
                                        createDate: widget.contract.createDate,
                                        price: double.parse(AppFormat.savePrice(_priceController.text)) *
                                            1000000,
                                        ownerId: returnOwner!.id,
                                        brandId: widget.contract.brandId,
                                        startDate: startDate,
                                        endDate: widget.contract.endDate,
                                        paymentTerm:
                                            _paymentTermController.text.trim(),
                                        brokerId: int.parse(id.toString()),
                                        propertyId: widget.contract.propertyId,
                                        lessor: " ",
                                        signDate: signDate,
                                        lessorBirthDate: lessorBirthDate,
                                        lessorCccd:
                                            _lessorCccdController.text.trim(),
                                        lessorCccdGrantDate:
                                            lessorCccdGrantDate,
                                        lessorCccdGrantAddress:
                                            _lessorCccdGrantAddressController.text
                                                .trim(),
                                        lessorAddress: _lessorAddressController.text
                                            .trim(),
                                        lessorBankAccountNumber:
                                            _lessorBankAccountNumberController.text
                                                .trim(),
                                        lessorBank:
                                            _lessorBankController.text.trim(),
                                        renterOfficeAddress:
                                            _renterOfficeAddressController.text
                                                .trim(),
                                        registrationNumberGrantDate:
                                            registrationNumberGrantDate,
                                        registrationNumberGrantAddress:
                                            _registrationNumberGrantAddressController
                                                .text
                                                .trim(),
                                        brandRepresentativeName:
                                            _brandRepresentativeNameController.text
                                                .trim(),
                                        brandRepresentativeCccd:
                                            _brandRepresentativeCccdController.text
                                                .trim(),
                                        brandRepresentativeBirthday:
                                            brandRepresentativeBirthday,
                                        brandRepresentativeAddress:
                                            _brandRepresentativeAddressController.text.trim(),
                                        brandRepresentativePhoneNumber: AppFormat.savePhone(_brandRepresentativePhoneNumberController.text.trim()),
                                        brandRepresentativeCccdGrantDate: brandRepresentativeCccdGrantDate,
                                        brandRepresentativeCccdGrantAddress: _brandRepresentativeCccdGrantAddressController.text.trim(),
                                        payDay: int.parse(_payDayController.text.trim()),
                                        // registrationNumber: _registrationNumberController.text.trim(),
                                        leaseLength: double.parse(AppFormat.saveMeterVN(_leaseLengthController.text.trim())),
                                        contractTerms: contractTerms,
                                        handoverDate: handoverDate),

                                    // listImage,
                                  ));
                                }
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                'Gia hạn',
                                style: TxtStyle.heading3
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<String?> choseBanking(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SafeArea(
            child: StatefulBuilder(
              builder: (context, setState1) => DraggableScrollableSheet(
                expand: false,
                // initialChildSize: 0.915, //set this as you want
                // maxChildSize: 0.915, //set this as you want
                // minChildSize: 0.915, //set this as you want..
                builder: (context, scrollController) => Column(
                  children: [
                    Container(
                      color: AppColor.boderColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                _searchController.clear();
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.close)),
                          Text(
                            "Ngân hàng",
                            style: TxtStyle.heading4
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const IconButton(
                              onPressed: null,
                              icon: Icon(
                                Icons.close,
                                color: Colors.transparent,
                              )),
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(width: 1, color: AppColor.boderColor)),
                      child: TextField(
                        onChanged: (value) {
                          setState1(() {
                            listBanking = AppFormat.getListBanking()
                                .where((bankingName) => bankingName
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          });
                        },
                        controller: _searchController,
                        cursorColor: AppColor.secondColor,
                        style: const TextStyle(color: AppColor.secondColor),
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          // hintText: "Nhập",
                          hintStyle: TxtStyle.heading5Gray,
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColor.textColor,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: listBanking.length,
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  banking = listBanking[index];

                                  _searchController.clear();
                                });
                                Navigator.pop(context, banking);
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                  top: BorderSide(
                                    color: AppColor.boderColor,
                                    width: 1,
                                  ),
                                  bottom: BorderSide(
                                    color: AppColor.boderColor,
                                    width: 1,
                                  ),
                                )),
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    child: Text(
                                      listBanking[index].toString(),
                                      style: TxtStyle.heading4,
                                    )),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
