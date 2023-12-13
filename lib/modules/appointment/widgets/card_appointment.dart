import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/appointmentt.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardAppointment extends StatelessWidget {
  const CardAppointment({
    Key? key,
    required this.size,
    required this.appointmentt,
  }) : super(key: key);

  final Size size;
  // final int index;
  final Appointmentt appointmentt;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DottedBorder(
        radius: const Radius.circular(10),
        borderType: BorderType.RRect,
        color: AppColor.primaryColor,
        strokeWidth: 2,
        dashPattern: const [16, 8],
        child: Container(
          height: size.height / 2,
          width: size.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.cardColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Row(
                      children: [
                        // AvatarAppointment(
                        //     size: size * 1.2, avatar: appointmentt.avatar),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          appointmentt.name,
                          style: TxtStyle.heading2,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 16),
                      child: Row(children: [
                        const Icon(
                          Icons.branding_watermark,
                          color: AppColor.secondColor,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          "Highland Coffee",
                          style: TxtStyle.heading3
                              .copyWith(fontWeight: FontWeight.normal),
                        )
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 16),
                      child: Row(children: [
                        const FaIcon(
                          FontAwesomeIcons.calendar,
                          color: AppColor.secondColor,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          appointmentt.date,
                          style: TxtStyle.heading3
                              .copyWith(fontWeight: FontWeight.normal),
                        )
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 16),
                      child: Row(children: [
                        const FaIcon(
                          FontAwesomeIcons.clock,
                          color: AppColor.secondColor,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          appointmentt.hour,
                          style: TxtStyle.heading3
                              .copyWith(fontWeight: FontWeight.normal),
                        )
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 16),
                      child: Row(children: [
                        const FaIcon(
                          FontAwesomeIcons.phone,
                          color: AppColor.secondColor,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          appointmentt.telephone,
                          style: TxtStyle.heading3
                              .copyWith(fontWeight: FontWeight.normal),
                        )
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 16),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.building,
                              color: AppColor.secondColor,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Text(
                                appointmentt.propertyName,
                                style: TxtStyle.heading3
                                    .copyWith(fontWeight: FontWeight.normal),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 16),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.locationDot,
                              color: AppColor.secondColor,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Text(
                                appointmentt.address,
                                style: TxtStyle.heading3
                                    .copyWith(fontWeight: FontWeight.normal),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ]),
                    ),
                  ],
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 5,
                      child: ElevatedButton(
                          // icon: const FaIcon(
                          //   FontAwesomeIcons.xmark,
                          //   size: 24,
                          // ),
                          onPressed: () {},
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColor.primaryColor),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))),
                          child: Text('Gọi ngay',
                              style: TxtStyle.heading4
                                  .copyWith(color: Colors.white))),
                    ),
                    const Expanded(child: SizedBox()),
                    Expanded(
                      flex: 5,
                      child: ElevatedButton(
                          // icon: const FaIcon(
                          //   FontAwesomeIcons.check,
                          //   size: 24,
                          // ),
                          onPressed: () {},
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColor.primaryColor),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))),
                          child: Text('Đổi lịch hẹn',
                              style: TxtStyle.heading4
                                  .copyWith(color: Colors.white))),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
