import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/modules/profile/blocs/profile/profile_bloc.dart';
import 'package:crel_mobile/modules/profile/widgets/view_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewProfilePage extends StatelessWidget {
  const ViewProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Thông tin cá nhân",
            style: TxtStyle.textAppBar,
          ),
          centerTitle: true,
          backgroundColor: AppColor.primaryColor,
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
          actions: [
            IconButton(
                splashRadius: 24,
                padding: const EdgeInsets.all(0.0),
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRouter.editProfile,
                  );
                },
                icon: SvgPicture.asset(
                  'assets/icons/edit.svg',
                  color: Colors.white,
                )),
            const SizedBox(width: 8)
          ],
        ),
        body: SafeArea(
          child: Container(
            color: AppColor.backgroundColor,
            child: BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.error)));
                }
              },
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ProfileLoaded) {
                    return ViewProfile(
                      // formKey: _formKey,
                      user: state.user,
                      // nameController: _nameController,
                      // emailController: _emailController,
                      // phoneController: _phoneController,
                      // birthdayController: _birthdayController
                    );
                  }
                  // if (state is FaildSaveUser) {
                  //   return EditProfile(
                  //     // formKey: _formKey,
                  //     user: state.user,

                  //     // nameController: _nameController,
                  //     // emailController: _emailController,
                  //     // phoneController: _phoneController,
                  //     // birthdayController: _birthdayController
                  //   );
                  // }
                  return Text(state.toString());
                },
              ),
            ),
          ),
        )
        // ),
        );
  }
}
