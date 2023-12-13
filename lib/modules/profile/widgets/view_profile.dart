import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:crel_mobile/modules/mission/widgets/choose_text_from_drop.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_no_event.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_required_m.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_required_phone.dart';
import 'package:crel_mobile/modules/unauthentication/widgets/custom_text_form_field_valid_email.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewProfile extends StatefulWidget {
  final Broker user;
  const ViewProfile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _teamController = TextEditingController();
  final _birthdayController = TextEditingController();
  // final _genderController = TextEditingController();
  // final _directionController = TextEditingController();
  // final _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    selectedItem =
        AppFormat.getListGender()[widget.user.gender == false ? 0 : 1];

    birthday = DateTime(widget.user.birthday!.year, widget.user.birthday!.month,
        widget.user.birthday!.day);
  }

  List<String> listGenger = AppFormat.getListGender();
  String? selectedItem;

  DateTime? birthday;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Column(
        children: [
          const SizedBox(
              // height: 8,
              ),
          Expanded(
            child: SingleChildScrollView(
              // reverse: true,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(200),
                          // color: Colors.grey[300],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50.0)),
                          // border: Border.all(
                          //   color: Colors.black,
                          //   width: 1.0,
                          // ),
                          image: DecorationImage(
                              image: widget.user.avatarLink == null
                                  ? const NetworkImage(
                                      "https://static.wikia.nocookie.net/bleach/images/1/16/Hitsugayatoshiro.png/revision/latest?cb=20111020043210&path-prefix=vi")
                                  : NetworkImage(
                                          widget.user.avatarLink!.toString())
                                      as ImageProvider,
                              fit: BoxFit.cover)),
                    ),
                    Center(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: AppFormat.heightWithoutAppBarAndStatusbar(
                                      context) *
                                  0.04,
                            ),
                            IgnorePointer(
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: AppColor.boderColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: CustomTFFRequiredM(
                                    isDisable: true,
                                    isM: 3,
                                    type: TextInputType.name,
                                    textController: _nameController
                                      ..text = widget.user.name!,
                                    name: "Họ và tên"),
                              ),
                            ),
                            SizedBox(
                              height: AppFormat.heightWithoutAppBarAndStatusbar(
                                      context) *
                                  0.02,
                            ),
                            IgnorePointer(
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: AppColor.boderColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: CustomTextFormFieldEmail(
                                    isDisable: true,
                                    type: TextInputType.emailAddress,
                                    textController: _emailController
                                      ..text = widget.user.email!,
                                    name: "Email"),
                              ),
                            ),
                            SizedBox(
                              height: AppFormat.heightWithoutAppBarAndStatusbar(
                                      context) *
                                  0.02,
                            ),
                            IgnorePointer(
                              child: Container(
                                decoration: const BoxDecoration(
                                    // color: AppColor.boderColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: CustomTFFRequiredPhone(
                                    isDisable: true,
                                    type: TextInputType.number,
                                    textController: _phoneController
                                      ..text = AppFormat.phoneFormat(
                                          widget.user.phoneNumber!),
                                    name: "Số điện thoại"),
                              ),
                            ),
                            SizedBox(
                              height: AppFormat.heightWithoutAppBarAndStatusbar(
                                      context) *
                                  0.02,
                            ),

                            ChooseTextFromDrop(
                                isDisable: true,
                                textController: _birthdayController
                                  ..text =
                                      AppFormat.parseDate(birthday.toString()),
                                lable: "Ngày sinh"),

                            IgnorePointer(
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: AppFormat
                                                .heightWithoutAppBarAndStatusbar(
                                                    context) *
                                            0.02,
                                      ),
                                      Container(
                                        // width: AppFormat.width(context),
                                        // height: 42,
                                        decoration: BoxDecoration(
                                            // color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppColor.boderColor,
                                            border: Border.all(
                                                color: AppColor.boderColor)),
                                        child: PopupMenuButton<String>(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          constraints: BoxConstraints(
                                            // minWidth: 2.0 * 56.0,
                                            maxWidth:
                                                AppFormat.width(context) - 20,

                                            // maxWidth: MediaQuery.of(context).size.width,
                                          ),
                                          initialValue: selectedItem,
                                          onSelected: (val) => setState(
                                              () => selectedItem = val),
                                          child: ListTile(
                                            dense: true,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 0),
                                            title: Text(selectedItem!,
                                                style: TxtStyle.heading4),
                                          ),
                                          itemBuilder: (BuildContext context) {
                                            return listGenger
                                                .map(
                                                  (e) => PopupMenuItem<String>(
                                                    value: e,
                                                    child: SizedBox(
                                                      width: AppFormat.width(
                                                          context),
                                                      child: selectedItem == e
                                                          ? Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(e,
                                                                    style: TxtStyle
                                                                        .heading4),
                                                                const FaIcon(
                                                                    FontAwesomeIcons
                                                                        .check)
                                                              ],
                                                            )
                                                          : SizedBox(
                                                              width: AppFormat
                                                                  .width(
                                                                      context),

                                                              // width: 10000,
                                                              child: Text(e,
                                                                  style: TxtStyle
                                                                      .heading4)),
                                                    ),
                                                  ),
                                                )
                                                .toList();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    left: 6,
                                    top: 8,
                                    child: Container(
                                      // color: Colors.white,
                                      color: Colors.transparent,

                                      // color: AppColor.boderColor,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        child: RichText(
                                          text: TextSpan(
                                              text: "Giới tính",
                                              style: TxtStyle.heading3.copyWith(
                                                  color: AppColor.textColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                              children: [
                                                TextSpan(
                                                  text: ' *',
                                                  style: TxtStyle.heading3
                                                      .copyWith(
                                                          color: Colors.red,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: AppFormat.heightWithoutAppBarAndStatusbar(
                                      context) *
                                  0.02,
                            ),
                            CustomTFFNoEvent(
                                // type: TextInputType.emailAddress,

                                textController: _teamController
                                  ..text = widget.user.team != null
                                      ? widget.user.team!.name.toString()
                                      : "Không có",
                                lable: "Nhóm"),
                            // const SizedBox(
                            //   height: 130,
                            // )
                            // SizedBox(
                            //   height:
                            //       AppFormat.heightWithoutAppBarAndStatusbar(context) *
                            //           0.036,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
