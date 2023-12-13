import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crel_mobile/common/widgets/stateful/chose_brand_appointment.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:crel_mobile/modules/appointment/blocs/appointment/appointment_bloc.dart';
import 'package:crel_mobile/modules/appointment/repos/appointment_repo.dart';
import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_no_valid.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAppointmentPage extends StatefulWidget {
  const CreateAppointmentPage({Key? key}) : super(key: key);

  @override
  State<CreateAppointmentPage> createState() => _CreateAppointmentPageState();
}

class _CreateAppointmentPageState extends State<CreateAppointmentPage> {
  final _descriptionController = TextEditingController();
  Property? suggestProperties;
  bool isBrand = true;
  bool isProperty = true;
  bool isHasProperty = false;
  bool isChoseTime = true;

  List<String> freeCurrentTime = [];
  List<Appointment> appoinment = [];

  DateTime? date1;
  TimeOfDay? timer1;

  bool isValidTime = true;

  Future pickDate(BuildContext context, String dateType) async {
    final chooseDate = await showDatePicker(
        context: context,
        builder: (context, child) => Theme(
              data: ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                primary: AppColor.primaryColor,
              )),
              child: child!,
            ),
        initialDate:
            // TimeOfDay.now().hour >= 19
            //     ? DateTime.now().add(const Duration(days: 1))
            //     :
            DateTime.now().add(const Duration(days: 1)),
        firstDate:
            //  TimeOfDay.now().hour >= 19
            //     ? DateTime.now().add(const Duration(days: 1))
            //     :
            DateTime.now().add(const Duration(days: 1)),
        lastDate: DateTime(2100));

    if (chooseDate == null) return;
    if (dateType == "time1") {
      date1 = chooseDate;

      freeCurrentTime = AppFormat.getListFreeTimeAppointment(chooseDate);

      showDialogChoseTime(context, "timer1");
    }
  }

  Future<dynamic> showDialogChoseTime(BuildContext context1, String timerType) {
    return showDialog(
      context: context1,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Chọn giờ hẹn:'),
                const SizedBox(
                  height: 8,
                ),
                Wrap(
                  runSpacing: 8,
                  spacing: 28,
                  children: List.generate(
                      freeCurrentTime.length,
                      (index) => GestureDetector(
                            onTap: () async {
                              setState(
                                () {
                                  if (timerType == "timer1") {
                                    timer1 = TimeOfDay(
                                        hour: int.parse(freeCurrentTime[index]
                                            .substring(0, 2)),
                                        minute: 0);
                                    isChoseTime = true;
                                    Navigator.pop(context, timer1);
                                  }
                                },
                              );
                            },
                            child: Container(
                              width: AppFormat.width(context) * 0.258,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: 1, color: AppColor.boderColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: Center(
                                    child: Text(
                                  freeCurrentTime[index],
                                  style: TxtStyle.heading4.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.primaryColor),
                                )),
                              ),
                            ),
                          )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Brand returnBrand = Brand();
  callback(returnData) {
    setState(() {
      returnBrand = returnData;
      isBrand = true;
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  List<Widget> listChoseTime = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Tạo cuộc hẹn",
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
            ),
          ),
          backgroundColor: AppColor.primaryColor,
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SafeArea(
              child: Container(
            color: AppColor.backgroundColor,
            child: Column(
              children: [
                const SizedBox(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: BlocListener<AppointmentBloc, AppointmentState>(
                        listener: (context, state) {
                          if (state is CreateAppointmentSuccess) {
                            AppFormat.showSnackBar(
                                context, 1, "Tạo cuộc hẹn thành công");

                            Navigator.pushNamedAndRemoveUntil(context,
                                AppRouter.customNavBar, (route) => false,
                                arguments: 3);
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                "Chọn thương hiệu: ",
                                style: TxtStyle.heading3
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            ChoseBrandAppointment(
                              callback: callback,
                            ),
                            isBrand
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      "Vui lòng chọn thương hiệu",
                                      style: TxtStyle.heading4
                                          .copyWith(color: Colors.red),
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text(
                                "Danh sách mặt bằng: ",
                                style: TxtStyle.heading3
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                context.read<PropertyForRentBloc>().add(
                                    const GetPropertyForRentRequested(
                                        2, "", true));
                                final result = await Navigator.pushNamed(
                                    context, AppRouter.suggestProperty);
                                if (result != null) {
                                  setState(() {
                                    suggestProperties = result as Property;
                                    isProperty = true;
                                    isHasProperty = true;
                                  });
                                }
                              },
                              child: isHasProperty
                                  ? Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: Container(
                                            width: AppFormat.width(context),
                                            height: 200,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: AppColor.primaryColor,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  // flex: 8,
                                                  child: CachedNetworkImage(
                                                    // height: AppFormat.height(context) / 6,
                                                    width: AppFormat.width(
                                                        context),
                                                    fit: BoxFit.cover,
                                                    imageUrl: suggestProperties!
                                                                .media !=
                                                            null
                                                        ? suggestProperties!
                                                            .media![0].link
                                                            .toString()
                                                        : "https://www.savills.com.vn/_images/thaibuilding-20190911.jpg",
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: AppFormat.width(
                                                            context),
                                                        child: Text(
                                                          suggestProperties!
                                                              .name
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          style: TxtStyle
                                                              .heading4
                                                              .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      Text(
                                                        suggestProperties!
                                                                .location!
                                                                .address
                                                                .toString() +
                                                            ", " +
                                                            suggestProperties!
                                                                .location!
                                                                .ward!
                                                                .name
                                                                .toString() +
                                                            ", " +
                                                            suggestProperties!
                                                                .location!
                                                                .ward!
                                                                .district!
                                                                .name
                                                                .toString(),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TxtStyle
                                                            .heading5Blue
                                                            .copyWith(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: -13,
                                          right: -15,
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  // suggestProperties.remove(
                                                  //     suggestProperties[index]);
                                                  // suggestInt
                                                  //     .remove(suggestInt[index]);
                                                  // suggestProperties = Property();
                                                  isProperty = false;
                                                  isHasProperty = false;
                                                });
                                              },
                                              icon: const DeleteItemIcon()),
                                        ),
                                      ],
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: DottedBorder(
                                        radius: const Radius.circular(10),
                                        borderType: BorderType.RRect,
                                        color: AppColor.textColor,
                                        strokeWidth: 2,
                                        dashPattern: const [16, 8],
                                        child: Container(
                                            height: 200,
                                            // height:
                                            //     AppFormat.heightWithoutAppBarAndStatusbar(context) *
                                            //         0.12,
                                            width: AppFormat.width(context),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: AppColor.cardColor,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(24),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const FaIcon(
                                                      FontAwesomeIcons.building,
                                                      size: 48,
                                                      color:
                                                          AppColor.textColor),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: Text(
                                                      "Chọn mặt bằng muốn đề xuất",
                                                      style: TxtStyle.heading4
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: AppColor
                                                                  .textColor),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                      ),
                                    ),
                            ),
                            isProperty
                                ? const SizedBox()
                                : Text(
                                    "Vui lòng chọn mặt bằng",
                                    style: TxtStyle.heading4
                                        .copyWith(color: Colors.red),
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                "Chọn ngày hẹn: ",
                                style: TxtStyle.heading3
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // children: listChoseTime,
                                  children: [
                                    choseDateTimeAppointment(
                                        context, "time1", date1, timer1),
                                  ]),
                            ),
                            isChoseTime
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      "Vui lòng chọn ngày hẹn",
                                      style: TxtStyle.heading4
                                          .copyWith(color: Colors.red),
                                    ),
                                  ),
                            isValidTime
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      "Bạn đã có cuộc hẹn trong giờ hẹn này",
                                      style: TxtStyle.heading4
                                          .copyWith(color: Colors.red),
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: CustomTFFNoValid(
                                type: TextInputType.name,
                                textController: _descriptionController,
                                name: "Lời nhắn",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: SizedBox(
                                width: AppFormat.width(context),
                                child: ElevatedButton(
                                  style: TxtStyle.buttonBlue,
                                  onPressed: () async {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    String? id = prefs.getString("id");

                                    if (returnBrand.id != null) {
                                      setState(() {
                                        isBrand = true;
                                      });
                                    } else {
                                      setState(() {
                                        isBrand = false;
                                      });
                                    }

                                    if (timer1 != null) {
                                      setState(() {
                                        isChoseTime = true;
                                      });
                                    } else {
                                      setState(() {
                                        isChoseTime = false;
                                      });
                                    }

                                    if (suggestProperties != null) {
                                      setState(() {
                                        isProperty = true;
                                      });
                                    } else {
                                      setState(() {
                                        isProperty = false;
                                      });
                                    }

                                    //********************** Check have appointment in time 1 */
                                    if (timer1 != null) {
                                      appoinment = await AppointmentRepo()
                                          .getListToCreateAppointment(
                                              date1!,
                                              DateTime(
                                                date1!.year,
                                                date1!.month,
                                                date1!.day,
                                              ).add(const Duration(days: 1)));
                                    }
                                    for (var element in appoinment) {
                                      if (DateTime(
                                                  element.onDateTime!.year,
                                                  element.onDateTime!.month,
                                                  element.onDateTime!.day,
                                                  element.onDateTime!.hour + 1,
                                                  element.onDateTime!.minute -
                                                      1)
                                              .isAfter(DateTime(
                                                  date1!.year,
                                                  date1!.month,
                                                  date1!.day,
                                                  timer1!.hour,
                                                  timer1!.minute)) &&
                                          DateTime(
                                                  element.onDateTime!.year,
                                                  element.onDateTime!.month,
                                                  element.onDateTime!.day,
                                                  element.onDateTime!.hour)
                                              .isBefore(DateTime(
                                            date1!.year,
                                            date1!.month,
                                            date1!.day,
                                            timer1!.hour,
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
                                              date1!.year,
                                              date1!.month,
                                              date1!.day,
                                              timer1!.hour))) {
                                        setState(() {
                                          isValidTime = false;
                                        });
                                        return;
                                      } else if (DateTime(
                                                  date1!.year,
                                                  date1!.month,
                                                  date1!.day,
                                                  timer1!.hour + 1,
                                                  timer1!.minute)
                                              .isAfter(DateTime(
                                                  element.onDateTime!.year,
                                                  element.onDateTime!.month,
                                                  element.onDateTime!.day,
                                                  element.onDateTime!.hour)) &&
                                          DateTime(
                                                  element.onDateTime!.year,
                                                  element.onDateTime!.month,
                                                  element.onDateTime!.day,
                                                  element.onDateTime!.hour + 1,
                                                  element.onDateTime!.minute -
                                                      1)
                                              .isAfter(DateTime(
                                                  date1!.year,
                                                  date1!.month,
                                                  date1!.day,
                                                  timer1!.hour,
                                                  timer1!.minute,
                                                  timer1!.hour + 1,
                                                  timer1!.minute))) {
                                        setState(() {
                                          isValidTime = false;
                                        });
                                        return;
                                      }
                                      setState(() {
                                        isValidTime = true;
                                      });
                                    }

                                    if (isChoseTime &&
                                        isBrand &&
                                        isProperty &&
                                        // isNotEqualTime &&
                                        isValidTime) {
                                      setState(() {
                                        isBrand = true;
                                        isProperty = true;
                                        isChoseTime = true;
                                        // isNotEqualTime = true;
                                        isValidTime = true;
                                      });
                                      BlocProvider.of<AppointmentBloc>(context)
                                          .add(CreateAppointmentRequested(
                                        Appointment(
                                            brokerId: int.parse(id!),
                                            propertyId: suggestProperties!.id,
                                            status: 2,
                                            description: _descriptionController
                                                .text
                                                .trim(),
                                            onDateTime:
                                                AppFormat.connectDateTime(
                                                    date1!, timer1!),
                                            brandId: returnBrand.id),
                                      ));
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Text(
                                      'Tạo cuộc hẹn',
                                      style: TxtStyle.heading3
                                          .copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ));
  }

  GestureDetector choseDateTimeAppointment(
      BuildContext context, String typeTime, DateTime? date, TimeOfDay? timer) {
    return GestureDetector(
      onTap: () {
        pickDate(context, typeTime);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: AppColor.boderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Center(
            child: (date != null && timer != null)
                ? Column(
                    children: [
                      Text(
                        AppFormat.parseDate(date.toString()),
                        style: TxtStyle.heading4.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColor.primaryColor),
                      ),
                      Text(
                        timer.hour.toString().padLeft(2, "0") +
                            " : " +
                            timer.minute.toString().padLeft(2, "0"),
                        style: TxtStyle.heading4.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 4, right: 4),
                    child: RichText(
                      text: TextSpan(
                          text: "Chọn ngày",
                          style: TxtStyle.heading4.copyWith(
                              color: AppColor.textColor,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: ' *',
                              style: TxtStyle.heading4.copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                    )

                    //  Text("Chọn ngày",
                    //     style: TxtStyle.heading4.copyWith(
                    //         fontWeight: FontWeight.bold,
                    //         color: AppColor.textColor)),
                    ),
          ),
        ),
      ),
    );
  }
}

class DeleteItemIcon extends StatelessWidget {
  const DeleteItemIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: const FaIcon(FontAwesomeIcons.xmark));
  }
}

class AddItemIcon extends StatelessWidget {
  const AddItemIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        child: const FaIcon(
          FontAwesomeIcons.plus,
          size: 30,
        ));
  }
}
