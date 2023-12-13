import 'package:crel_mobile/common/widgets/stateful/custom_tab_bar_home.dart';
import 'package:crel_mobile/config/app_color.dart';
import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
import 'package:crel_mobile/modules/home/repos/property_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PropertyForRentBloc>(
      create: (context) => PropertyForRentBloc(
        propertyForRentRepo: RepositoryProvider.of<PropertyRepo>(context),
      ),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          color: AppColor.backgroundColor,
          child: Column(
            children: const [
              // MultiBlocListener(
              //   listeners: [
              //     BlocListener<ProfileBloc, ProfileState>(
              //       listener: (context, state) {
              //         if (state is ProfileLoaded) {
              //           setState(() {
              //             st2 = true;
              //           });
              //         }
              //         if (state is ProfileError) {
              //           Navigator.of(context).pushAndRemoveUntil(
              //             MaterialPageRoute(
              //                 builder: (context) => const WelcomePage()),
              //             (route) => false,
              //           );
              //           ScaffoldMessenger.of(context).showSnackBar(
              //               const SnackBar(content: Text("ProfileError")));
              //         }
              //       },
              //     ),
              //     BlocListener<PropertyForRentBloc, PropertyForRentState>(
              //       listener: (context, state) {
              //         if (state is PropertyForRentLoaded) {
              //           setState(() {
              //             st1 = true;
              //           });
              //         }
              //       },
              //     ),
              //   ],
              //   child: (st1 && st2)
              //       ? BlocBuilder<ProfileBloc, ProfileState>(
              //           builder: (context, state) {
              //             if (state is ProfileLoading) {
              //               return const Center(
              //                 child: CircularProgressIndicator(),
              //               );
              //             }
              //             if (state is ProfileLoaded) {
              //               return HeaderHome(
              //                 name: state.user.name!,
              //               );
              //             } else {
              //               return Container(color: AppColor.boderColor);
              //             }
              //           },
              //         )
              //       : const Center(
              //           child: CircularProgressIndicator(),
              //         ),
              // ),
              // HeaderHome(),
              SizedBox(
                height: 16,
              ),
              Expanded(child: CustomTabBarHome())
            ],
          ),
        ),
      ),
    );
  }
}
