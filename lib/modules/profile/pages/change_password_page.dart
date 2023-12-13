import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/modules/profile/blocs/profile/profile_bloc.dart';
import 'package:crel_mobile/modules/unauthentication/widgets/custom_text_form_field_password.dart';
import 'package:crel_mobile/modules/unauthentication/widgets/custom_text_form_field_password_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _oldPasswordVisible = true;
  bool _newPasswordVisible = true;
  bool _confirmPasswordVisible = true;
  // final bool _isUnauthorize = true;

  void _toggle() {
    setState(() {
      _oldPasswordVisible = !_oldPasswordVisible;
    });
  }

  void _toggle1() {
    setState(() {
      _newPasswordVisible = !_newPasswordVisible;
    });
  }

  void _toggle2() {
    setState(() {
      _confirmPasswordVisible = !_confirmPasswordVisible;
    });
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Thay đổi mật khẩu",
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
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Container(
              color: AppColor.backgroundColor,
              child: BlocListener<ProfileBloc, ProfileState>(
                listener: (context, state) {
                  if (state is SuccessChangePassword) {
                    AppFormat.showSnackBar(
                        context, 1, "Đổi mật khẩu thành công");
                    _saveNewPassword(context);
                    Navigator.pop(context);
                  }
                },
                child: Column(
                  children: [
                    const SizedBox(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                              child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 36,
                                      ),
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    AppAssets.resetPassword))),
                                      ),
                                      const SizedBox(
                                        height: 36,
                                      ),
                                      // const Align(
                                      //   alignment: Alignment.centerLeft,
                                      //   child: Text(
                                      //     "Nhập mật khẩu cũ",
                                      //     style: TxtStyle.heading3,
                                      //   ),
                                      // ),
                                      // const SizedBox(
                                      //   height: 8,
                                      // ),
                                      CustomTextFormFieldPasswordLogin(
                                        type: TextInputType.name,
                                        hide: _oldPasswordVisible,
                                        fun: _toggle,
                                        textController: _oldPasswordController,
                                        name: "Mật khẩu cũ",
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      // const Align(
                                      //   alignment: Alignment.centerLeft,
                                      //   child: Text(
                                      //     "Nhập mật khẩu mới",
                                      //     style: TxtStyle.heading3,
                                      //   ),
                                      // ),
                                      // const SizedBox(
                                      //   height: 8,
                                      // ),
                                      CustomTextFormFieldPassword(
                                        type: TextInputType.name,
                                        hide: _newPasswordVisible,
                                        fun: _toggle1,
                                        textController: _newPasswordController,
                                        name: "Mật khẩu mới",
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      // const Align(
                                      //   alignment: Alignment.centerLeft,
                                      //   child: Text(
                                      //     "Xác nhận lại khẩu mới",
                                      //     style: TxtStyle.heading3,
                                      //   ),
                                      // ),
                                      // const SizedBox(
                                      //   height: 8,
                                      // ),
                                      CustomTextFormFieldPassword(
                                        type: TextInputType.name,
                                        hide: _confirmPasswordVisible,
                                        fun: _toggle2,
                                        textController:
                                            _confirmPasswordController,
                                        name: "Mật khẩu xác nhận",
                                      ),
                                      const SizedBox(
                                        height: 32,
                                      ),
                                      SizedBox(
                                        height: 51,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ElevatedButton(
                                          style: TxtStyle.buttonBlue,
                                          onPressed: () async {
                                            final prefs =
                                                await SharedPreferences
                                                    .getInstance();

                                            if (_formKey.currentState!
                                                .validate()) {
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                              // if (_oldPasswordController.text.trim() ==
                                              //     prefs.getString("password")) {
                                              //   if (_oldPasswordController.text
                                              //           .trim() !=
                                              //       _newPasswordController.text
                                              //           .trim()) {
                                              //     if (_newPasswordController.text
                                              //             .trim() ==
                                              //         _confirmPasswordController.text
                                              //             .trim()) {
                                              //       BlocProvider.of<ProfileBloc>(
                                              //               context)
                                              //           .add(UpdatePassword(
                                              //               _newPasswordController.text
                                              //                   .trim(),
                                              //               _oldPasswordController.text
                                              //                   .trim()));
                                              if (_oldPasswordController.text ==
                                                  prefs.getString("password")) {
                                                if (_oldPasswordController
                                                        .text !=
                                                    _newPasswordController
                                                        .text) {
                                                  if (_newPasswordController
                                                          .text ==
                                                      _confirmPasswordController
                                                          .text) {
                                                    BlocProvider.of<
                                                                ProfileBloc>(
                                                            context)
                                                        .add(UpdatePassword(
                                                            _newPasswordController
                                                                .text,
                                                            _oldPasswordController
                                                                .text));
                                                  } else {
                                                    AppFormat.showSnackBar(
                                                        context,
                                                        0,
                                                        "Xác nhận mật khẩu không đúng");
                                                  }
                                                } else {
                                                  AppFormat.showSnackBar(
                                                      context,
                                                      0,
                                                      "Mật khẩu mới không được trùng mật khẩu cũ");
                                                }
                                              } else {
                                                AppFormat.showSnackBar(
                                                    context,
                                                    0,
                                                    "Mật khẩu cũ không đúng");
                                              }
                                            }
                                          },
                                          child: Text(
                                            'Đổi mật khẩu',
                                            style: TxtStyle.heading3
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      // const SizedBox(
                                      //   height: 270,
                                      // )
                                      // const Expanded(child: SizedBox())
                                    ],
                                  ))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void _saveNewPassword(context) async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("password", _newPasswordController.text);
    }
  }

  // Future resetPassword() async {
  //   showDialog(
  //       context: context,
  //       builder: (context) => const Center(
  //             child: CircularProgressIndicator(),
  //           ));
  //   try {
  //     var user = FirebaseAuth.instance.currentUser;
  //     final prefs = await SharedPreferences.getInstance();
  //     String? oldPassword = prefs.getString("password");
  //     String newPassword = _newPasswordController.text;
  //     if (oldPassword == _oldPasswordController.text) {
  //       await user!.updatePassword(newPassword).then((_) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(content: Text("Đổi mật khật thành công.")));
  //         _logout(context);
  //       }).catchError((error) {
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //             content: Text("Không thể đổi mật khẩu" + error.toString())));
  //       });
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text("Mật khẩu cũ không đúng.")));
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text(e.message.toString())));
  //     Navigator.of(context).pop();
  //   }
  // }

  // void _logout(context) {
  //   BlocProvider.of<AuthenticationBloc>(context).add(SignOutRequested());
  // }
}
