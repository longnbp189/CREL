import 'package:crel_mobile/common/widgets/stateful/custom_carousel_image_property.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/contract.dart';
import 'package:crel_mobile/modules/appointment/blocs/contract/contract_bloc.dart';
import 'package:crel_mobile/modules/appointment/repos/contract_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContractDetailPage extends StatefulWidget {
  final Contract contract;
  final int? id;
  const ContractDetailPage({Key? key, required this.contract, this.id})
      : super(key: key);

  @override
  State<ContractDetailPage> createState() => _ContractDetailPageState();
}

class _ContractDetailPageState extends State<ContractDetailPage> {
  int current = -1;
  bool isChooseReason = true;
  Contract? contract;
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

  DateTime date = DateTime(DateTime.now().year, DateTime.now().month);
  bool isCreateContract = false;
  @override
  Widget build(BuildContext context) {
    // int count = 0;

    return WillPopScope(
      onWillPop: () async {
        // if (widget.id == 1) {
        //   context.read<ContractBloc>().add(SearchContractByMonth(
        //       AppFormat.startDayOfMonth(AppFormat.getYearAndMonthNow()),
        //       AppFormat.endDayOfMonth(AppFormat.getYearAndMonthNow()),
        //       true));
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, AppRouter.contractPage, (route) => false,
        //       arguments: 1);
        // } else {
        // context.read<ContractBloc>().add(SearchContractByMonth(
        //     AppFormat.startDayOfMonth(date),
        //     AppFormat.endDayOfMonth(date),
        //     true));
        Navigator.pop(context);
        // }

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Chi tiết hợp đồng",
            style: TxtStyle.textAppBar,
          ),
          backgroundColor: AppColor.primaryColor,
          centerTitle: true,
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(
              'assets/icons/arrow-left.svg',
              color: Colors.white,
              // height: 250,
            ),
          ),
          // leading: IconButton(
          //     onPressed: () {
          //       // if (widget.id == 1) {
          //       //   context.read<ContractBloc>().add(SearchContractByMonth(
          //       //       AppFormat.startDayOfMonth(date),
          //       //       AppFormat.endDayOfMonth(date),
          //       //       true));
          //       //   Navigator.pushNamedAndRemoveUntil(
          //       //       context, AppRouter.contractPage, (route) => false,
          //       //       arguments: 1);
          //       // } else {
          //       // context.read<ContractBloc>().add(SearchContractByMonth(
          //       //     AppFormat.startDayOfMonth(date),
          //       //     AppFormat.endDayOfMonth(date),
          //       //     true));
          //       Navigator.pop(context);
          //       // }
          //     },
          //     icon: const FaIcon(FontAwesomeIcons.arrowLeft)),
          actions: widget.contract.reasonCancel != null
              ? null
              : [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRouter.extendContract,
                          arguments: widget.contract);
                      // showDialog(
                      //     context: context,
                      //     builder: (context) => DialogRefuseContract(
                      //         contract: widget.contract,
                      //         reasonRefuse: AppFormat.getListDeleteContract()));
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/contract-extend.svg',
                      color: Colors.white,
                      // height: 250,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => DialogRefuseContract(
                              contract: widget.contract,
                              reasonRefuse: AppFormat.getListDeleteContract()));
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/trash.svg',
                      color: Colors.white,
                      // height: 250,
                    ),
                  ),
                ],
        ),
        body: SafeArea(
          child: BlocListener<ContractBloc, ContractState>(
              listener: (context, state) {
            if (state is ContractUpdateSuccess) {
              AppFormat.showSnackBar(
                  context, 1, "Cập nhật hợp đồng thành công");
              // Navigator.pop(context);
              // Navigator.pop(context);
              // Timer(const Duration(milliseconds: 800), () {
              //   Navigator.of(context).popAndPushNamed(
              //     AppRouter.contractPage,
              //   );
              // });
            }

            if (state is ContractDeleteSuccess) {
              AppFormat.showSnackBar(context, 1, "Hủy hợp đồng thành công");
              // Navigator.pop(context);
              // Navigator.pop(context);
              // Timer(const Duration(milliseconds: 800), () {
              //   Navigator.of(context).popAndPushNamed(
              //     AppRouter.contractPage,
              //   );
              // });
            }

            if (state is ContractLoaded) {
              // AppFormat.showSnackBar(context, 1, "Tạo hợp đồng thành công");

              Navigator.pushNamedAndRemoveUntil(
                  context, AppRouter.contractPage, (route) => false,
                  arguments: 1);
              // Navigator.of(context).pop();
            }
            if (state is ContractByIdLoaded) {
              contract = state.contract;
              // context
              //     .read<ContractBloc>()
              //     .add(const GetContractRequested(true));
            }
            // if (state1 is ContractUpdateSuccess) {
            //   AppFormat.showSnackBar(
            //       context, 1, "Cập nhật hợp đồng thành công");

            //   Navigator.of(context).popUntil((route) => count++ >= 1);
            // }
          }, child: BlocBuilder<ContractBloc, ContractState>(
            // buildWhen: (previous, current) =>
            //     previous != current && current is ContractByIdLoaded,
            builder: (context, state) {
              if (state is ContractLoading || state is ContractLoaded) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ContractByIdLoaded) {
                return Column(
                  children: [
                    CustomCarouselImageProperty(
                      media: state.contract.media,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          state.contract.reasonCancel != null
                              ? Text(
                                  state.contract.reasonCancel.toString(),
                                  style: TxtStyle.heading3.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.red),
                                )
                              : const SizedBox(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Thương hiệu: ",
                                      style: TxtStyle.heading4,
                                    )),
                                Expanded(
                                    flex: 5,
                                    child: Text(
                                      state.contract.brand!.name.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TxtStyle.heading4,
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Chủ sở hữu: ",
                                    style: TxtStyle.heading4,
                                  )),
                              Expanded(
                                  flex: 5,
                                  child: Text(
                                    state.contract.owner!.name.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TxtStyle.heading4,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Mặt bằng: ",
                                    style: TxtStyle.heading4,
                                  )),
                              Expanded(
                                  flex: 5,
                                  child: Text(
                                    state.contract.property!.name.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TxtStyle.heading4,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Địa chỉ: ",
                                    style: TxtStyle.heading4,
                                  )),
                              Expanded(
                                  flex: 5,
                                  child: Text(
                                    AppFormat.getAddress(
                                        state.contract.property!),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TxtStyle.heading4,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Chính sách thanh toán: ",
                                    style: TxtStyle.heading4,
                                  )),
                              Expanded(
                                  flex: 5,
                                  child: Text(
                                    state.contract.paymentTerm.toString(),
                                    style: TxtStyle.heading4,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Tiền thuê: ",
                                    style: TxtStyle.heading4,
                                  )),
                              Expanded(
                                  flex: 5,
                                  child: Text(
                                    AppFormat.changePriceVN(
                                            state.contract.price.toString()) +
                                        " Triệu/tháng",
                                    style: TxtStyle.heading4,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Ngày bắt đầu: ",
                                    style: TxtStyle.heading4,
                                  )),
                              Expanded(
                                  flex: 5,
                                  child: Text(
                                    AppFormat.parseDate(
                                        state.contract.startDate.toString()),
                                    style: TxtStyle.heading4,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Ngày kết thúc: ",
                                    style: TxtStyle.heading4,
                                  )),
                              Expanded(
                                  flex: 5,
                                  child: Text(
                                    AppFormat.parseDate(
                                        state.contract.endDate.toString()),
                                    style: TxtStyle.heading4,
                                  ))
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                "Đang mở hợp đồng. Xin vui lòng chờ.",
                                style: TxtStyle.heading4
                                    .copyWith(color: Colors.white),
                              )));
                              ContractRepo().openFilee(state.contract);
                            },
                            child: SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "Xem chi tiết hợp đồng",
                                  style: TxtStyle.heading3.copyWith(
                                      decoration: TextDecoration.underline,
                                      color: AppColor.primaryColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Text("$state");
            },
          )),
        ),
      ),
    );
  }
}

class DialogRefuseContract extends StatelessWidget {
  final Contract contract;
  final List<String> reasonRefuse;

  const DialogRefuseContract(
      {Key? key, required this.contract, required this.reasonRefuse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int current = -1;
    bool isChooseReason = true;
    final _reasonController = TextEditingController();
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: StatefulBuilder(
        builder: (context, setState1) => GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "Lý do hủy hợp đồng",
                      style: TxtStyle.heading3
                          .copyWith(color: AppColor.primaryColor),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: reasonRefuse.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              setState1(() {
                                if (current == index) {
                                  current = -1;
                                  isChooseReason = true;
                                } else {
                                  current = index;
                                  isChooseReason = true;
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
                                                reasonRefuse[index].toString(),
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
                                          child: Text(
                                              reasonRefuse[index].toString()),
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
                              enabledBorder: const OutlineInputBorder(
                                // width: 0.0 produces a thin "hairline" border
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
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
                            child: Text(
                              (current == -1 &&
                                      _reasonController.text.trim().isEmpty)
                                  ? "Vui lòng chọn lý do"
                                  : (current == -1 &&
                                          _reasonController.text.trim().length <
                                              7)
                                      ? "Lí do không được ít hơn 6 kí tự"
                                      : "",
                              style:
                                  TxtStyle.heading4.copyWith(color: Colors.red),
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
                                        _reasonController.text.trim().length >
                                            6)) {
                                  setState1(() {
                                    isChooseReason = true;
                                  });
                                  // print(contract.property);

                                  BlocProvider.of<ContractBloc>(context).add(
                                    DeleteContract(
                                      Contract(
                                        status: 0,
                                        id: contract.id,
                                        // appointmentId: widget.appointment.id,
                                        // contactId: 1,
                                        // ownerId: ,

                                        createDate: contract.createDate,
                                        price: contract.price,
                                        ownerId: contract.ownerId,
                                        brandId: contract.brandId,
                                        startDate: contract.startDate,
                                        endDate: DateTime.now(),
                                        paymentTerm: contract.paymentTerm,
                                        brokerId: contract.brokerId,
                                        propertyId: contract.propertyId,
                                        brandRepresentativeAddress:
                                            contract.brandRepresentativeAddress,
                                        brandRepresentativeBirthday: contract
                                            .brandRepresentativeBirthday,
                                        brandRepresentativeCccd:
                                            contract.brandRepresentativeCccd,
                                        brandRepresentativeCccdGrantAddress:
                                            contract
                                                .brandRepresentativeCccdGrantAddress,
                                        brandRepresentativeCccdGrantDate: contract
                                            .brandRepresentativeCccdGrantDate,
                                        brandRepresentativeName:
                                            contract.brandRepresentativeName,
                                        brandRepresentativePhoneNumber: contract
                                            .brandRepresentativePhoneNumber,
                                        contractTerms: contract.contractTerms,
                                        handoverDate: contract.handoverDate,
                                        leaseLength: contract.leaseLength,
                                        lessor: contract.lessor,
                                        lessorAddress: contract.lessorAddress,
                                        lessorBank: contract.lessorBank,
                                        lessorBankAccountNumber:
                                            contract.lessorBankAccountNumber,
                                        lessorBirthDate:
                                            contract.lessorBirthDate,
                                        lessorCccd: contract.lessorCccd,
                                        lessorCccdGrantAddress:
                                            contract.lessorCccdGrantAddress,
                                        lessorCccdGrantDate:
                                            contract.lessorCccdGrantDate,
                                        media: contract.media,
                                        payDay: contract.payDay,
                                        // registrationNumber:
                                        //     contract.registrationNumber,
                                        registrationNumberGrantAddress: contract
                                            .registrationNumberGrantAddress,
                                        registrationNumberGrantDate: contract
                                            .registrationNumberGrantDate,
                                        renterOfficeAddress:
                                            contract.renterOfficeAddress,

                                        reasonCancel: (current != -1)
                                            ? AppFormat.getListDeleteContract()[
                                                    current]
                                                .toString()
                                            : _reasonController.text.trim(),
                                      ),
                                    ),
                                  );

                                  Navigator.pop(context);
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
    );
  }
}
