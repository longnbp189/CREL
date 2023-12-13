import 'package:crel_mobile/config/app_color.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/app_router.dart';
import 'package:crel_mobile/config/text_style.dart';
import 'package:crel_mobile/models/contract.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContractItem extends StatelessWidget {
  final Contract contract;
  const ContractItem({Key? key, required this.contract}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColor.boderColor),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Hợp đồng cho thuê nhà ' +
                          AppFormat.parseDate(contract.startDate.toString()),
                      style: TxtStyle.heading3,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  contract.status == 1
                      ? SizedBox(
                          height: 30,
                          width: 30,
                          child: IconButton(
                            splashRadius: 24,
                            padding: const EdgeInsets.all(0.0),
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRouter.verifyContract,
                                  arguments: contract);
                            },
                            icon: SvgPicture.asset(
                              'assets/icons/contract-confirm.svg',
                              height: 24,
                            ),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Thương hiệu",
                          style: TxtStyle.heading5Gray.copyWith(fontSize: 14),
                        ),
                        Text(
                          contract.brand!.name.toString(),
                          style: TxtStyle.heading3,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    contract.status == 1
                        ? "Cần xác thực"
                        : contract.status == 2
                            ? "Đang hiệu lực"
                            : "Hết hiệu lực",
                    style: TxtStyle.heading4.copyWith(
                        fontWeight: FontWeight.bold,
                        color: contract.status == 1
                            ? AppColor.yellow
                            : contract.status == 2
                                ? AppColor.green
                                : AppColor.red),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: contract.status == 1
                              ? AppColor.yellow
                              : contract.status == 2
                                  ? AppColor.green
                                  : AppColor.red),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: contract.status == 1
                            ? SvgPicture.asset(
                                'assets/icons/warning.svg',
                                color: Colors.white,
                                // height: 250,
                              )
                            : contract.status == 2
                                ? SvgPicture.asset(
                                    'assets/icons/doneAppointment.svg',
                                    color: Colors.white,

                                    // height: 250,
                                  )
                                : SvgPicture.asset(
                                    'assets/icons/cancelAppointment.svg',
                                    color: Colors.white,

                                    // height: 250,
                                  ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
