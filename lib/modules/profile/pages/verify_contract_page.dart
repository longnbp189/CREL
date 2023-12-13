import 'dart:io';

import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/contract.dart';
import 'package:crel_mobile/modules/appointment/blocs/contract/contract_bloc.dart';
import 'package:crel_mobile/modules/appointment/pages/create_appointment_page%20copy.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class VerifyContractPage extends StatefulWidget {
  final Contract contract;
  const VerifyContractPage({Key? key, required this.contract})
      : super(key: key);

  @override
  State<VerifyContractPage> createState() => _VerifyContractPageState();
}

class _VerifyContractPageState extends State<VerifyContractPage> {
  File? image;
  List<XFile> listImage = [];
  bool isHasImage = true;

  Future getImage() async {
    final pickedFile = await ImagePicker().pickMultiImage();
    setState(() {
      if (pickedFile != null) {
        for (var element in pickedFile) {
          listImage.insert(0, element);
        }
        isHasImage = true;
        print("sadasd");
      } else {
        print('No image selected.');
      }
    });
  }

  List<Widget> listchoseImage() {
    List<Widget> widgetImage = [];
    for (var image in listImage) {
      widgetImage.add(Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          SizedBox(
              height: 120,
              width: 120,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(File(image.path), fit: BoxFit.cover)),
              )),
          Positioned(
            top: -10,
            right: -8,
            child: IconButton(
                onPressed: () {
                  setState(() {
                    listImage.remove(image);
                  });
                },
                icon: const DeleteItemIcon()),
          ),
        ],
      ));
    }

    return widgetImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Xác thực hợp đồng",
          style: TxtStyle.textAppBar,
        ),
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          color: AppColor.backgroundColor,
          child: BlocListener<ContractBloc, ContractState>(
            listener: (context, state) {
              if (state is ContractUpdateImageSuccess) {
                AppFormat.showSnackBar(context, 1, "Cập nhật thành công");
                Navigator.pop(context);
              }
            },
            child: BlocBuilder<ContractBloc, ContractState>(
              builder: (context, state) {
                if (state is ContractLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  children: [
                    Container(
                      width: AppFormat.width(context),
                      color: AppColor.boderColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                          "HÌNH ẢNH",
                          style: TxtStyle.heading5Blue.copyWith(fontSize: 18),
                        ),
                      ),
                    ),
                    (listImage.isEmpty)
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: InkWell(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                getImage();
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: DottedBorder(
                                  radius: const Radius.circular(10),
                                  borderType: BorderType.RRect,
                                  color: AppColor.textColor,
                                  strokeWidth: 2,
                                  dashPattern: const [16, 8],
                                  child: Container(
                                      height: AppFormat
                                              .heightWithoutAppBarAndStatusbar(
                                                  context) *
                                          0.12,
                                      width: AppFormat.width(context),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColor.cardColor,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                'assets/icons/gallery.svg',
                                                height: 48,
                                                color: AppColor.textColor),
                                            Text(
                                              "Chọn từ 01 đến 10 hình cho hợp đồng",
                                              style: TxtStyle.heading4.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.textColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () => getImage(),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: DottedBorder(
                                      radius: const Radius.circular(10),
                                      borderType: BorderType.RRect,
                                      color: AppColor.textColor,
                                      strokeWidth: 2,
                                      dashPattern: const [16, 8],
                                      child: Container(
                                          height: AppFormat
                                                  .heightWithoutAppBarAndStatusbar(
                                                      context) *
                                              0.12,
                                          width: AppFormat
                                                  .heightWithoutAppBarAndStatusbar(
                                                      context) *
                                              0.13,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppColor.cardColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                    'assets/icons/gallery.svg',
                                                    height: 36,
                                                    color: AppColor.textColor),
                                                Text(
                                                  "Thêm hình",
                                                  style: TxtStyle.heading4
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColor
                                                              .textColor),
                                                )
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(children: listchoseImage()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    !isHasImage
                        ? Padding(
                            padding: const EdgeInsets.only(
                                bottom: 12, left: 24, right: 16),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Chọn từ 01 đến 10 hình.",
                                style: TxtStyle.heading5Blue
                                    .copyWith(fontSize: 12, color: Colors.red),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: SizedBox(
                        width: AppFormat.width(context),
                        child: ElevatedButton(
                          style: TxtStyle.buttonBlue,
                          onPressed: () async {
                            if (listImage.isNotEmpty &&
                                (listImage.length) < 11) {
                              setState(() {
                                isHasImage = true;
                              });
                            } else {
                              setState(() {
                                isHasImage = false;
                              });
                            }
                            if (isHasImage) {
                              widget.contract.status = 2;
                              // widget.contract.property!.status = 3;
                              BlocProvider.of<ContractBloc>(context).add(
                                  UpdateImageContract(widget.contract,
                                      listImage, widget.contract.id!));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              'Xác thực',
                              style: TxtStyle.heading3
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
