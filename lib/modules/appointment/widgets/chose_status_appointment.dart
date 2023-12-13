import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/appointment.dart';
import 'package:crel_mobile/modules/appointment/blocs/appointment/appointment_bloc.dart';
import 'package:crel_mobile/modules/appointment/widgets/refuse_appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChoseStatusAppointment extends StatelessWidget {
  // final List<Property> properties;
  final Appointment appointment;
  const ChoseStatusAppointment({Key? key, required this.appointment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int current = -1;
    bool isChooseStatus = true;
    return Dialog(
      // backgroundColor: AppColor.cardColor,
      insetPadding: const EdgeInsets.all(16),
      child: StatefulBuilder(
        builder: (context, setState1) =>
            BlocListener<AppointmentBloc, AppointmentState>(
          listener: (context, state) {
            if (state is UpdateAppointmentSuccess) {
              AppFormat.showSnackBar(
                  context, 1, "Cập nhật trạng thái cuộc hẹn thành công");

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Cuộc hẹn diễn ra thành công chứ?",
                        style: TxtStyle.heading3,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      isChooseStatus
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "Vui lòng xác nhận cuộc hẹn có diễn ra hay không.",
                                style: TxtStyle.heading4
                                    .copyWith(color: Colors.red),
                              ),
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                setState1(() {
                                  if (current == 5) {
                                    current = -1;
                                  } else {
                                    current = 5;
                                  }
                                });
                              },
                              child: AnimatedContainer(
                                height: 40,
                                // width: 100,
                                duration: const Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                  color:
                                      current == 5 ? Colors.red : Colors.white,
                                  border: Border.all(
                                      width: 1,
                                      color: current == 5
                                          ? Colors.red
                                          : AppColor.boderColor),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: current == 5
                                    ? Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "Không diễn ra",
                                              style: TxtStyle.heading4.copyWith(
                                                  color: Colors.white),
                                            ),
                                            const FaIcon(
                                              FontAwesomeIcons.xmark,
                                              color: Colors.white,
                                              size: 16,
                                            )
                                          ],
                                        ),
                                      )
                                    : const Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Không diễn ra",
                                          ),
                                        )),
                              ),
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                setState1(() {
                                  if (current == 4) {
                                    current = -1;
                                  } else {
                                    current = 4;
                                  }
                                });
                              },
                              child: AnimatedContainer(
                                height: 40,
                                // width: 100,
                                duration: const Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                  color: current == 4
                                      ? Colors.green
                                      : Colors.white,
                                  border: Border.all(
                                      width: 1,
                                      color: current == 4
                                          ? Colors.green
                                          : AppColor.boderColor),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: current == 4
                                    ? Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              "Đã diễn ra",
                                              style: TxtStyle.heading4.copyWith(
                                                  color: Colors.white),
                                            ),
                                            const FaIcon(
                                              FontAwesomeIcons.check,
                                              color: Colors.white,
                                              size: 16,
                                            )
                                          ],
                                        ),
                                      )
                                    : const Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Đã diễn ra",
                                          ),
                                        )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
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
                                      borderRadius: BorderRadius.circular(10),
                                    ))),
                                child: Text('Hủy bỏ',
                                    style: TxtStyle.heading4
                                        .copyWith(color: Colors.white))),
                          ),
                          const Expanded(child: SizedBox()),
                          Expanded(
                            flex: 5,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (current != -1) {
                                    setState1(() {
                                      isChooseStatus = true;
                                    });

                                    if (current == 4) {
                                      BlocProvider.of<AppointmentBloc>(context)
                                          .add(UpdateAppointmentRequested(
                                              Appointment(
                                                  id: appointment.id,
                                                  brand: appointment.brand,
                                                  // brandFreeTime1: appointment
                                                  //     .brandFreeTime1,
                                                  // brandFreeTime2: appointment
                                                  //     .brandFreeTime2,
                                                  // brandFreeTime3: appointment
                                                  //     .brandFreeTime3,
                                                  brandId: appointment.brandId,
                                                  brokerId:
                                                      appointment.brokerId,
                                                  // createDateTime: appointment
                                                  //     .createDateTime,
                                                  propertyId:
                                                      appointment.propertyId,
                                                  // properties:
                                                  //     appointment.properties,
                                                  // slot: appointment.slot,
                                                  status: current,
                                                  description:
                                                      appointment.description,
                                                  onDateTime:
                                                      appointment.onDateTime)));
                                      // Navigator.pop(context);
                                    } else if (current == 5) {
                                      Navigator.pop(context);

                                      showDialog(
                                        context: context,
                                        builder: (context) => RefuseAppointment(
                                            type: 5, appointment: appointment),
                                      );
                                    }
                                  } else {
                                    setState1(() {
                                      isChooseStatus = false;
                                    });
                                  }
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
                                      borderRadius: BorderRadius.circular(10),
                                    ))),
                                child: Text('Xác nhận',
                                    style: TxtStyle.heading4
                                        .copyWith(color: Colors.white))),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
