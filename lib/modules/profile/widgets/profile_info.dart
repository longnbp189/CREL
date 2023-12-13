import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:crel_mobile/modules/appointment/blocs/contract/contract_bloc.dart';
import 'package:crel_mobile/modules/authentication/blocs/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({Key? key, required this.size, required this.user})
      : super(key: key);

  final Size size;
  final Broker user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 32),
                child: Container(
                  width: AppFormat.width(context),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColor.boderColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 32),
                    child: Column(
                      children: [
                        Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            // color: const Color(0xff7c94b6),
                            image: DecorationImage(
                              image: user.avatarLink == null
                                  ? const NetworkImage(
                                      "https://static.wikia.nocookie.net/bleach/images/1/16/Hitsugayatoshiro.png/revision/latest?cb=20111020043210&path-prefix=vi")
                                  : NetworkImage(user.avatarLink!.toString()),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50.0)),
                            // border: Border.all(
                            //   color: Colors.black,
                            //   width: 1.0,
                            // ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          user.name!,
                          style: TxtStyle.heading2.copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          user.email!,
                          style: TxtStyle.heading4.copyWith(
                              color: AppColor.textColor, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          AppFormat.phoneFormat(user.phoneNumber.toString()),
                          style: TxtStyle.heading4.copyWith(
                              color: AppColor.textColor, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            // flex: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 51,
                  width: size.width,
                  child: ElevatedButton(
                    style: TxtStyle.buttonGray.copyWith(),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRouter.viewProfile);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/user.svg',
                        ),
                        // const Icon(
                        //   Icons.person,
                        //   color: AppColor.secondColor,
                        // ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          'Thông tin cá nhân',
                          style: TxtStyle.heading3
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),

                SizedBox(
                  height: 51,
                  width: size.width,
                  child: ElevatedButton(
                    style: TxtStyle.buttonGray,
                    onPressed: () => Navigator.pushNamed(
                        context, AppRouter.changePasswordPage),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/change-password-icon.svg',
                          height: 24,
                          color: const Color.fromARGB(255, 71, 71, 71),
                        ),
                        // const Icon(
                        //   Icons.password,
                        //   color: AppColor.secondColor,
                        // ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          'Thay đổi mật khẩu',
                          style: TxtStyle.heading3
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 51,
                  width: size.width,
                  child: ElevatedButton(
                    style: TxtStyle.buttonGray.copyWith(),
                    onPressed: () {
                      context.read<ContractBloc>().add(SearchContractByMonth(
                          AppFormat.startDayOfMonth(
                              AppFormat.getYearAndMonthNow()),
                          AppFormat.endDayOfMonth(
                              AppFormat.getYearAndMonthNow()),
                          true));
                      Navigator.pushNamed(context, AppRouter.contractPage);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/contract.svg',
                          height: 24,
                          // color: AppColor.secondColor,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          'Hợp đồng',
                          style: TxtStyle.heading3
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 51,
                  width: size.width,
                  child: ElevatedButton(
                    style: TxtStyle.buttonGray.copyWith(),
                    onPressed: () {
                      _logout(context);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/logout.svg',
                          height: 24,
                          // color: AppColor.secondColor,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          'Đăng xuất',
                          style: TxtStyle.heading3
                              .copyWith(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
                // const SizedBox(
                //   height: 12,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _logout(context) {
    BlocProvider.of<AuthenticationBloc>(context).add(SignOutRequested());
  }
}
