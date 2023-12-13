import 'dart:async';

import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/modules/profile/blocs/profile/profile_bloc.dart';
import 'package:crel_mobile/modules/unauthentication/widgets/custom_text_form_field_valid_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text(
          "Đặt lại mật khẩu",
          style: TxtStyle.textAppBar,
        ),
        leading: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            'assets/icons/arrow-left.svg',
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: AppColor.backgroundColor,
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ResetPasswordError) {
                AppFormat.showSnackBar(context, 0,
                    "Email không tồn tại trong hệ thống. Vui lòng kiểm tra lại!");
              }

              if (state is SuccessSendEmail) {
                AppFormat.showSnackBar(context, 1,
                    "Đã gửi mật khẩu vào email của bạn. Vui lòng kiểm tra!");

                Timer(const Duration(milliseconds: 800), () {
                  Navigator.pushNamed(context, AppRouter.welcomePage);
                });
              }
            },
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return Column(
                  children: [
                    const SizedBox(),
                    Expanded(
                      child: SingleChildScrollView(
                        // reverse: true,
                        child: Form(
                            key: formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 36,
                                  ),
                                  Container(
                                    width: 200,
                                    height: 200,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(AppAssets
                                                .emailForgetPassword))),
                                  ),
                                  const SizedBox(
                                    height: 36,
                                  ),
                                  Text(
                                    "Nhập email để đặt lại mật khẩu của bạn.",
                                    style: TxtStyle.heading3
                                        .copyWith(color: AppColor.textColor),
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  CustomTextFormFieldEmail(
                                    isDisable: false,
                                    type: TextInputType.emailAddress,
                                    textController: emailController,
                                    name: "Email",
                                  ),
                                  const SizedBox(
                                    height: 32,
                                  ),

                                  SizedBox(
                                    height: 51,
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                      style: TxtStyle.buttonBlue,
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          context.read<ProfileBloc>().add(
                                              ResetPassword(emailController.text
                                                  .toLowerCase()));
                                        }
                                      },
                                      child: Text(
                                        'Khôi phục',
                                        style: TxtStyle.heading3
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  // ElevatedButton.icon(
                                  //   icon: const Icon(Icons.email),
                                  //   style: ElevatedButton.styleFrom(
                                  //       minimumSize: const Size.fromHeight(50)),
                                  //   onPressed: () {
                                  //     if (formKey.currentState!.validate()) {
                                  //       verifyEmail();
                                  //     }
                                  //   },
                                  //   label: Text(
                                  //     "Đặt lại mật khẩu.",
                                  //     style: AppStyles.h2.copyWith(color: Colors.black),
                                  //   ),
                                  // )
                                  const SizedBox(
                                    height: 300,
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // Future verifyEmail() async {
  //   showDialog(
  //       context: context,
  //       builder: (context) => const Center(
  //             child: CircularProgressIndicator(),
  //           ));
  //   try {
  //     await FirebaseAuth.instance
  //         .sendPasswordResetEmail(email: emailController.text.trim());

  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text("Đã gửi email")));
  //     Navigator.of(context).popUntil(((route) => route.isFirst));
  //   } on FirebaseAuthException catch (e) {
  //     print(e);
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text(e.message.toString())));
  //     Navigator.of(context).pop();
  //   }
  // }
}
