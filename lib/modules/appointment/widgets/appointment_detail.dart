import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/appointment.dart';
import 'package:crel_mobile/modules/appointment/blocs/appointment/appointment_bloc.dart';
import 'package:crel_mobile/modules/appointment/blocs/contract/contract_bloc.dart';
import 'package:crel_mobile/modules/appointment/repos/appointment_repo.dart';
import 'package:crel_mobile/modules/appointment/widgets/chose_status_appointment.dart';
import 'package:crel_mobile/modules/appointment/widgets/refuse_appointment.dart';
import 'package:crel_mobile/modules/home/blocs/brand/brand_bloc.dart';
import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppointmentDetail extends StatefulWidget {
  const AppointmentDetail({Key? key, required this.appointment})
      : super(key: key);
  final Appointment appointment;

  @override
  State<AppointmentDetail> createState() => _AppointmentDetailState();
}

class _AppointmentDetailState extends State<AppointmentDetail> {
  bool time1 = false;
  bool time2 = false;
  bool time3 = false;
  // bool isChooseTime = true;
  List<Appointment> appoinment1 = [];
  bool isValidTime = true;

  // DateTime? dateBusy;
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
    // Property propertyAvaiable = widget.appointment.property!.status == 2
    //     ? widget.appointment.property!
    //     : Property();
    // .where((element) => element.status == 2)
    // .toList();
    // List<DateTime?> brandFreeTime = [
    //   widget.appointment.brandFreeTime1,
    //   widget.appointment.brandFreeTime2,
    //   widget.appointment.brandFreeTime3
    // ];

    // brandFreeTime = brandFreeTime.where((element) => element != null).toList();

    return Dialog(
        // backgroundColor: AppColor.cardColor,
        insetPadding: const EdgeInsets.all(16),
        child: BlocListener<AppointmentBloc, AppointmentState>(
          listener: (context, state) {
            if (state is UpdateAppointmentSuccess) {
              AppFormat.showSnackBar(
                  context, 1, "Chấp nhận cuộc hẹn thành công");

              Navigator.pushNamedAndRemoveUntil(
                  context, AppRouter.customNavBar, (route) => false,
                  arguments: 3);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // color: AppColor.cardColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(widget
                                      .appointment.brand!.avatarLink ??
                                  "https://ae01.alicdn.com/kf/Uc7989d9cf7c34eec9dae6812eb35ee6fT/M-H-nh-Nendoroid-T-y-Toshiro-Hitsugaya-4580416909266.jpg_Q90.jpg_.webp"),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              context.read<BrandBloc>().add(
                                  GetBrandByIdRequested(
                                      widget.appointment.brandId!));
                              Navigator.pushNamed(
                                  context, AppRouter.brandDetail,
                                  arguments: 0);
                            },
                            child: SizedBox(
                              width: 280,
                              child: Text(
                                widget.appointment.brand!.name.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TxtStyle.heading3
                                    .copyWith(color: AppColor.secondColor),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: SvgPicture.asset(
                                'assets/icons/call.svg',
                              ),
                            ),
                            Expanded(
                              flex: 9,
                              child: GestureDetector(
                                onTap: () {
                                  _launchPhone(widget
                                      .appointment.brand!.phoneNumber
                                      .toString());
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        AppFormat.phoneFormat(widget
                                            .appointment.brand!.phoneNumber
                                            .toString()),
                                        style: TxtStyle.heading4.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.secondColor)),
                                    Text("Gọi ngay",
                                        style: TxtStyle.heading4.copyWith(
                                          decoration: TextDecoration.underline,
                                          // fontWeight: FontWeight.bold,
                                          color: AppColor.secondColor,
                                        )),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: SvgPicture.asset(
                                'assets/icons/building.svg',
                              ),
                            ),
                            Expanded(
                              flex: 9,
                              child: GestureDetector(
                                onTap: () {
                                  context.read<PropertyForRentBloc>().add(
                                      GetPropertyForRentByIdRequested(
                                          widget.appointment.propertyId!));
                                  // Navigator.pushNamed(
                                  //     context, AppRouter.propertyDetail,
                                  //     arguments: ScreenPropertyArguments(
                                  //         widget.appointment.property!, 0));

                                  Navigator.pushNamed(
                                      context, AppRouter.propertyDetail,
                                      arguments: widget.appointment.property);
                                },
                                child: Text(
                                    widget.appointment.property!.name
                                        .toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TxtStyle.heading4.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.secondColor)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: SvgPicture.asset(
                                'assets/icons/address.svg',
                              ),
                            ),
                            Expanded(
                              flex: 9,
                              child: Text(
                                  AppFormat.getAddress(
                                      widget.appointment.property!),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TxtStyle.heading4),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child:
                              // widget.appointment.status == 2
                              // ?
                              Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SvgPicture.asset(
                                  'assets/icons/clock.svg',
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: Text(
                                    "Lúc " +
                                        AppFormat.parseTime(widget
                                            .appointment.onDateTime
                                            .toString()) +
                                        ", " +
                                        AppFormat.parseDate(widget
                                            .appointment.onDateTime
                                            .toString()),
                                    style: TxtStyle.heading4),
                              )
                            ],
                          )),
                      isValidTime
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Bạn đã có cuộc hẹn trong khung giờ này. Vui lòng từ chối",
                                style: TxtStyle.heading4
                                    .copyWith(color: Colors.red),
                              ),
                            ),
                      widget.appointment.description != ""
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SvgPicture.asset(
                                      'assets/icons/message.svg',
                                    ),
                                  ),
                                  Expanded(
                                    flex: 9,
                                    child: Text(
                                        widget.appointment.description
                                            .toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TxtStyle.heading4),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                      Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: (widget.appointment.status == 1 &&
                                  widget.appointment.createDateTime!
                                      .isBefore(DateTime.now()))
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    RefuseAppointment(
                                                      type: 3,
                                                      appointment:
                                                          widget.appointment,
                                                    ));
                                          },
                                          style: ButtonStyle(
                                              foregroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.white),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      AppColor.primaryColor),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ))),
                                          child: Text('Từ chối',
                                              style: TxtStyle.heading4.copyWith(
                                                  color: Colors.white))),
                                    ),
                                    const Expanded(child: SizedBox()),
                                    Expanded(
                                      flex: 5,
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            //  if (timer1 != null) {
                                            appoinment1 =
                                                await AppointmentRepo()
                                                    .getListToCreateAppointment(
                                                        widget.appointment
                                                            .onDateTime!,
                                                        DateTime(
                                                                widget
                                                                    .appointment
                                                                    .onDateTime!
                                                                    .year,
                                                                widget
                                                                    .appointment
                                                                    .onDateTime!
                                                                    .month,
                                                                widget
                                                                    .appointment
                                                                    .onDateTime!
                                                                    .day)
                                                            .add(const Duration(
                                                                days: 1)));

                                            for (var element in appoinment1) {
                                              if (DateTime(
                                                          element
                                                              .onDateTime!.year,
                                                          element.onDateTime!
                                                              .month,
                                                          element
                                                              .onDateTime!.day,
                                                          element.onDateTime!.hour +
                                                              1,
                                                          element.onDateTime!.minute -
                                                              1)
                                                      .isAfter(DateTime(
                                                          widget.appointment
                                                              .onDateTime!.year,
                                                          widget
                                                              .appointment
                                                              .onDateTime!
                                                              .month,
                                                          widget.appointment
                                                              .onDateTime!.day,
                                                          widget.appointment
                                                              .onDateTime!.hour,
                                                          widget
                                                              .appointment
                                                              .onDateTime!
                                                              .minute)) &&
                                                  DateTime(
                                                          element
                                                              .onDateTime!.year,
                                                          element.onDateTime!
                                                              .month,
                                                          element.onDateTime!.day,
                                                          element.onDateTime!.hour)
                                                      .isBefore(DateTime(
                                                    widget.appointment
                                                        .onDateTime!.year,
                                                    widget.appointment
                                                        .onDateTime!.month,
                                                    widget.appointment
                                                        .onDateTime!.day,
                                                    widget.appointment
                                                        .onDateTime!.hour,
                                                  ))) {
                                                setState(() {
                                                  isValidTime = false;
                                                });
                                                return;
                                              } else if (DateTime(
                                                      element.onDateTime!.year,
                                                      element.onDateTime!.month,
                                                      element.onDateTime!.day,
                                                      element.onDateTime!.hour)
                                                  .isAtSameMomentAs(DateTime(
                                                      widget.appointment
                                                          .onDateTime!.year,
                                                      widget.appointment
                                                          .onDateTime!.month,
                                                      widget.appointment
                                                          .onDateTime!.day,
                                                      widget.appointment
                                                          .onDateTime!.hour))) {
                                                setState(() {
                                                  isValidTime = false;
                                                });
                                                return;
                                              } else if (DateTime(widget.appointment.onDateTime!.year, widget.appointment.onDateTime!.month, widget.appointment.onDateTime!.day, widget.appointment.onDateTime!.hour + 1, widget.appointment.onDateTime!.minute).isAfter(DateTime(
                                                      element.onDateTime!.year,
                                                      element.onDateTime!.month,
                                                      element.onDateTime!.day,
                                                      element
                                                          .onDateTime!.hour)) &&
                                                  DateTime(element.onDateTime!.year, element.onDateTime!.month, element.onDateTime!.day, element.onDateTime!.hour + 1, element.onDateTime!.minute - 1)
                                                      .isAfter(DateTime(
                                                          widget.appointment
                                                              .onDateTime!.year,
                                                          widget
                                                              .appointment
                                                              .onDateTime!
                                                              .month,
                                                          widget.appointment
                                                              .onDateTime!.day,
                                                          widget.appointment
                                                              .onDateTime!.hour,
                                                          widget
                                                              .appointment
                                                              .onDateTime!
                                                              .minute,
                                                          widget.appointment.onDateTime!.hour +
                                                              1,
                                                          widget.appointment.onDateTime!.minute))) {
                                                setState(() {
                                                  isValidTime = false;
                                                });
                                                return;
                                              }
                                              setState(() {
                                                isValidTime = true;
                                              });
                                            }
                                            if (isValidTime) {
                                              BlocProvider.of<AppointmentBloc>(
                                                      context)
                                                  .add(
                                                      UpdateAppointmentRequested(
                                                          Appointment(
                                                id: widget.appointment.id,
                                                brand: widget.appointment.brand,
                                                // brandFreeTime1: widget
                                                //     .appointment
                                                //     .brandFreeTime1,
                                                // brandFreeTime2: widget
                                                //     .appointment
                                                //     .brandFreeTime2,
                                                // brandFreeTime3: widget
                                                //     .appointment
                                                //     .brandFreeTime3,
                                                propertyId: widget
                                                    .appointment.propertyId,
                                                brandId:
                                                    widget.appointment.brandId,
                                                brokerId:
                                                    widget.appointment.brokerId,
                                                // createDateTime: widget
                                                //     .appointment.createDateTime,
                                                onDateTime: widget
                                                    .appointment.onDateTime,
                                                // properties: widget
                                                //     .appointment
                                                //     .properties,
                                                status: 2,
                                                description: widget
                                                    .appointment.description,
                                                // onDateTime: current == 0
                                                //     ? widget.appointment.brandFreeTime1
                                                //     : current == 1
                                                //         ? widget.appointment.brandFreeTime2
                                                //         : widget.appointment.brandFreeTime3
                                              )));
                                              // }

                                              // Navigator.pop(context);
                                              //  else {
                                              //   setState(() {
                                              //     isChooseTime = false;
                                              //   });
                                            }
                                          },
                                          style: ButtonStyle(
                                              foregroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.white),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      AppColor.primaryColor),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ))),
                                          child: Text('Chấp nhận',
                                              style: TxtStyle.heading4.copyWith(
                                                  color: Colors.white))),
                                    )
                                  ],
                                )
                              : (widget.appointment.onDateTime!
                                          .isBefore(DateTime.now()) &&
                                      widget.appointment.status == 4 &&
                                      widget.appointment.property!.status == 2
                                  // propertyAvaiable.isNotEmpty
                                  )
                                  ? ElevatedButton(
                                      onPressed: () {
                                        // Navigator.pop(context);
                                        context.read<ContractBloc>().add(
                                            GetContractByIdRequested(widget
                                                .appointment.property!.id!));
                                        context.read<BrandBloc>().add(
                                            GetBrandByIdRequested(
                                                widget.appointment.brandId!));
                                        // widget.appointment == null
                                        //     ? context
                                        //         .read<PropertyForRentBloc>()
                                        //         .add(
                                        //             const GetPropertyForRentRequested(
                                        //                 2,
                                        //                 "",
                                        //                 true))
                                        //     :
                                        context.read<PropertyForRentBloc>().add(
                                            GetPropertyForRentByIdRequested(
                                                widget.appointment.property!
                                                    .id!));
                                        Navigator.pushNamed(
                                          context,
                                          AppRouter.createContract,
                                          arguments: widget.appointment,
                                        );

                                        // showDialog(
                                        //     context: context,
                                        //     builder: (context) =>
                                        //         ChosePropertyToContract(
                                        //             appointment:
                                        //                 widget.appointment,
                                        //             // properties:
                                        //             //     widget.appointment.property!
                                        //                 ));
                                      },
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  AppColor.primaryColor),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ))),
                                      child: Text('Tạo hợp đồng',
                                          style: TxtStyle.heading4
                                              .copyWith(color: Colors.white)))
                                  : (widget.appointment.onDateTime!
                                              .isBefore(DateTime.now()) &&
                                          widget.appointment.status == 2)
                                      ? ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    ChoseStatusAppointment(
                                                      appointment:
                                                          widget.appointment,
                                                    ));
                                          },
                                          style: ButtonStyle(
                                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                              backgroundColor: MaterialStateProperty.all<Color>(AppColor.primaryColor),
                                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ))),
                                          child: Text('Cập nhật cuộc hẹn', style: TxtStyle.heading4.copyWith(color: Colors.white)))
                                      : const SizedBox())
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
