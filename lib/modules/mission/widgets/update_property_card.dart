import 'package:crel_mobile/common/widgets/stateless/container_boder.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:flutter/material.dart';

class UpdatePropertyCard extends StatelessWidget {
  final Property propertyForRent;
  // final String location;

  const UpdatePropertyCard({
    Key? key,
    required this.propertyForRent,
    //  required this.location
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ContainerBoder(
        boder: 10,
        width: 1,
        colorWidth: AppColor.boderColor,
        colorContainer: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Thông tin chủ sở hữu:",
                style: TxtStyle.heading4.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              // (propertyForRent.contacts == null)
              //     ? const Text("contact error")
              //     :
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(propertyForRent.contacts![0].name!),
              //       Text(
              //         propertyForRent.contacts![0].phoneNumber!,
              //         style: TxtStyle.heading4.copyWith(
              //             color: Colors.black, fontWeight: FontWeight.bold),
              //       )
              //     ],
              //   ),
              // ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: propertyForRent.owners!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(propertyForRent.owners![index].name!),
                            Text(
                              AppFormat.phoneFormat(propertyForRent
                                  .owners![index].phoneNumber
                                  .toString()),
                              style: TxtStyle.heading4.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ));
                  }),

              // RichText(
              //   text: TextSpan(
              //       text: "Mặt bằng: ",
              //       style: TxtStyle.heading4.copyWith(
              //           color: Colors.black, fontWeight: FontWeight.bold),
              //       children: [
              //         TextSpan(
              //           text: 'Mặt bằng 2 tầng Nguyễn Công Trứ',
              //           style: TxtStyle.heading4.copyWith(
              //               color: Colors.black, fontWeight: FontWeight.normal),
              //         ),
              //       ]),
              // ),
              // const SizedBox(
              //   height: 8,
              // ),
              // BlocConsumer<LocationBloc, LocationState>(
              //   listener: (context, state) {
              //     if (state is LocationError) {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //           const SnackBar(content: Text("LocationError")));
              //     }
              //   },
              //   builder: (context, state) {
              //     if (state is LocationLoading) {
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     }
              //     if (state is LocationLoaded) {
              //       return
              RichText(
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                text: TextSpan(
                    text: "Địa chỉ: ",
                    style: TxtStyle.heading4.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: AppFormat.getAddress(propertyForRent),
                        style: TxtStyle.heading4.copyWith(
                            color: Colors.black, fontWeight: FontWeight.normal),
                      ),
                    ]),
              )
              //     }
              //     return Text("$state");
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
