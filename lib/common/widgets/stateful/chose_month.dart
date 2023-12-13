import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/ward.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';

class ChoseMonth extends StatefulWidget {
  final Function(Ward) callback;
  const ChoseMonth({Key? key, required this.callback}) : super(key: key);

  @override
  State<ChoseMonth> createState() => _ChoseWardState();
}

class _ChoseWardState extends State<ChoseMonth> {
  List<Ward> listWard = [];
  DateTime? date1;

  Future pickDate(BuildContext context) async {
    final chooseDate = await showMonthPicker(
        context: context,
        // builder: (context, child) => Theme(
        //       data: ThemeData.light().copyWith(
        //           colorScheme: const ColorScheme.light(
        //         primary: AppColor.primaryColor,
        //       )),
        //       child: child!,
        //     ),
        initialDate: DateTime.now(),
        // firstDate: DateTime.no(),
        lastDate: DateTime(2100));

    if (chooseDate == null) return;
    setState(() {
      date1 = chooseDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        flex: 2,
        child: Text(
          "Chọn tháng: ",
          style: TxtStyle.heading3.copyWith(fontWeight: FontWeight.normal),
        ),
      ),
      Expanded(
        flex: 5,
        child: GestureDetector(
          onTap: () {
            pickDate(context);
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: (date1 != null)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppFormat.parseMonth(date1.toString()),
                          style: TxtStyle.heading4,
                        ),
                      ],
                    )
                  : const Text("Chọn tháng", style: TxtStyle.heading4),
            ),
          ),
        ),
      )
    ]);
  }
}
