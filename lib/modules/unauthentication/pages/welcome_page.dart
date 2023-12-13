import 'package:crel_mobile/common/widgets/stateful/custom_nav_bar.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/modules/authentication/blocs/authentication_bloc.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_required_username.dart';
import 'package:crel_mobile/modules/unauthentication/widgets/custom_text_form_field_password_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = true;
  // bool _isUnauthorize = true;

  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Bạn có muốn thoát khỏi ứng dụng?',
                style: TxtStyle.heading3,
              ),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text('Không'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: const Text('Có'),
                    ),
                  ],
                )
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            // if (state is Authenticated) {
            //   // Navigating to the dashboard screen if the user is authenticated
            //   Navigator.pushReplacement(context,
            //       MaterialPageRoute(builder: (context) => const CustomNavBar()));
            // }
            if (state is AuthenticatedError) {
              // setState(() {
              //   _isUnauthorize = false;
              // });
              // Showing the error message if the user has entered invalid credentials
              // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //     content: Text(
              //         "Tài khoản hoặc mật khẩu không đúng. Vui lòng kiểm tra lại!")));
              AppFormat.showSnackBar(context, 0,
                  "Tài khoản hoặc mật khẩu không đúng. Vui lòng kiểm tra lại!");
            }
            // if (state is LoginSuccessed) {
            //   AppFormat.showSnackBar(context, 1, "Đăng nhập thành công");
            // }

            if (state is LoginFirstTime) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRouter.changePasswordPageFirst,
                (route) => false,
              );
            }
          },
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            // buildWhen: (previous, current) =>
            //     previous != current && current is UnAuthenticated,
            builder: (context, state) {
              if (state is Loading || state is LoginFirstTime) {
                // Showing the loading indicator while the user is signing in
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is UnAuthenticated) {
                // Showing the sign in form if the user is not authenticated
                return GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: Center(
                    child: SingleChildScrollView(
                      reverse: true,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Container(
                              width: 160,
                              height: 160,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(AppAssets.logo))),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            // const Icon(
                            //   Icons.home,
                            //   size: 200,
                            // ),
                            const Text("Chào mừng đến với CREL",
                                style: TxtStyle.heading1),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  CustomTFFRequiredUsername(
                                    type: TextInputType.name,
                                    textController: _usernameController,
                                    name: "Tài khoản",
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  CustomTextFormFieldPasswordLogin(
                                    type: TextInputType.name,
                                    hide: _passwordVisible,
                                    fun: _toggle,
                                    textController: _passwordController,
                                    name: "Mật khẩu",
                                  ),
                                  const SizedBox(
                                    height: 32,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 51,
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                style: TxtStyle.buttonBlue,
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  _authenticateWithEmailAndPassword(context);
                                },
                                child: Text(
                                  'Đăng nhập',
                                  style: TxtStyle.heading3
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            GestureDetector(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                Navigator.pushNamed(
                                    context, AppRouter.forgetPasswordPage);
                              },
                              child: Text("Quên mật khẩu?",
                                  style: TxtStyle.heading3
                                      .copyWith(color: AppColor.primaryColor)),
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.pushNamed(context, AppRouter.signUpPage);
                            //   },
                            //   child: Text("Đăng ký?",
                            //       style: TxtStyle.heading3
                            //           .copyWith(color: AppColor.primaryColor)),
                            // )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              if (state is Authenticated) {
                return const CustomNavBar();
              }
              return const Text("Something went wrong");
            },
          ),
        ),
      ),
    );
  }

  void _authenticateWithEmailAndPassword(context) async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      // prefs.setString("userName", _emailController.text);
      prefs.setString("password", _passwordController.text);
      BlocProvider.of<AuthenticationBloc>(context).add(
        SignInRequested(
            _usernameController.text.toLowerCase(), _passwordController.text),
      );
    }
  }
}
