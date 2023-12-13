import 'dart:io';

import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:crel_mobile/modules/mission/widgets/choose_text_from_drop.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_no_event.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_required_m.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_required_phone.dart';
import 'package:crel_mobile/modules/profile/blocs/profile/profile_bloc.dart';
import 'package:crel_mobile/modules/unauthentication/widgets/custom_text_form_field_valid_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  final Broker user;
  const EditProfile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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

  File? image;

  List<String> listGenger = AppFormat.getListGender();
  String? selectedItem;

  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    Future.delayed(const Duration(seconds: 1));
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        print("sadasd");
      } else {
        print('No image selected.');
      }
    });
  }

  Future pickDate(BuildContext context) async {
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
      birthday = chooseDate;
    });
  }

  DateTime? birthday;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        color: AppColor.backgroundColor,
        child: Column(
          children: [
            const SizedBox(),
            Expanded(
              child: SingleChildScrollView(
                // reverse: true,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          getImage();
                        },

                        // child: (image != null) ? Avatar(
                        //   avatarUrl: ,
                        // ) : Avatar(
                        //   avatarUrl: widget.user.media!.link,
                        //   sizeAvatar: 80,
                        // ),
                        child: Container(
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
                                  image: (image != null)
                                      ? FileImage(image!)
                                      : widget.user.avatarLink == null
                                          ? const NetworkImage(
                                              "https://static.wikia.nocookie.net/bleach/images/1/16/Hitsugayatoshiro.png/revision/latest?cb=20111020043210&path-prefix=vi")
                                          : NetworkImage(widget.user.avatarLink!
                                              .toString()) as ImageProvider,
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Center(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    AppFormat.heightWithoutAppBarAndStatusbar(
                                            context) *
                                        0.04,
                              ),
                              CustomTFFRequiredM(
                                  isDisable: false,
                                  isM: 2,
                                  type: TextInputType.name,
                                  textController: _nameController
                                    ..text = widget.user.name!,
                                  name: "Họ và tên"),
                              SizedBox(
                                height:
                                    AppFormat.heightWithoutAppBarAndStatusbar(
                                            context) *
                                        0.02,
                              ),
                              CustomTextFormFieldEmail(
                                  isDisable: false,
                                  type: TextInputType.emailAddress,
                                  textController: _emailController
                                    ..text = widget.user.email!,
                                  name: "Email"),
                              SizedBox(
                                height:
                                    AppFormat.heightWithoutAppBarAndStatusbar(
                                            context) *
                                        0.02,
                              ),
                              CustomTFFRequiredPhone(
                                  isDisable: false,
                                  type: TextInputType.number,
                                  textController: _phoneController
                                    ..text = AppFormat.phoneFormat(
                                        widget.user.phoneNumber!),
                                  name: "Số điện thoại"),
                              SizedBox(
                                height:
                                    AppFormat.heightWithoutAppBarAndStatusbar(
                                            context) *
                                        0.02,
                              ),

                              InkWell(
                                onTap: () {
                                  pickDate(context);
                                },
                                child:
                                    // Container(
                                    //   width: AppFormat.width(context),
                                    //   height: 52,
                                    //   decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(10),
                                    //       border: Border.all(color: AppColor.textColor)),
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.symmetric(
                                    //         horizontal: 10, vertical: 8),
                                    //     child: Align(
                                    //       alignment: Alignment.centerLeft,
                                    //       child: Text(
                                    //         AppFormat.parseDate(birthday.toString()),
                                    //         maxLines: 2,
                                    //         overflow: TextOverflow.ellipsis,
                                    //         style: TxtStyle.heading4,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    ChooseTextFromDrop(
                                        isDisable: false,
                                        textController: _birthdayController
                                          ..text = AppFormat.parseDate(
                                              birthday.toString()),
                                        lable: "Ngày sinh"),
                              ),
                              // CustomTextFormFieldValidEmpty(
                              //     textController: _birthdayController
                              //       ..text = AppFormat.parseDate(
                              //           widget.user.birthday!.toString()),
                              //     name: "Ngày sinh"),
                              // SizedBox(
                              //   height:
                              //       AppFormat.heightWithoutAppBarAndStatusbar(context) *
                              //           0.02,
                              // ),
                              // CustomTextFormFieldValidEmpty(
                              //     textController: _genderController
                              //       ..text =
                              //           widget.user.gender!.toString().contains("true")
                              //               ? "nam"
                              //               : "nữ",
                              //     name: "Giới tính"),
                              // SizedBox(
                              //   height:
                              //       AppFormat.heightWithoutAppBarAndStatusbar(context) *
                              //           0.1,
                              // ),
                              Stack(
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
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                    top: 9,
                                    child: Container(
                                      color: Colors.transparent,
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

                              SizedBox(
                                height:
                                    AppFormat.heightWithoutAppBarAndStatusbar(
                                            context) *
                                        0.02,
                              ),
                              CustomTFFNoEvent(
                                  // type: TextInputType.emailAddress,

                                  textController: _teamController
                                    ..text = widget.user.team!.name.toString(),
                                  lable: "Nhóm"),
                              // SizedBox(
                              //   height:
                              //       AppFormat.heightWithoutAppBarAndStatusbar(context) *
                              //           0.036,
                              // ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 32, bottom: 16),
                                child: SizedBox(
                                  width: AppFormat.width(context),
                                  child: ElevatedButton(
                                    style: TxtStyle.buttonBlue,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        // Map<String, dynamic> broker = Map<String, dynamic>();
                                        // broker['name'] = _nameController.text.toString();
                                        // broker['id'] = user.id;
                                        // // broker['birthday'] = parseDate1(date.toString());
                                        // broker['email'] = user.email;
                                        // broker['phoneNumber'] =
                                        //     _phoneController.text.toString();
                                        // broker['fireBaseUid'] = user.fireBaseUid;
                                        // broker['avatarLink'] = user.avatarLink;
                                        // broker['status'] = user.status;

                                        BlocProvider.of<ProfileBloc>(context)
                                            .add(UpdateProfile(
                                                Broker(
                                                  id: widget.user.id,
                                                  birthday: birthday,
                                                  gender:
                                                      selectedItem.toString() ==
                                                              "Nam"
                                                          ? false
                                                          : true,
                                                  team: widget.user.team,
                                                  teamId: widget.user.teamId,
                                                  userName:
                                                      widget.user.userName,
                                                  avatarFileId:
                                                      widget.user.avatarFileId,
                                                  avatarLink:
                                                      widget.user.avatarLink,
                                                  // media: widget.user.media,
                                                  // mediaId: widget.user.mediaId,
                                                  email: _emailController.text
                                                      .toLowerCase(),
                                                  name: _nameController.text
                                                      .trim()
                                                      .toString(),
                                                  phoneNumber:
                                                      AppFormat.savePhone(
                                                              _phoneController
                                                                  .text)
                                                          .trim()
                                                          .toString(),
                                                  status: widget.user.status,
                                                ),
                                                image));

                                        // if (image != null) {
                                        // BlocProvider.of<ProfileBloc>(context)
                                        //     .add(UpdateAvatar(image!));
                                        // }

                                        // Future.delayed(const Duration(seconds: 3));

                                        // Navigator.pop(context);
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      child: Text(
                                        'Cập nhật tài khoản',
                                        style: TxtStyle.heading3
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              )
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
      ),
    );
  }
}
