import 'package:cached_network_image/cached_network_image.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/project.dart';
import 'package:crel_mobile/modules/mission/blocs/project/project_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ProjectDetail extends StatelessWidget {
  const ProjectDetail({
    Key? key,
    required this.project,
    //  required this.districtId,
    // required this.projectId
  }) : super(key: key);
  final Project project;
  // final int districtId;
  // final int projectId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          centerTitle: true,
          title: const Text(
            "Chi tiết dự án",
            style: TxtStyle.textAppBar,
          )),
      body: SafeArea(
          child: BlocConsumer<ProjectBloc, ProjectState>(
        listener: (context, state) {
          if (state is ProjectError ||
              state is ProjectLoaded ||
              state is ListProjectLoaded) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("ProjectError")));
          }
        },
        builder: (context, state) {
          if (state is ProjectLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProjectIdLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    height: 250,
                    width: AppFormat.width(context),
                    fit: BoxFit.cover,
                    imageUrl: state.project.media!.isEmpty
                        ? "https://www.savills.com.vn/_images/thaibuilding-20190911.jpg"
                        : state.project.media![0].link.toString(),
                    // placeholder: (context, url) =>
                    //     const CircularProgressIndicator(),
                    // errorWidget: (context, url, error) =>
                    //     const Icon(Icons.error),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.project.name.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TxtStyle.heading2,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/address.svg',
                              // height: 250,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              "Quận 9, TP. Hồ Chí Minh"
                              //  AppFormat.getAddress(state.project.)
                              ,
                              style: TxtStyle.heading4,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // const Icon(Icons.location_city),
                            // const SizedBox(
                            //   width: 5,
                            // ),
                            Text(
                              "Chủ đầu tư: " + state.project.company.toString()
                              //  AppFormat.getAddress(state.project.)
                              ,
                              style: TxtStyle.heading4,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // const Icon(Icons.location_city),
                            // const SizedBox(
                            //   width: 5,
                            // ),
                            Text(
                              "Năm bàn giao: " +
                                  AppFormat.parseYear(
                                      state.project.handoverYear.toString())
                              //  AppFormat.getAddress(state.project.)
                              ,
                              style: TxtStyle.heading4,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Thông tin chi tiết',
                          style: TxtStyle.heading4
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        // Text(
                        //   state.project.description.toString(),
                        //   style: TxtStyle.heading4.copyWith(
                        //     color: AppColor.primaryColor,
                        //   ),
                        // ),
                        HtmlWidget(
                          state.project.description.toString(),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return Text("$state");
          // return BlocConsumer<DistrictBloc, DistrictState>(
          //   listener: (context, state1) {},
          //   builder: (context, state1) {
          //     if (state is ProjectLoaded && state1 is DistrictByIDLoaded) {

          //     }
          //     return const Center(
          //       child: CircularProgressIndicator(),
          //     );
          //   },
          // );

          // if (state is ProjectLoading) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
          // if (state is ProjectLoaded) {
          //   return BlocConsumer<DistrictBloc, DistrictState>(
          //     listener: (context, state1) {
          //       // TODO: implement listener
          //     },
          //     builder: (context, state1) {
          //       if (state1 is DistrictLoaded) {
          //         return SingleChildScrollView(
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               CachedNetworkImage(
          //                 height: 250,
          //                 width: AppFormat.width(context),
          //                 fit: BoxFit.cover,
          //                 imageUrl:
          //                     "https://www.savills.com.vn/_images/thaibuilding-20190911.jpg",
          //                 placeholder: (context, url) =>
          //                     const CircularProgressIndicator(),
          //                 errorWidget: (context, url, error) =>
          //                     const Icon(Icons.error),
          //               ),
          //               const SizedBox(
          //                 height: 16,
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.symmetric(horizontal: 16),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text(
          //                       state.project.name!,
          //                       maxLines: 2,
          //                       overflow: TextOverflow.ellipsis,
          //                       style: TxtStyle.heading2,
          //                     ),
          //                     const SizedBox(
          //                       height: 8,
          //                     ),
          //                     Row(
          //                       mainAxisAlignment: MainAxisAlignment.start,
          //                       children: [
          //                         const Icon(Icons.location_city),
          //                         const SizedBox(
          //                           width: 5,
          //                         ),
          //                         Text(
          //                           state1.district.name!,
          //                           style: TxtStyle.heading4.copyWith(
          //                             color: AppColor.primaryColor,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                     const SizedBox(
          //                       height: 8,
          //                     ),
          //                     Text(
          //                       'Thông tin chi tiết',
          //                       style: TxtStyle.heading4
          //                           .copyWith(fontWeight: FontWeight.bold),
          //                     ),
          //                     const SizedBox(
          //                       height: 8,
          //                     ),
          //                     Text(
          //                       state.project.description.toString(),
          //                       style: TxtStyle.heading4.copyWith(
          //                         color: AppColor.primaryColor,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //         );
          //       }
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     },
          //   );
          // }
          // return Text("$state");
        },
      )),
    );
  }
}
