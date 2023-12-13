import 'package:crel_mobile/config/app_color.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/text_style.dart';
import 'package:crel_mobile/models/appointment.dart';
import 'package:crel_mobile/modules/appointment/widgets/appointment_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ItemAppointment extends StatefulWidget {
  const ItemAppointment(
      {Key? key, required this.appointment, this.appointment1})
      : super(key: key);

  final Appointment appointment;
  final Appointment? appointment1;

  @override
  State<ItemAppointment> createState() => _ItemAppointmentState();
}

class _ItemAppointmentState extends State<ItemAppointment> {
  Future<void> _launchPhone(String phone) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrlString(launchUri.toString())) {
      await launchUrlString(launchUri.toString());
    } else {
      throw "Could not lanch $launchUri";
    }
  }

  @override
  Widget build(BuildContext context) {
    // context
    //     .read<BrandBloc>()
    //     .add(GetBrandByIdRequested(widget.appointment.brandId!));

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (AppFormat.parseDate(DateTime.now().toString()) ==
                      AppFormat.parseDate(
                          widget.appointment.onDateTime.toString()) &&
                  (widget.appointment1 == null ||
                      AppFormat.parseDate(
                              widget.appointment.onDateTime.toString()) !=
                          AppFormat.parseDate(
                              widget.appointment1!.onDateTime.toString())))
              ? Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                      "Hôm nay, " +
                          AppFormat.parseDate(
                              widget.appointment.onDateTime.toString()),
                      style: TxtStyle.heading3),
                )
              : (widget.appointment1 == null ||
                      AppFormat.parseDate(
                              widget.appointment.onDateTime.toString()) !=
                          AppFormat.parseDate(
                              widget.appointment1!.onDateTime.toString()))
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        AppFormat.parseDay(
                                widget.appointment.onDateTime.toString()) +
                            ", " +
                            AppFormat.parseDate(
                                widget.appointment.onDateTime.toString()),
                        style: TxtStyle.heading4,
                      ),
                    )
                  : const SizedBox(),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AppointmentDetail(
                        appointment: widget.appointment,
                      );
                    });

                //     .then((_) {
                //   setState(() {});
                // });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                width: AppFormat.width(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.boderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        // border: Border.all(
                        //   color: Colors.black,
                        //   width: 1,
                        // ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(widget
                                .appointment.brand!.avatarLink ??
                            "https://ae01.alicdn.com/kf/Uc7989d9cf7c34eec9dae6812eb35ee6fT/M-H-nh-Nendoroid-T-y-Toshiro-Hitsugaya-4580416909266.jpg_Q90.jpg_.webp"),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.appointment.brand!.name.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TxtStyle.heading4
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                    AppFormat.phoneFormat(widget
                                        .appointment.brand!.phoneNumber
                                        .toString()),
                                    style: TxtStyle.heading4.copyWith(
                                        // fontWeight: FontWeight.bold,
                                        color: AppColor.textColor)),
                              ],
                            ),
                          ),
                          // const Expanded(child: SizedBox()),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                AppFormat.parseTime(
                                    widget.appointment.onDateTime.toString()),
                                style: TxtStyle.heading4
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppFormat.statusAppointment(
                                        widget.appointment.status.toString()),
                                    style: TxtStyle.heading4.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: widget.appointment.status == 2
                                            ? AppColor.blue
                                            : widget.appointment.status == 4
                                                ? AppColor.green
                                                : widget.appointment.status ==
                                                            3 ||
                                                        widget.appointment
                                                                .status ==
                                                            5
                                                    ? AppColor.red
                                                    : AppColor.yellow),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Container(
                                      height: 24,
                                      width: 24,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: widget.appointment.status == 2
                                              ? AppColor.blue
                                              : widget.appointment.status == 4
                                                  ? AppColor.green
                                                  : widget.appointment.status ==
                                                              3 ||
                                                          widget.appointment
                                                                  .status ==
                                                              5
                                                      ? AppColor.red
                                                      : AppColor.yellow),
                                      child: Padding(
                                        padding: const EdgeInsets.all(1),
                                        child: SvgPicture.asset(
                                          widget.appointment.status == 2
                                              ? 'assets/icons/more-circle.svg'
                                              : widget.appointment.status == 4
                                                  ? 'assets/icons/tick-circle.svg'
                                                  : widget.appointment.status ==
                                                              3 ||
                                                          widget.appointment
                                                                  .status ==
                                                              5
                                                      ? 'assets/icons/minus-cirlce.svg'
                                                      : 'assets/icons/info-circle.svg',
                                          color: Colors.white,
                                          // height: 250,
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
