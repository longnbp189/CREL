import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/modules/profile/blocs/profile/profile_bloc.dart';
import 'package:crel_mobile/modules/profile/widgets/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Chỉnh sửa thông tin cá nhân",
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
                // height: 250,
              ),
            ),
            centerTitle: true,
            backgroundColor: AppColor.primaryColor),
        body: SafeArea(
          child: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.error)));
              }
              if (state is SuccessSaveUser) {
                AppFormat.showSnackBar(
                    context, 1, "Cập nhật thông tin thành công");
                Navigator.pop(context);
              }
              if (state is FaildSaveUser) {
                AppFormat.showSnackBar(
                    context, 0, "Cập nhật thông tin không thành công");
                context.read<ProfileBloc>().add(GetProfileRequested());
              }
            },
            child: BlocBuilder<ProfileBloc, ProfileState>(
              buildWhen: (previous, current) =>
                  previous != current && current is ProfileLoaded,
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ProfileLoaded) {
                  return EditProfile(
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
        )
        // ),
        );
  }
}
