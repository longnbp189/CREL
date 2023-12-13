import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:crel_mobile/modules/appointment/blocs/contract/contract_bloc.dart';
import 'package:crel_mobile/modules/appointment/pages/create_contract_page.dart';
import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChosePropertyToContract extends StatelessWidget {
  final List<Property> properties;
  final Appointment appointment;
  const ChosePropertyToContract(
      {Key? key, required this.properties, required this.appointment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // backgroundColor: AppColor.cardColor,
      insetPadding: const EdgeInsets.all(16),
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
                    "Chọn mặt bằng muốn tạo hợp đồng:",
                    style: TxtStyle.heading3,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: properties.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const FaIcon(FontAwesomeIcons.building,
                                size: 24, color: AppColor.primaryColor),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  context.read<ContractBloc>().add(
                                      GetContractByIdRequested(
                                          properties[index].id!));
                                  context.read<PropertyForRentBloc>().add(
                                      GetPropertyForRentByIdRequested(
                                          properties[index].id!));
                                  Navigator.pushNamed(
                                      context, AppRouter.createContract,
                                      arguments: CreateContractPage(
                                        appointment: appointment,
                                        // property: properties[index]
                                      ));
                                },
                                child: Text(properties[index].name.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TxtStyle.heading4.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.primaryColor)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColor.primaryColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ))),
                        child: Text('Hủy bỏ',
                            style: TxtStyle.heading4
                                .copyWith(color: Colors.white))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
