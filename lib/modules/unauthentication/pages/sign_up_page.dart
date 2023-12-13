import 'package:crel_mobile/config/text_style.dart';
import 'package:crel_mobile/modules/unauthentication/widgets/custom_text_form_field_valid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Đăng ký")),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormFieldValid(
                textController: _emailController,
                name: "Email",
                error: "Vui lòng nhập tối thiểu 6 kí tự.",
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextFormFieldValid(
                textController: _passwordController,
                name: "Mật khẩu",
                error: "Vui lòng nhập tối thiểu 6 kí tự.",
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextFormFieldValid(
                textController: _confirmPasswordController,
                name: "Xác nhận mật khẩu",
                error: "Vui lòng nhập tối thiểu 6 kí tự.",
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextFormFieldValid(
                textController: _nameController,
                name: "Họ và tên",
                error: "Vui lòng nhập tối thiểu 6 kí tự.",
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextFormFieldValid(
                textController: _phoneController,
                name: "Số điện thoại",
                error: "Vui lòng nhập tối thiểu 6 kí tự.",
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 51,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: TxtStyle.buttonBlue,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      verifyEmail();
                    }
                  },
                  child: Text(
                    'Đổi mật khẩu',
                    style: TxtStyle.heading3.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future verifyEmail() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      if (_passwordController.text == _confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text..toLowerCase().trim(),
            password: _passwordController.text.trim());

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Tạo tài khoản thành công")));
        print("ấdasdadasdasdas");
        Navigator.of(context).popUntil(((route) => route.isFirst));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Không trùng với mật khẩu")));
        Navigator.of(context).popUntil(((route) => route.isFirst));
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
      Navigator.of(context).pop();
    }
  }
}
