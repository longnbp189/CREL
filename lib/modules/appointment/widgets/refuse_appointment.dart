import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/appointment.dart';
import 'package:crel_mobile/modules/appointment/blocs/appointment/appointment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RefuseAppointment extends StatefulWidget {
  final int type;
  const RefuseAppointment(
      {Key? key, required this.appointment, required this.type})
      : super(key: key);
  final Appointment appointment;

  @override
  State<RefuseAppointment> createState() => _RefuseAppointmentState();
}

class _RefuseAppointmentState extends State<RefuseAppointment> {
  final _reasonController = TextEditingController();
  @override
  void initState() {
    _reasonController.text = "";
    super.initState();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int current = -1;
    bool isChooseReason = true;
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: StatefulBuilder(
        builder: (context, setState1) =>
            BlocListener<AppointmentBloc, AppointmentState>(
          listener: (context, state) {
            if (state is RefuseAppointmentSuccess) {
              AppFormat.showSnackBar(
                  context,
                  1,
                  // widget.type.toString() == "3"
                  // ?
                  "Từ chối cuộc hẹn thành công"
                  // : "Cập nhật trạng thái cuộc hẹn thành công"
                  );

              Navigator.pushNamedAndRemoveUntil(
                  context, AppRouter.customNavBar, (route) => false,
                  arguments: 3);
            }
          },
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Lý do " +
                            (widget.type.toString() == "3"
                                ? "từ chối"
                                : "không diễn ra"),
                        style: TxtStyle.heading3
                            .copyWith(color: AppColor.primaryColor),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: AppFormat.getListRefuseAppointmnet().length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                setState1(() {
                                  if (current == index) {
                                    current = -1;
                                  } else {
                                    current = index;
                                  }
                                });
                              },
                              child: AnimatedContainer(
                                  height: 40,
                                  duration: const Duration(milliseconds: 300),
                                  decoration: BoxDecoration(
                                    color: current == index
                                        ? AppColor.primaryColor
                                        : Colors.white,
                                    border: Border.all(
                                        width: 1,
                                        color: current == index
                                            ? AppColor.primaryColor
                                            : AppColor.boderColor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: current == index
                                      ? Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  AppFormat.getListRefuseAppointmnet()[
                                                          index]
                                                      .toString(),
                                                  style: TxtStyle.heading4
                                                      .copyWith(
                                                          color: Colors.white),
                                                ),
                                              ),
                                              const FaIcon(
                                                FontAwesomeIcons.check,
                                                color: Colors.white,
                                                size: 16,
                                              )
                                            ],
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(AppFormat
                                                        .getListRefuseAppointmnet()[
                                                    index]
                                                .toString()),
                                          ),
                                        )),
                            ),
                            const SizedBox(
                              height: 8,
                            )
                          ],
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Lý do khác: ",
                          style: TxtStyle.heading4,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            readOnly: (current != -1) ? true : false,
                            cursorColor: AppColor.secondColor,
                            keyboardType: TextInputType.name,
                            controller: _reasonController,
                            style: TxtStyle.heading5Blue.copyWith(
                                fontWeight: FontWeight.normal, fontSize: 14),
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 12),
                                enabledBorder: OutlineInputBorder(
                                  // width: 0.0 produces a thin "hairline" border
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: AppColor.boderColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: (current == -1)
                                        ? AppColor.primaryColor
                                        : AppColor.boderColor,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                          ),
                        ),
                      ),
                      isChooseReason
                          ? const SizedBox()
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  (current == -1 &&
                                          _reasonController.text.trim().isEmpty)
                                      ? "Vui lòng chọn lý do"
                                      : (current == -1 &&
                                              _reasonController.text
                                                      .trim()
                                                      .length <
                                                  7)
                                          ? "Lí do không được ít hơn 6 kí tự"
                                          : "",
                                  style: TxtStyle.heading4
                                      .copyWith(color: Colors.red),
                                ),
                              ),
                            ),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: ElevatedButton(
                                onPressed: () {
                                  _reasonController.clear();
                                  Navigator.of(context).pop();
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
                                  if (current != -1 ||
                                      (_reasonController.text.isNotEmpty &&
                                          _reasonController.text.length > 6)) {
                                    setState1(() {
                                      isChooseReason = true;
                                    });
                                    context.read<AppointmentBloc>().add(
                                        RefuseAppointmentRequested(Appointment(
                                            id: widget.appointment.id,
                                            brand: widget.appointment.brand,
                                            // brandFreeTime1: widget
                                            //     .appointment.brandFreeTime1,
                                            // brandFreeTime2: widget
                                            //     .appointment.brandFreeTime2,
                                            // brandFreeTime3: widget
                                            //     .appointment.brandFreeTime3,
                                            propertyId:
                                                widget.appointment.propertyId,
                                            brandId: widget.appointment.brandId,
                                            brokerId:
                                                widget.appointment.brokerId,
                                            // createDateTime: widget
                                            //     .appointment.createDateTime,
                                            // properties:
                                            //     widget.appointment.properties,
                                            status: widget.type,
                                            description:
                                                widget.appointment.description,
                                            rejectMessage: (current != -1)
                                                ? AppFormat.getListRefuseAppointmnet()[
                                                        current]
                                                    .toString()
                                                : _reasonController.text.trim(),
                                            onDateTime: widget
                                                .appointment.onDateTime)));

                                    // Navigator.of(context).pop();
                                    // Navigator.of(context).pop();
                                  } else {
                                    setState1(() {
                                      isChooseReason = false;
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
