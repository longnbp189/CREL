import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:crel_mobile/common/widgets/stateful/chose_brand_contract.dart';
import 'package:crel_mobile/common/widgets/stateful/chose_owner_contract.dart';
import 'package:crel_mobile/common/widgets/stateful/chose_property_contract.dart';
import 'package:crel_mobile/config/app_color.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/app_router.dart';
import 'package:crel_mobile/config/text_style.dart';
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
import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateContractPage extends StatefulWidget {
  final Appointment? appointment;
  const CreateContractPage({Key? key, required this.appointment})
      : super(key: key);

  @override
  State<CreateContractPage> createState() => _CreateContractPageState();
}

class _CreateContractPageState extends State<CreateContractPage> {
  bool isValidDate = true;
  bool isOwner = true;
  bool isBrand = true;
  bool isProperty = true;
  bool isValidSignDate = true;

  // final ReceivePort _port = ReceivePort();
  // static void downloadCallback(
  //     String id, DownloadTaskStatus status, int progress) {
  //   final SendPort send =
  //       IsolateNameServer.lookupPortByName('downloader_send_port')!;
  //   send.send([id, status, progress]);
  // }

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

    _addressController.text = widget.appointment != null
        ? AppFormat.getAddress(widget.appointment!.property!)
        : "";

    _areaController.text = widget.appointment != null
        ? AppFormat.changeMeterVN(widget.appointment!.property!.area.toString())
        : "";

    _priceController.text = widget.appointment != null
        ? AppFormat.changePriceVN(
            widget.appointment!.property!.price.toString())
        : "";

    _paymentTermController.text = widget.appointment != null
        ? widget.appointment!.property!.paymentTerm.toString()
        : "";

    _lessorPhonenumberController.text = widget.appointment != null
        ? AppFormat.phoneFormat(
            widget.appointment!.property!.owners![0].phoneNumber.toString())
        : "";
    _registrationNumberController.text = widget.appointment != null
        ? widget.appointment!.brand!.registrationNumber.toString()
        : "";
    // FlutterDownloader.registerCallback(downloadCallback);
    // lessorBirthDate = DateTime.now().add(const Duration(days: 1));
    // brandRepresentativeBirthday = DateTime.now().add(const Duration(days: 2));
    // signDate = DateTime.now();
    // lessorCccdGrantDate = DateTime.now().add(const Duration(days: 3));
    // registrationNumberGrantDate = DateTime.now().add(const Duration(days: 4));
    // brandRepresentativeCccdGrantDate =
    //     DateTime.now().add(const Duration(days: 5));
    // handoverDate = DateTime.now().add(const Duration(days: 6));
    // _lessorBirthDateController.text =
    //     AppFormat.parseDate(lessorBirthDate.toString());
    // _lessorCccdGrantDateController.text =
    //     AppFormat.parseDate(lessorCccdGrantDate.toString());
    // _registrationNumberGrantDateController.text =
    //     AppFormat.parseDate(registrationNumberGrantDate.toString());
    // _brandRepresentativeBirthdayController.text =
    //     AppFormat.parseDate(brandRepresentativeBirthday.toString());
    // _brandRepresentativeCccdGrantDateController.text =
    //     AppFormat.parseDate(brandRepresentativeCccdGrantDate.toString());
    // _handoverDateController.text = AppFormat.parseDate(handoverDate.toString());
    // _startDateController.text = AppFormat.parseDate(startDate.toString());
    // _paymentTermController.text = "20%";
    // //  _priceController = TextEditingController();
    // _lessorCccdController.text = "1111111111111";
    // _lessorController.text = "Long";
    // _lessorCccdGrantAddressController.text = "Quan 1";
    // _lessorAddressController.text = "Quận 2";
    // _lessorBankAccountNumberController.text = "9999999999";
    // //  _lessorPhonenumberController.text = ;
    // _lessorBankController.text = "Vietconbank";
    // //  _renterController.text = "HighL";
    // // _addressController.text = "Quận 10";
    // _renterOfficeAddressController.text = "Quận 3";
    // _registrationNumberController.text = "123456745";
    // _registrationNumberGrantAddressController.text = "Quận 4";
    // _brandRepresentativeNameController.text = "Minh";
    // _brandRepresentativeAddressController.text = "Quận 5";
    // _brandRepresentativePhoneNumberController.text = "0000035254";
    // _brandRepresentativeCccdController.text = "22222222222";
    // _brandRepresentativeCccdGrantAddressController.text = "Quận 6";

    // // _areaController.text = "";
    // // final _priceInTextController = TextEditingController();
    // _payDayController.text = "3";
    // _leaseLengthController.text = "5";
    // _paymentTermController.text = widget.appointment == null
    //     ? ""
    //     : widget.appointment!.property!.paymentTerm.toString();

    // _priceController.text = widget.appointment == null
    //     ? ""
    //     : AppFormat.changePriceVN(
    //         widget.appointment!.property!.price.toString());
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
    //  _contractTermsController.text = TextEditingController();
    super.initState();
  }

  DateTime? date1;
  TimeOfDay? timer1;
  List<String> listBanking = [];
  String banking = "Ngân hàng 1";
  List<ContractTerm> contractTerms = [];

  DateTime startDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime endDate = DateTime(
      DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);
  // bool isValidDate = true;
  // bool isSuccessProperty = false;

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
        initialDate: (dateType == "end") ? endDate : DateTime.now(),
        firstDate: (dateType == "end") ? endDate : DateTime.now(),
        lastDate: DateTime(2100));

    if (chooseDate == null) return;
    setState(() {
      switch (dateType) {
        case "start":
          _startDateController.text =
              AppFormat.parseDate(chooseDate.toString());
          startDate = chooseDate;
          // endDate =
          //     DateTime(startDate.year + 1, startDate.month, startDate.day);
          break;
        case "registrationNumberGrantDate":
          _registrationNumberGrantDateController.text =
              AppFormat.parseDate(chooseDate.toString());
          registrationNumberGrantDate = chooseDate;
          break;

        case "handoverDate":
          _handoverDateController.text =
              AppFormat.parseDate(chooseDate.toString());
          handoverDate = chooseDate;

          break;

        // case "end":
        //   _endDateController.text = AppFormat.parseDate(chooseDate.toString());
        //   endDate = chooseDate;
        //   // _brandRepresentativeCccdGrantDateController.text =
        //   //     AppFormat.parseDate(chooseDate.toString());
        //   break;

        case "signDate":
          _signDateController.text = AppFormat.parseDate(chooseDate.toString());
          signDate = chooseDate;
          break;
      }
    });
  }

  // Owner returnOwner = Owner();
  // callbackOwner(returnData) {
  //   setState(() {
  //     returnOwner = returnData;
  //     isOwner = true;
  //   });
  // }

  Brand? returnBrand;
  callbackBrand(returnData) {
    setState(() {
      returnBrand = returnData;
      isBrand = true;

      _renterController.text = returnBrand!.name!;
      _registrationNumberController.text =
          returnBrand!.registrationNumber ?? "";
    });
  }

  Property? returnProperty;
  callbackProperty(returnData) {
    setState(() {
      returnProperty = returnData;
      _paymentTermController.text = returnProperty!.paymentTerm.toString();
      _priceController.text =
          AppFormat.changePriceVN(returnProperty!.price.toString());
      // callbackOwner(returnProperty!.owners![0]);
      _areaController.text =
          AppFormat.changeMeterVN(returnProperty!.area.toString());
      returnOwner = returnProperty!.owners![0];
      _addressController.text = AppFormat.getAddress(returnProperty!);
      _lessorController.text = returnProperty!.owners![0].name!;
      _lessorPhonenumberController.text = AppFormat.phoneFormat(
          returnProperty!.owners![0].phoneNumber.toString());
      isProperty = true;
      isOwner = true;
    });
  }

  Owner? returnOwner;
  // bool isOwner = true;

  callbackOwner(returnData) {
    setState(() {
      returnOwner = returnData;
      isOwner = true;
      _lessorController.text = returnOwner!.name!;
      _lessorPhonenumberController.text =
          AppFormat.phoneFormat(returnOwner!.phoneNumber.toString());
    });
  }

  late TargetPlatform? platform;
  DateTime? lessorBirthDate;
  DateTime? brandRepresentativeBirthday;
  DateTime? signDate;
  DateTime? lessorCccdGrantDate;
  DateTime? registrationNumberGrantDate;
  DateTime? brandRepresentativeCccdGrantDate;
  DateTime? handoverDate;
  final _lessorBirthDateController = TextEditingController();
  final _lessorCccdGrantDateController = TextEditingController();
  final _searchController = TextEditingController();
  final _registrationNumberGrantDateController = TextEditingController();
  final _brandRepresentativeBirthdayController = TextEditingController();
  final _brandRepresentativeCccdGrantDateController = TextEditingController();
  final _paymentTermController = TextEditingController();
  final _priceController = TextEditingController();
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
  final _payDayController = TextEditingController();
  final _leaseLengthController = TextEditingController();
  final _contractTermsController = TextEditingController();
  final _signDateController = TextEditingController();
  final _handoverDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<bool> isPlus = [];
  List<List<bool>> isPlusChild = [[]];
  List<TextEditingController> titles = [];
  List<List<TextEditingController>> titlesChild = [[]];
  List<TextEditingController> contents = [];
  List<List<TextEditingController>> contentsChild = [[]];
  List<Widget> listTerms() {
    List<Widget> widgetTerm = [];
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
                          color: Colors.white,
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
                                                    color: Colors.white,
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
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    _searchController.dispose();
    _paymentTermController.dispose();
    _registrationNumberGrantDateController.dispose();
    _lessorBirthDateController.dispose();
    _priceController.dispose();
    _lessorPhonenumberController.dispose();
    _brandRepresentativeCccdController.dispose();
    _lessorController.dispose();
    _lessorCccdGrantDateController.dispose();
    _lessorCccdController.dispose();
    _lessorCccdGrantAddressController.dispose();
    _lessorAddressController.dispose();
    _lessorBankAccountNumberController.dispose();
    _lessorBankController.dispose();
    _brandRepresentativeBirthdayController.dispose();
    _brandRepresentativeCccdGrantDateController.dispose();

    _renterController.dispose();
    _brandRepresentativeCccdGrantAddressController.dispose();
    _addressController.dispose();
    _contractTermsController.dispose();
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

  bool isCreateContract = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Tạo hợp đồng",
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
          ),
          body: SafeArea(
              child: Container(
            color: AppColor.backgroundColor,
            child: BlocListener<ContractBloc, ContractState>(
              listener: (context, state) {
                // if (state is ContractCreateSuccess) {
                //   isCreateContract = true;
                //   // AppFormat.showSnackBar(context, 1, "Tạo hợp đồng thành công");
                // }
                if (state is ContractCreateSuccess) {
                  AppFormat.showSnackBar(context, 1, "Tạo hợp đồng thành công");
                  if (widget.appointment != null) {
                    Navigator.pushNamed(
                      context,
                      AppRouter.contractPage,
                    );
                  } else {
                    Navigator.pop(context);
                  }

                  // Navigator.pushNamedAndRemoveUntil(
                  //   context,
                  //   AppRouter.,
                  //   (route) => false,
                  //   arguments:  ,1
                  // );
                }
                if (state is ContractLoaded) {
                  // AppFormat.showSnackBar(context, 1, "Tạo hợp đồng thành công");

                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRouter.contractPage, (route) => false,
                      arguments: 1);
                }
              },
              child: BlocBuilder<ContractBloc, ContractState>(
                builder: (context, state) {
                  if (state is ContractLoading
                      //  ||
                      //     state is ContractCreateSuccess
                      ) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: ChosePropertyContract(
                                callback: callbackProperty,
                                property: widget.appointment != null
                                    ? widget.appointment!.property!
                                    : returnProperty),
                          ),

                          Container(
                            width: AppFormat.width(context),
                            color: AppColor.boderColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                "BÊN CHO THUÊ (BÊN A)",
                                style: TxtStyle.heading5Blue
                                    .copyWith(fontSize: 18),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          // returnProperty != null || widget.appointment != null
                          //     ? Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 16, vertical: 8),
                          //         child: ChooseTextFromDropLines(
                          //             isDisable: true,
                          //             lable: "Địa chỉ",
                          //             textController: _addressController),
                          //       )
                          //     : const SizedBox(),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: ChoseOwnerContract(
                              isDiable: false,
                              callback: callbackOwner,
                              owner: widget.appointment != null
                                  ? widget.appointment!.property!.owners![0]
                                  : returnOwner,
                              property: widget.appointment != null
                                  ? widget.appointment!.property
                                  : returnProperty,
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

                          // Padding(
                          //     padding: const EdgeInsets.symmetric(
                          //         horizontal: 16, vertical: 8),
                          //     child: CustomTFFRequiredM(
                          //       isDisable: true,
                          //       isM: 2,
                          //       type: TextInputType.name,
                          //       textController: _lessorController,
                          //       name: "Người cho thuê: ",
                          //     )),

                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: InkWell(
                                  onTap: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();

                                    pickDateBirthday(
                                        context, "lessorBirthDate");
                                  },
                                  child: ChooseTextFromDrop(
                                    isDisable: false,
                                    lable: "Ngày sinh",
                                    textController: _lessorBirthDateController,
                                  ))),

                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: CustomTFFRequiredCccd(
                                isDisable: false,
                                type: TextInputType.number,
                                textController: _lessorCccdController,
                                name: "CCCD",
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
                                  textController:
                                      _lessorCccdGrantDateController,
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
                                    _lessorCccdGrantAddressController,
                                name: "Nơi cấp",
                              )),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: CustomTFFRequiredM(
                                isDisable: false,
                                isM: 2,
                                type: TextInputType.name,
                                textController: _lessorAddressController,
                                name: "Địa chỉ thường trú",
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
                                  name: "Số điện thoại",
                                )),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: CustomTFFRequiredSTK(
                                type: TextInputType.number,
                                textController:
                                    _lessorBankAccountNumberController,
                                name: "Số tài khoản",
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

                            // CustomTFFRequiredM(
                            //   isDisable: false,
                            //   isM: 2,
                            //   type: TextInputType.name,
                            //   textController: _lessorBankController,
                            //   name: "Mở tại ngân hàng: ",
                            // )
                          ),

                          // Padding(
                          //     padding: const EdgeInsets.symmetric(
                          //         horizontal: 16, vertical: 8),
                          //     child: CustomTFFRequiredM(
                          //       isDisable: true,
                          //       isM: 2,
                          //       type: TextInputType.name,
                          //       textController: _addressController,
                          //       name: "Chủ sở hữu của căn nhà",
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
                                style: TxtStyle.heading5Blue
                                    .copyWith(fontSize: 18),
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
                              brand: widget.appointment != null
                                  ? widget.appointment!.brand!
                                  : returnBrand,
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
                                name: "Địa chỉ trụ sở",
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
                                    _registrationNumberGrantAddressController,
                                name: "Nơi cấp",
                              )),

                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: CustomTFFRequiredM(
                                isDisable: false,
                                isM: 2,
                                type: TextInputType.name,
                                textController:
                                    _brandRepresentativeNameController,
                                name: "Ông/bà",
                              )),

                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: InkWell(
                                  onTap: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();

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
                                textController:
                                    _brandRepresentativeCccdController,
                                name: "CCCD",
                              )),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: InkWell(
                                onTap: () {
                                  FocusManager.instance.primaryFocus?.unfocus();

                                  pickDateCccd(context,
                                      "brandRepresentativeCccdGrantDate");
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
                                name: "Nơi cấp",
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
                                name: "Địa chỉ thường trú",
                              )),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: CustomTFFRequiredPhone(
                                isDisable: false,
                                // isDisable: true,
                                // isM: 2,
                                type: TextInputType.number,
                                textController:
                                    _brandRepresentativePhoneNumberController,
                                name: "Số điện thoại",
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
                                style: TxtStyle.heading5Blue
                                    .copyWith(fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),

                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: CustomTFFRequiredM(
                                isDisable: true,
                                isM: 2,
                                type: TextInputType.name,
                                textController: _addressController,
                                name: "Chủ sở hữu của căn nhà",
                              )),

                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: CustomTFFRequiredM(
                                isDisable: true,
                                isM: 1,
                                type: TextInputType.name,
                                textController: _areaController,
                                name: "Diện tích",
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
                                "ĐIỀU 2. GIÁ CHO THUÊ NHÀ Ở VÀ PHƯƠNG THỨC THANH TOÁN",
                                style: TxtStyle.heading5Blue
                                    .copyWith(fontSize: 18),
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
                                "ĐIỀU 3. THỜI HẠN THUÊ VÀ THỜI ĐIỂM GIAO NHẬN NHÀ Ở",
                                style: TxtStyle.heading5Blue
                                    .copyWith(fontSize: 18),
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
                                name: "Thời hạn thuê",
                              )),
                          // child: CustomTFFRequiredM(
                          //   isDisable: false,
                          //   isM: 7,
                          //   type: TextInputType.name,
                          //   textController: _leaseLengthController,
                          //   name: "Thời hạn thuê: ",
                          // )),

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

                                  pickDate(context, "signDate");
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
                                "THÊM ĐIỀU KHOẢN (NẾU CÓ)",
                                style: TxtStyle.heading5Blue
                                    .copyWith(fontSize: 18),
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
                                      titles.add(
                                          TextEditingController()..text = "");
                                      contents.add(
                                          TextEditingController()..text = "");
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: AppColor.boderColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          child: Text(
                                            "Thêm điều khoản",
                                            style: TxtStyle.heading4.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.textColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: SizedBox(
                              width: AppFormat.width(context),
                              child: ElevatedButton(
                                style: TxtStyle.buttonBlue,
                                onPressed: () async {
                                  // contractTermsChild.add(ContractTerm(
                                  //   title: "ĐIỀU 112312",
                                  //   content: "2222.1 ahihi đồ ngốc",
                                  //   index: 1,
                                  // ));
                                  // contractTermsChild.add(ContractTerm(
                                  //   title: "ĐIỀU 112312",
                                  //   content: "111.1 ahihi đồ ngốc",
                                  //   index: 2,
                                  // ));
                                  // contractTermsChild.add(ContractTerm(
                                  //   title: "ĐIỀU 112312",
                                  //   content: "111.1 ahihi đồ ngốc",
                                  //   index: 3,
                                  // ));
                                  // contractTerms.add(ContractTerm(
                                  //     title: "ĐIỀU 11",
                                  //     content: "4444.1 ahihi đồ ngốc",
                                  //     index: 1,
                                  //     contractTerms: contractTermsChild));
                                  // contractTerms.add(ContractTerm(
                                  //   title: "ĐIỀU 22",
                                  //   content: "4444.1 ahihi đồ ngốc",
                                  //   index: 1,
                                  // ));
                                  // contractTerms.add(ContractTerm(
                                  //   title: "ĐIỀU 333",
                                  //   content: "4444.1 ahihi đồ ngốc",
                                  //   index: 4,
                                  // ));
                                  // contractTerms.add(ContractTerm(
                                  //   title: "ĐIỀU 4444",
                                  //   content: "444.1 ahihi đồ ngốc",
                                  //   index: 2,
                                  // ));
                                  // contractTerms.add(ContractTerm(
                                  //     title: "ĐIỀU 55555",
                                  //     content: "55555 ahihi đồ ngốc",
                                  //     index: 3,
                                  //     contractTerms: contractTermsChild));
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
                                  // if (listImage.isNotEmpty &&
                                  //     (listImage.length) < 11) {
                                  //   setState(() {
                                  //     isHasImage = true;
                                  //   });
                                  // } else {
                                  //   setState(() {
                                  //     isHasImage = false;
                                  //   });
                                  // }

                                  if (_formKey.currentState!.validate()
                                      // &&
                                      //         // a.isEmpty &&
                                      //         isBrand &&
                                      //         isOwner &&
                                      //         isProperty &&
                                      //         isValidSignDate
                                      // isHasImage
                                      //  && isValidDate
                                      ) {
                                    // showConfirmContract(context);
                                    if (returnBrand != null ||
                                        widget.appointment!.brandId != null) {
                                      setState(() {
                                        isBrand = true;
                                      });
                                    } else {
                                      setState(() {
                                        isBrand = false;
                                      });
                                    }

                                    if (returnOwner != null ||
                                        widget.appointment!.property != null) {
                                      setState(() {
                                        isOwner = true;
                                      });
                                    } else {
                                      setState(() {
                                        isOwner = false;
                                      });
                                    }

                                    if (returnProperty != null ||
                                        widget.appointment!.propertyId !=
                                            null) {
                                      setState(() {
                                        isProperty = true;
                                      });
                                    } else {
                                      setState(() {
                                        isProperty = false;
                                      });
                                    }
                                    if (signDate != null) {
                                      if (signDate!.isAfter(startDate) ||
                                          signDate!.isAfter(handoverDate!)) {
                                        setState(() {
                                          isValidSignDate = false;
                                        });
                                      } else {
                                        isValidSignDate = true;
                                      }
                                    }
                                    if (isBrand &&
                                        isOwner &&
                                        isProperty &&
                                        isValidSignDate) {
                                      BlocProvider.of<ContractBloc>(context)
                                          .add(CreateContract(
                                        Contract(
                                            startDate: startDate,
                                            // endDate: endDate,
                                            ownerId: returnOwner == null
                                                ? widget.appointment!.property!
                                                    .owners![0].id
                                                : returnOwner!.id,
                                            propertyId: returnProperty == null
                                                ? widget.appointment!.propertyId
                                                : returnProperty!.id,
                                            brokerId: int.parse(id.toString()),
                                            brand: returnBrand ??
                                                widget.appointment!.brand,
                                            brandId: returnBrand == null
                                                ? widget.appointment!.brandId
                                                : returnBrand!.id,
                                            status: 1,
                                            paymentTerm: _paymentTermController.text
                                                .trim(),
                                            price: double.parse(AppFormat.savePrice(_priceController.text)) *
                                                1000000,
                                            lessor: " ",
                                            signDate: signDate,
                                            lessorBirthDate: lessorBirthDate,
                                            lessorCccd: _lessorCccdController.text
                                                .trim(),
                                            lessorCccdGrantDate:
                                                lessorCccdGrantDate,
                                            lessorCccdGrantAddress:
                                                _lessorCccdGrantAddressController.text
                                                    .trim(),
                                            lessorAddress:
                                                _lessorAddressController.text
                                                    .trim(),
                                            lessorBankAccountNumber:
                                                _lessorBankAccountNumberController.text
                                                    .trim(),
                                            lessorBank: _lessorBankController.text
                                                .trim(),
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
                                                _brandRepresentativeNameController.text.trim(),
                                            brandRepresentativeCccd: _brandRepresentativeCccdController.text.trim(),
                                            brandRepresentativeBirthday: brandRepresentativeBirthday,
                                            brandRepresentativeAddress: _brandRepresentativeAddressController.text.trim(),
                                            brandRepresentativePhoneNumber: AppFormat.savePhone(_brandRepresentativePhoneNumberController.text.trim()),
                                            brandRepresentativeCccdGrantDate: brandRepresentativeCccdGrantDate,
                                            brandRepresentativeCccdGrantAddress: _brandRepresentativeCccdGrantAddressController.text.trim(),
                                            payDay: int.parse(_payDayController.text.trim()),
                                            // registrationNumber: _registrationNumberController.text.trim(),
                                            leaseLength: double.parse(AppFormat.saveMeterVN(_leaseLengthController.text.trim())),
                                            contractTerms: contractTerms,
                                            handoverDate: handoverDate),
                                        // listImage
                                      ));
                                    }
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Text(
                                    'Tạo',
                                    style: TxtStyle.heading3
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ))),
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
                            "Chọn ngân hàng",
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

  // Future<dynamic> showConfirmContract(BuildContext context) {
  //   return showDialog(
  //     context: context,
  //     builder: (context) => Dialog(
  //       insetPadding: const EdgeInsets.all(16),
  //       child: BlocListener<ContractBloc, ContractState>(
  //         listener: (context, state) {
  //           if (state is ContractCreateSuccess) {
  //             AppFormat.showSnackBar(context, 1, "Tạo thành công");

  //             Timer(const Duration(milliseconds: 800), () {
  //               Navigator.of(context).pushAndRemoveUntil(
  //                 MaterialPageRoute(builder: (context) => const CustomNavBar()),
  //                 (route) => false,
  //               );
  //             });
  //           }
  //         },
  //         child: Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             color: AppColor.cardColor,
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.all(16),
  //             child: Wrap(
  //               children: [
  //                 Column(
  //                   children: [
  //                     Text(
  //                       "Xác nhận hợp đồng",
  //                       style: TxtStyle.heading3
  //                           .copyWith(color: AppColor.primaryColor),
  //                     ),
  //                     const SizedBox(
  //                       height: 16,
  //                     ),
  //                     Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         const Expanded(
  //                             flex: 2,
  //                             child: Text(
  //                               "Thương hiệu: ",
  //                               style: TxtStyle.heading4,
  //                             )),
  //                         Expanded(
  //                             flex: 5,
  //                             child: Container(
  //                               decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(10),
  //                                   border: Border.all(
  //                                       color: AppColor.secondColor)),
  //                               child: Padding(
  //                                 padding: const EdgeInsets.symmetric(
  //                                     horizontal: 16, vertical: 8),
  //                                 child: Text(
  //                                   widget.appointment!.brand!.name.toString(),
  //                                   maxLines: 2,
  //                                   overflow: TextOverflow.ellipsis,
  //                                   style: TxtStyle.heading4,
  //                                 ),
  //                               ),
  //                             )),
  //                       ],
  //                     ),
  //                     const SizedBox(
  //                       height: 8,
  //                     ),
  //                     Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         const Expanded(
  //                             flex: 2,
  //                             child: Text(
  //                               "Mặt bằng: ",
  //                               style: TxtStyle.heading4,
  //                             )),
  //                         Expanded(
  //                             flex: 5,
  //                             child: Container(
  //                               decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(10),
  //                                   border: Border.all(
  //                                       color: AppColor.secondColor)),
  //                               child: Padding(
  //                                 padding: const EdgeInsets.symmetric(
  //                                     horizontal: 16, vertical: 8),
  //                                 child: Text(
  //                                   widget.appointment!.property!.name
  //                                       .toString(),
  //                                   maxLines: 2,
  //                                   overflow: TextOverflow.ellipsis,
  //                                   style: TxtStyle.heading4,
  //                                 ),
  //                               ),
  //                             )),
  //                       ],
  //                     ),
  //                     const SizedBox(
  //                       height: 8,
  //                     ),
  //                     Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         const Expanded(
  //                             flex: 2,
  //                             child: Text(
  //                               "Địa chỉ: ",
  //                               style: TxtStyle.heading4,
  //                             )),
  //                         Expanded(
  //                             flex: 5,
  //                             child: Container(
  //                               decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(10),
  //                                   border: Border.all(
  //                                       color: AppColor.secondColor)),
  //                               child: Padding(
  //                                 padding: const EdgeInsets.symmetric(
  //                                     horizontal: 16, vertical: 8),
  //                                 child: Text(
  //                                   widget.appointment!.property!.location!
  //                                       .address
  //                                       .toString(),
  //                                   maxLines: 2,
  //                                   overflow: TextOverflow.ellipsis,
  //                                   style: TxtStyle.heading4,
  //                                 ),
  //                               ),
  //                             ))
  //                       ],
  //                     ),
  //                     const SizedBox(
  //                       height: 8,
  //                     ),
  //                     Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         const Expanded(
  //                             flex: 2,
  //                             child: Text(
  //                               "Ngày bắt đầu: ",
  //                               style: TxtStyle.heading4,
  //                             )),
  //                         Expanded(
  //                             flex: 5,
  //                             child: Container(
  //                               decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(10),
  //                                   border: Border.all(
  //                                       color: AppColor.secondColor)),
  //                               child: Padding(
  //                                 padding: const EdgeInsets.symmetric(
  //                                     horizontal: 16, vertical: 8),
  //                                 child: Text(
  //                                   AppFormat.parseDate(startDate.toString()),
  //                                   maxLines: 2,
  //                                   overflow: TextOverflow.ellipsis,
  //                                   style: TxtStyle.heading4,
  //                                 ),
  //                               ),
  //                             ))
  //                       ],
  //                     ),
  //                     const SizedBox(
  //                       height: 8,
  //                     ),
  //                     Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         const Expanded(
  //                             flex: 2,
  //                             child: Text(
  //                               "Ngày kết thúc: ",
  //                               style: TxtStyle.heading4,
  //                             )),
  //                         Expanded(
  //                             flex: 5,
  //                             child: Container(
  //                               decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(10),
  //                                   border: Border.all(
  //                                       color: AppColor.secondColor)),
  //                               child: Padding(
  //                                 padding: const EdgeInsets.symmetric(
  //                                     horizontal: 16, vertical: 8),
  //                                 child: Text(
  //                                   AppFormat.parseDate(endDate.toString()),
  //                                   maxLines: 2,
  //                                   overflow: TextOverflow.ellipsis,
  //                                   style: TxtStyle.heading4,
  //                                 ),
  //                               ),
  //                             ))
  //                       ],
  //                     ),
  //                     Padding(
  //                         padding: const EdgeInsets.only(top: 8.0),
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Expanded(
  //                               flex: 5,
  //                               child: ElevatedButton(
  //                                   onPressed: () {
  //                                     Navigator.of(context).pop();
  //                                   },
  //                                   style: ButtonStyle(
  //                                       foregroundColor:
  //                                           MaterialStateProperty.all<Color>(
  //                                               Colors.white),
  //                                       backgroundColor:
  //                                           MaterialStateProperty.all<Color>(
  //                                               AppColor.primaryColor),
  //                                       shape: MaterialStateProperty.all(
  //                                           RoundedRectangleBorder(
  //                                         borderRadius:
  //                                             BorderRadius.circular(10),
  //                                       ))),
  //                                   child: Text('Hủy',
  //                                       style: TxtStyle.heading4
  //                                           .copyWith(color: Colors.white))),
  //                             ),
  //                             const Expanded(child: SizedBox()),
  //                             Expanded(
  //                               flex: 5,
  //                               child: ElevatedButton(
  //                                   onPressed: () {
  //                                     BlocProvider.of<ContractBloc>(context)
  //                                         .add(CreateContract(
  //                                       Contract(
  //                                           status: 1,
  //                                           // appointmentId:
  //                                           //     widget.appointment.id,
  //                                           // contactId: 1,
  //                                           startDate: startDate,
  //                                           endDate: endDate,
  //                                           propertyId: widget
  //                                               .appointment!.property!.id),
  //                                       // listImage
  //                                       // Store(
  //                                       //   brandId:
  //                                       //       widget.appointment.brandId,
  //                                       //   locationId:
  //                                       //       widget.property.locationId,
  //                                       //   name: (widget
  //                                       //           .appointment.brand!.name
  //                                       //           .toString() +
  //                                       //       " " +
  //                                       //       widget.property.location!
  //                                       //           .address
  //                                       //           .toString()),
  //                                       //   type: 1,
  //                                       //   status: 2,
  //                                       //   startDate: startDate,
  //                                       //   endDate: endDate,
  //                                       //   // description:
  //                                       //   // "ahihihihihihihihi"
  //                                       // )
  //                                     ));
  //                                     // Navigator.pop(context);
  //                                     // Navigator.of(context).push(
  //                                     //   MaterialPageRoute(
  //                                     //       builder: (context) =>
  //                                     //           const CustomNavBar()),
  //                                     // );
  //                                     // AppFormat.showSnackBar(
  //                                     //     context, 1, "Tạo thành công");

  //                                     // Timer(const Duration(milliseconds: 800),
  //                                     //     () {
  //                                     //   Navigator.of(context)
  //                                     //       .pushAndRemoveUntil(
  //                                     //     MaterialPageRoute(
  //                                     //         builder: (context) =>
  //                                     //             const CustomNavBar()),
  //                                     //     (route) => false,
  //                                     //   );
  //                                     // });

  //                                     // if (time1 || time2 || time3) {
  //                                     //   setState(() {
  //                                     //     isChooseTime = true;
  //                                     //   });
  //                                     //   BlocProvider.of<AppointmentBloc>(context).add(UpdateAppointmentRequested(
  //                                     //       Appointment(
  //                                     //           id: widget.appointment.id,
  //                                     //           brand: widget
  //                                     //               .appointment.brand,
  //                                     //           brandFreeTime1: widget
  //                                     //               .appointment
  //                                     //               .brandFreeTime1,
  //                                     //           brandFreeTime2: widget
  //                                     //               .appointment
  //                                     //               .brandFreeTime2,
  //                                     //           brandFreeTime3: widget
  //                                     //               .appointment
  //                                     //               .brandFreeTime3,
  //                                     //           brandId: widget
  //                                     //               .appointment.brandId,
  //                                     //           brokerId: widget
  //                                     //               .appointment.brokerId,
  //                                     //           createDateTime: widget
  //                                     //               .appointment
  //                                     //               .createDateTime,
  //                                     //           properties: widget
  //                                     //               .appointment.properties,
  //                                     //           slot:
  //                                     //               widget.appointment.slot,
  //                                     //           status: 2,
  //                                     //           description: widget
  //                                     //               .appointment
  //                                     //               .description,
  //                                     //           onDateTime: time1
  //                                     //               ? widget.appointment.brandFreeTime1
  //                                     //               : time2
  //                                     //                   ? widget.appointment.brandFreeTime2
  //                                     //                   : widget.appointment.brandFreeTime3)));

  //                                     // context
  //                                     //     .read<AppointmentConfirmBloc>()
  //                                     //     .add(GetAppointmentConfirm());

  //                                     // context.read<AppointmentBloc>().add(
  //                                     //     const GetAppointmentRequested(
  //                                     //         1, "", true));
  //                                     // setState(() {});
  //                                     // Navigator.pop(context);
  //                                     // }
  //                                     // else {
  //                                     //   setState(() {
  //                                     //     isChooseTime = false;
  //                                     //   });
  //                                     // }
  //                                   },
  //                                   style: ButtonStyle(
  //                                       foregroundColor:
  //                                           MaterialStateProperty.all<Color>(
  //                                               Colors.white),
  //                                       backgroundColor:
  //                                           MaterialStateProperty.all<Color>(
  //                                               AppColor.primaryColor),
  //                                       shape: MaterialStateProperty.all(
  //                                           RoundedRectangleBorder(
  //                                         borderRadius:
  //                                             BorderRadius.circular(10),
  //                                       ))),
  //                                   child: Text('Xác nhận',
  //                                       style: TxtStyle.heading4
  //                                           .copyWith(color: Colors.white))),
  //                             )
  //                           ],
  //                         ))
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

}
