import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/modules/mission/blocs/district/district_bloc.dart';
import 'package:crel_mobile/modules/mission/blocs/ward/ward_bloc.dart';
import 'package:crel_mobile/modules/mission/widgets/choose_text_from_drop.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_no_valid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseAddressPage extends StatefulWidget {
  const ChooseAddressPage({Key? key}) : super(key: key);
  @override
  State<ChooseAddressPage> createState() => _ChooseAddressPageState();
}

class _ChooseAddressPageState extends State<ChooseAddressPage> {
  final _streetController = TextEditingController();
  final _districtController = TextEditingController();
  final _wardController = TextEditingController();
  final _streetFinalController = TextEditingController();
  String district = "Quận, huyện, xã";
  String nameDistrict = "Quận, huyện, xã";

  String ward = "Phường, xã, thị trấn";
  String nameWard = "Phường, xã, thị trấn";
  String nameStreet = "Địa chỉ cụ thể";
  String streetFinal = "Địa chỉ";
  String nameStreetFinal = "Địa chỉ";

  bool isDistrict = false;
  bool isWard = false;
  late WardBloc wardBloc;
  @override
  void initState() {
    _streetController.text = "";
    _streetFinalController.text = "";
    _districtController.text = "";
    _wardController.text = "";
    super.initState();
  }

  @override
  void dispose() {
    _streetController.dispose();
    _streetFinalController.dispose();
    _districtController.dispose();
    _wardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          _streetFinalController.text = (await showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: ((context) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: SizedBox(
                        height:
                            AppFormat.heightWithoutStatusbar(context) * 0.43,
                        child: Scaffold(
                          body: StatefulBuilder(builder: (context, setState1) {
                            return Wrap(
                              children: [
                                Container(
                                  color: AppColor.boderColor,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          icon: const Icon(Icons.close)),
                                      Text(
                                        "Địa chỉ",
                                        style: TxtStyle.heading4.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const IconButton(
                                          onPressed: null,
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.transparent,
                                          ))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          _districtController.text =
                                              await getDistrictMethod(
                                                      context, setState1) ??
                                                  "";
                                        },
                                        child: ChooseTextFromDrop(
                                            isDisable: false,
                                            textController: _districtController,
                                            lable: nameDistrict),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          isDistrict
                                              ? _wardController.text =
                                                  await getWardMethod(
                                                          context, setState1) ??
                                                      ""
                                              : ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  content: Text(
                                                      "Vui lòng chọn quận, huyện, thị xã"),
                                                ));
                                        },
                                        child: ChooseTextFromDrop(
                                            isDisable: false,
                                            textController: _wardController,
                                            lable: nameWard),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          isWard
                                              ? getWardMethod(
                                                  context, setState1)
                                              : ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  content: Text(
                                                      "Vui lòng chọn phường, xã, thị trấn"),
                                                ));
                                        },
                                        child: CustomTFFNoValid(
                                            type: TextInputType.name,
                                            textController: _streetController,
                                            name: nameStreet),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    children: [
                                      // const SizedBox(),
                                      Expanded(
                                          child: (isDistrict && isWard)
                                              ? ElevatedButton(
                                                  style: TxtStyle.buttonBlue,
                                                  onPressed: () {
                                                    setState(() {});
                                                    (_streetController.text ==
                                                            "")
                                                        ? Navigator.pop(
                                                            context,
                                                            _wardController
                                                                    .text +
                                                                ", " +
                                                                _districtController
                                                                    .text)
                                                        : Navigator.pop(
                                                            context,
                                                            _streetController
                                                                    .text +
                                                                ", " +
                                                                _wardController
                                                                    .text +
                                                                ", " +
                                                                _districtController
                                                                    .text);
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 16),
                                                    child: Text(
                                                      "Hoàn thành",
                                                      style: TxtStyle.heading3
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ))
                                              : ElevatedButton(
                                                  style: TxtStyle.buttonGray,
                                                  onPressed: null,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 16),
                                                    child: Text(
                                                      "Hoàn thành",
                                                      style: TxtStyle.heading3
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ))),
                                      // SizedBox()
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    );
                  }))) ??
              "";
        },
        child: ChooseTextFromDrop(
          isDisable: false,
          textController: _streetFinalController,
          lable: nameStreetFinal,
        ));
  }

  Future<dynamic> getDistrictMethod(
      BuildContext context, StateSetter setState1) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return DraggableScrollableSheet(
            expand: false,
            builder: (context, scrollController) => Column(
              children: [
                Container(
                  color: AppColor.boderColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close)),
                      Text(
                        "Chọn quận, huyện, thị xã",
                        style: TxtStyle.heading4
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.close,
                            color: Colors.transparent,
                          )),
                    ],
                  ),
                ),
                // const SearchBarBrand(title: "Nhập từ khóa để lọc"),
                BlocConsumer<DistrictBloc, DistrictState>(
                  listener: (context, state) {
                    if (state is DistrictError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("DistrictError")));
                    }
                  },
                  builder: (context, state) {
                    if (state is DistrictLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is DistrictLoaded) {
                      return Expanded(
                        child: ListView.builder(
                            // physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.districts.length,
                            controller: scrollController,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState1(() {
                                    isDistrict = true;
                                    _districtController.text =
                                        state.districts[index].name!;
                                  });
                                  wardBloc = context.read<WardBloc>()
                                    ..add(GetWardByDistrictIdRequested(
                                        state.districts[index].id!));
                                  Navigator.pop(
                                      context, _districtController.text);
                                  getWardMethod(context, setState1);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                    top: BorderSide(
                                      color: AppColor.boderColor,
                                      width: 1,
                                    ),
                                    bottom: BorderSide(
                                      color: AppColor.boderColor,
                                      width: 1,
                                    ),
                                  )),
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      child: Text(
                                        state.districts[index].name.toString(),
                                        style: TxtStyle.heading4,
                                      )),
                                ),
                              );
                            }),
                      );
                    } else {
                      return Text("$state");
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<dynamic> getWardMethod(BuildContext context, StateSetter setState1) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          //scroll listview in showModalBottomSheet
          return DraggableScrollableSheet(
            expand: false,
            builder: (context, scrollController) => Column(
              children: [
                Container(
                  color: AppColor.boderColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close)),
                      Text(
                        "Chọn phường, xã, thị trấn",
                        style: TxtStyle.heading4
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.close,
                            color: Colors.transparent,
                          )),
                    ],
                  ),
                ),
                // const SearchBarBrand(title: "Nhập từ khóa để lọc"),
                BlocConsumer<WardBloc, WardState>(
                  listener: (context, state) {
                    if (state is WardError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("WardError")));
                    }
                  },
                  builder: (context, state) {
                    if (state is WardLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is WardLoaded) {
                      return Expanded(
                        child: ListView.builder(
                            // physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.ward.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState1(() {
                                    isWard = true;
                                    _wardController.text =
                                        state.ward[index].name!;
                                  });
                                  Navigator.pop(context, _wardController.text);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                    top: BorderSide(
                                      color: AppColor.boderColor,
                                      width: 1,
                                    ),
                                    bottom: BorderSide(
                                      color: AppColor.boderColor,
                                      width: 1,
                                    ),
                                  )),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    child: Text(
                                      state.ward[index].name.toString(),
                                      style: TxtStyle.heading4,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    } else {
                      return Text("$state");
                    }
                  },
                )
              ],
            ),
          );
        });
  }
}
