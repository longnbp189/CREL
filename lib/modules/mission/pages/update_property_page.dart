import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crel_mobile/common/widgets/stateful/custom_nav_bar.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:crel_mobile/models/project.dart';
import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
import 'package:crel_mobile/modules/mission/blocs/location/location_bloc.dart';
import 'package:crel_mobile/modules/mission/blocs/project/project_bloc.dart';
import 'package:crel_mobile/modules/mission/widgets/choose_text_from_drop.dart';
import 'package:crel_mobile/modules/mission/widgets/choose_text_from_drop_no_required.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_no_valid.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_required_m.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_required_price.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';

class UpdatePropetyPage extends StatefulWidget {
  final Property property;

  const UpdatePropetyPage({Key? key, required this.property}) : super(key: key);

  @override
  State<UpdatePropetyPage> createState() => _UpdatePropetyPageState();
}

class _UpdatePropetyPageState extends State<UpdatePropetyPage> {
  final _formKey = GlobalKey<FormState>();
  final _locationIdController = TextEditingController();
  final _brokerIdController = TextEditingController();
  final _statusController = TextEditingController();
  final _priceController = TextEditingController();
  final _tagController = TextEditingController();
  final _typeController = TextEditingController();
  final _nameController = TextEditingController();
  final _projectIdController = TextEditingController();
  final _landAreaController = TextEditingController();
  final _floorController = TextEditingController();
  final _floorAreaController = TextEditingController();
  final _areaController = TextEditingController();
  final _frontageController = TextEditingController();
  final _parkingLotController = TextEditingController();
  final _certificatesController = TextEditingController();
  final _directionController = TextEditingController();
  final _verticalController = TextEditingController();
  final _horizontalController = TextEditingController();
  final _roadWidthController = TextEditingController();
  final _rentalConditionsController = TextEditingController();
  final _rentalTermController = TextEditingController();
  final _depositTermController = TextEditingController();
  final _paymentTermController = TextEditingController();
  final _numberOfFrontageController = TextEditingController();
  final _searchController = TextEditingController();
  // quill.QuillController _controller = quill.QuillController.basic();
  HtmlEditorController controller = HtmlEditorController();
  String? selectedItem;

  List<String> listStatus = AppFormat.getListStatusProperty();

  File? image;
  List<XFile> listImage = [];
  List<Media> medias = [];
  late LocationBloc locationBloc;
  late ProjectBloc projectBloc;
  String project = "Dự án";
  String labelProject = "Dự án";
  int? projectId;
  List<Project> listProject = [];
  final _projectNameController = TextEditingController();

  // List<String> certificates = ['Đang chờ sổ', 'Đã có sổ', 'Giấy tờ khác'];
  List<String> listCertificate = [];
  final _certificateNameController = TextEditingController();
  String certificate = "Giấy tờ pháp lý";
  String labelCertificate = "Giấy tờ pháp lý";

  // List<String> parkings = ['Không', 'Có'];
  final _parkingNameController = TextEditingController();
  List<String> listParking = [];
  String parking = "Bãi đỗ xe";
  String labelParking = "Bãi đỗ xe";

  List<String> listDirection = [];
  final _directionNameController = TextEditingController();
  String direction = "Hướng";

  String labelDirection = "Hướng";

  bool floor = true;
  bool vertical = true;
  bool horizontal = true;
  bool roadWidth = true;
  bool frontage = true;
  bool floorArea = true;
  bool area = true;
  bool numberOfFrontAge = true;

  bool isHasImage = true;
  bool isLimited = true;
  bool isRealSquare = true;

  Future getImage() async {
    final pickedFile = await ImagePicker().pickMultiImage();
    setState(() {
      if (pickedFile != null) {
        for (var element in pickedFile) {
          listImage.insert(0, element);
        }
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
                icon: const Icon(Icons.cancel)),
          ),
        ],
      ));
    }
    for (var i in medias) {
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
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: i.link!,
                      // tag: ,
                    )),
              )),
          Positioned(
            top: -10,
            right: -8,
            child: IconButton(
                onPressed: () {
                  setState(() {
                    medias.remove(i);
                  });
                },
                icon: const Icon(Icons.cancel)),
          ),
        ],
      ));
    }
    return widgetImage;
  }

  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();

    // if (widget.property.description != null) {
    //   Future.delayed(const Duration(milliseconds: 2000), () {
    //     setState(() {
    //       controller.setFullScreen();
    //       controller.setText(widget.property.description!);
    //     });
    //   });
    // } else {
    //   Future.delayed(const Duration(milliseconds: 2000), () {
    //     setState(() {
    //       controller.setFullScreen();
    //       controller.setText("");
    //     });
    //   });
    // }

    // locationBloc = context.read<LocationBloc>()
    //   ..add(GetLocationByIdRequested(widget.property.locationId!));
    if (widget.property.projectId != null) {
      _projectNameController.text = widget.property.project!.name.toString();
      projectBloc = context.read<ProjectBloc>()
        ..add(GetProjectByDistrictRequested(
            widget.property.location!.ward!.districtId!));
    } else {
      projectBloc = context.read<ProjectBloc>()
        ..add(GetProjectByDistrictRequested(
            widget.property.location!.ward!.districtId!));
    }
    // if (widget.property.media != null) {
    medias.addAll(widget.property.media!);
    // }
    _locationIdController.text = (widget.property.location == null ||
            widget.property.location!.address == null)
        ? ""
        : AppFormat.getAddress(widget.property);

    // widget.property.location!.address.toString();
    _brokerIdController.text = widget.property.brokerId!.toString();

    selectedItem =
        AppFormat.getListStatusProperty()[widget.property.status != 2 ? 0 : 1];

    // _statusController.text = widget.property.status != 2
    //     ? AppFormat.getListStatusProperty()[0]
    //     : AppFormat.getListStatusProperty()[1];
    _priceController.text = widget.property.price == null
        ? ""
        : AppFormat.changePriceVN(widget.property.price.toString());
    _typeController.text =
        widget.property.type == null ? "" : widget.property.type!.toString();
    _nameController.text =
        widget.property.name == null ? "" : widget.property.name.toString();
    _projectIdController.text = widget.property.projectId == null
        ? ""
        : widget.property.projectId!.toString();
    // _landAreaController.text = widget.property.direction == null
    //     ? "0"
    //     : widget.property.direction!.toString();

    _areaController.text = widget.property.area == null
        ? ""
        : AppFormat.changeMeterVN(widget.property.area!.toString());

    _floorController.text =
        widget.property.floor == null ? "" : widget.property.floor!.toString();
    _floorAreaController.text = widget.property.floorArea == null
        ? ""
        : AppFormat.changeMeterVN(widget.property.floorArea!.toString());
    _frontageController.text = widget.property.frontage == null
        ? ""
        : AppFormat.changeMeterVN(widget.property.frontage!.toString());
    // _parkingLotController.text = widget.property.parkingLot == null
    //     ? "0"
    //     : widget.property.parkingLot!.toString();
    // _parkingNameController.text =
    //     AppFormat.getListParking()[int.parse(_parkingLotController.text)];
    // parkings[];
    _certificatesController.text = widget.property.certificates == null
        ? "0"
        : widget.property.certificates.toString();

    _directionController.text = widget.property.direction == null
        ? ""
        : widget.property.direction.toString();
    _directionNameController.text = _directionController.text != ""
        ? AppFormat.getListDirection()[int.parse(_directionController.text)]
        : "";

    _certificateNameController.text =
        AppFormat.getListCertificate()[int.parse(_certificatesController.text)];
    // certificates[int.parse(_certificatesController.text)];
    _verticalController.text = widget.property.vertical == null
        ? ""
        : AppFormat.changeMeterVN(widget.property.vertical.toString());
    _horizontalController.text = widget.property.horizontal == null
        ? ""
        : AppFormat.changeMeterVN(widget.property.horizontal.toString());
    _roadWidthController.text = widget.property.roadWidth == null
        ? ""
        : AppFormat.changeMeterVN(widget.property.roadWidth.toString());
    _rentalConditionsController.text = widget.property.rentalCondition == null
        ? ""
        : widget.property.rentalCondition.toString();
    _rentalTermController.text = widget.property.rentalTerm == null
        ? ""
        : widget.property.rentalTerm.toString();
    _depositTermController.text = widget.property.depositTerm == null
        ? ""
        : widget.property.depositTerm.toString();
    _paymentTermController.text = widget.property.paymentTerm == null
        ? ""
        : widget.property.paymentTerm.toString();

    _numberOfFrontageController.text = widget.property.numberOfFrontage == null
        ? ""
        : widget.property.numberOfFrontage.toString();
    _searchController.text = "";
    super.initState();
  }
//   Future<void> getTextDescription(){
//  if (widget.property.description != null) {
//       Future.delayed(const Duration(milliseconds: 2000), () {
//         setState(() {
//           controller.setFullScreen();
//          controller.setText(widget.property.description!);
//         });
//       });
//     } else {
//       Future.delayed(const Duration(milliseconds: 2000), () {
//         setState(() {
//           controller.setFullScreen();
//           controller.setText("");
//         });
//       });
//     }
//   }

  callbackDescription() {
    if (widget.property.description != null) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        setState(() {
          controller.setFullScreen();
          controller.setText(widget.property.description!);
        });
      });
    } else {
      Future.delayed(const Duration(milliseconds: 2000), () {
        setState(() {
          controller.setFullScreen();
          controller.setText("");
        });
      });
    }
  }

  @override
  void dispose() {
    _locationIdController.dispose();
    _brokerIdController.dispose();
    _statusController.dispose();
    _priceController.dispose();
    _tagController.dispose();
    _typeController.dispose();
    _nameController.dispose();
    _projectIdController.dispose();
    _landAreaController.dispose();
    _searchController.dispose();
    _floorController.dispose();
    _floorAreaController.dispose();
    _areaController.dispose();
    _frontageController.dispose();
    _parkingNameController.dispose();
    _parkingLotController.dispose();
    _certificateNameController.dispose();
    _certificatesController.dispose();
    _verticalController.dispose();
    _projectNameController.dispose();
    _horizontalController.dispose();
    _roadWidthController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Cập nhật mặt bằng",
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
            centerTitle: true,
            backgroundColor: AppColor.primaryColor,
          ),
          body: SafeArea(
              child: Container(
            color: AppColor.backgroundColor,
            child: BlocListener<PropertyForRentBloc, PropertyForRentState>(
              listener: (context, state) {
                if (state is UpdatedSuccessProperty) {
                  AppFormat.showSnackBar(
                      context, 1, "Cập nhật mặt bằng thành công");
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const CustomNavBar()),
                    (route) => false,
                  );
                }
                if (state is PropertyForRentError) {
                  AppFormat.showSnackBar(
                      context, 0, "Cập nhật mặt bằng thất bại");
                  // Navigator.of(context).pushAndRemoveUntil(
                  //   MaterialPageRoute(
                  //       builder: (context) => const CustomNavBar()),
                  //   (route) => false,
                  // );
                }
              },
              child: BlocBuilder<PropertyForRentBloc, PropertyForRentState>(
                builder: (context, state) {
                  if (state is PropertyForRentLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SingleChildScrollView(
                    controller: _scrollController,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: AppFormat.width(context),
                            color: AppColor.boderColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                "ĐỊA CHỈ BĐS VÀ HÌNH ẢNH",
                                style: TxtStyle.heading5Blue
                                    .copyWith(fontSize: 18),
                              ),
                            ),
                          ),
                          BlocConsumer<ProjectBloc, ProjectState>(
                            listener: (context, state) {
                              if (state is ProjectError) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("ProjectError")));
                              }
                              if (state is ProjectLoaded) {
                                setState(() {
                                  _projectNameController.text =
                                      state.project.name!;
                                });
                              }
                            },
                            builder: (context, state) {
                              if (state is ProjectLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              // if (state is ProjectLoaded) {
                              //   return Padding(
                              //     padding: const EdgeInsets.only(
                              //         top: 16, bottom: 8, left: 16, right: 16),
                              //     child: InkWell(
                              //       onTap: () async {
                              //         FocusManager.instance.primaryFocus
                              //             ?.unfocus();

                              //         setState(() {
                              //           listProject = state.projects;
                              //         });

                              //         // projectBloc = context.read<ProjectBloc>()
                              //         //   ..add(GetProjectByDistrictRequested(
                              //         //       widget.property.location!.ward!
                              //         //           .districtId!));
                              //         _projectNameController.text =
                              //             await (chooseProject(
                              //                     context, state)) ??
                              //                 _projectNameController.text;
                              //         // var prj =
                              //         //     await (chooseProject(context, state)) ??
                              //         //         Project();
                              //         // _projectNameController.text = prj.name ?? "";
                              //         // _projectIdController.text = prj.id.toString();
                              //       },
                              //       child: ChooseTextFromDropNoRequired(
                              //           // textController: labelProject == project
                              //           //     ? _projectIdController.text =
                              //           //         state.project.name!
                              //           //     : _projectIdController.text = project,
                              //           textController: _projectNameController,
                              //           lable: labelProject),
                              //     ),
                              //   );
                              // }
                              if (state is ListProjectLoaded) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16, bottom: 8, left: 16, right: 16),
                                  child: GestureDetector(
                                    onTap: () async {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();

                                      setState(() {
                                        listProject = state.projects;
                                      });
                                      // _projectNameController.text =
                                      //     state.projects.name!;
                                      _projectNameController.text =
                                          await (chooseProjectNotInit(
                                                  context, state)) ??
                                              _projectNameController.text;
                                    },
                                    child: ChooseTextFromDropNoRequired(
                                        // textController: labelProject == project
                                        //     ? _projectIdController.text =
                                        //         state.project.name!
                                        //     : _projectIdController.text = project,
                                        textController: _projectNameController,
                                        lable: labelProject),
                                  ),
                                );
                              }
                              return Text("$state");
                            },
                          ),

                          const SizedBox(
                            height: 16,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ChooseTextFromDrop(
                                isDisable: true,
                                textController: _locationIdController,
                                lable: "Địa chỉ"),
                          ),
                          (medias.isEmpty && listImage.isEmpty)
                              ? InkWell(
                                  onTap: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    getImage();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                                  "Chọn từ 03 đến 10 hình",
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
                                )
                              : Row(
                                  children: [
                                    InkWell(
                                      onTap: () => getImage(),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                        'assets/icons/gallery.svg',
                                                        height: 36,
                                                        color:
                                                            AppColor.textColor),
                                                    Text(
                                                      "Thêm hình",
                                                      style: TxtStyle.heading4
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                          !isHasImage
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 28, bottom: 12),
                                  child: Text(
                                    "Chọn từ 03 đến 10 hình.",
                                    style: TxtStyle.heading5Blue.copyWith(
                                        fontSize: 13, color: Colors.red),
                                  ),
                                )
                              : const SizedBox(),
                          Container(
                            width: AppFormat.width(context),
                            color: AppColor.boderColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                "VỊ TRÍ BẤT ĐỘNG SẢN",
                                style: TxtStyle.heading5Blue
                                    .copyWith(fontSize: 18),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: CustomTFFRequiredM(
                              isDisable: false,
                              isM: 2,
                              type: TextInputType.name,
                              textController: _floorController,
                              name: "Tầng",
                            ),
                            //  CustomTFFNoValidInt(
                            //     type: TextInputType.number,
                            //     textController: _floorController,
                            //     name: "Tầng"),
                          ),

                          Container(
                            width: AppFormat.width(context),
                            color: AppColor.boderColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                "DIỆN TÍCH VÀ GIÁ",
                                style: TxtStyle.heading5Blue
                                    .copyWith(fontSize: 18),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: CustomTFFRequiredM(
                                      isDisable: false,
                                      isM: 0,
                                      type: TextInputType.number,
                                      textController: _verticalController,
                                      name: "Chiều dọc"),
                                ),

                                vertical
                                    ? const SizedBox(
                                        height: 8,
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 28, bottom: 8),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Chiều dọc phải nhỏ hơn 100m",
                                            style: TxtStyle.heading5Blue
                                                .copyWith(
                                                    fontSize: 12,
                                                    color: Colors.red),
                                          ),
                                        ),
                                      ),

                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: CustomTFFRequiredM(
                                      isDisable: false,
                                      isM: 0,
                                      type: TextInputType.number,
                                      textController: _horizontalController,
                                      name: "Chiều ngang"),
                                ),
                                horizontal
                                    ? const SizedBox(
                                        height: 8,
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 28, bottom: 8),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Chiều ngang phải nhỏ hơn 100m",
                                            style: TxtStyle.heading5Blue
                                                .copyWith(
                                                    fontSize: 12,
                                                    color: Colors.red),
                                          ),
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: CustomTFFRequiredM(
                                      isDisable: false,
                                      isM: 0,
                                      type: TextInputType.number,
                                      textController: _roadWidthController,
                                      name: "Lộ giới"),
                                ),
                                roadWidth
                                    ? const SizedBox(
                                        height: 8,
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 28, bottom: 8),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Lộ giới phải nhỏ hơn 100m",
                                            style: TxtStyle.heading5Blue
                                                .copyWith(
                                                    fontSize: 12,
                                                    color: Colors.red),
                                          ),
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: CustomTFFRequiredM(
                                      isDisable: false,
                                      isM: 0,
                                      type: TextInputType.number,
                                      textController: _frontageController,
                                      name: "Mặt tiền"),
                                ),
                                frontage
                                    ? const SizedBox(
                                        height: 8,
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 28, bottom: 8),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Mặt tiền phải nhỏ hơn 100m",
                                            style: TxtStyle.heading5Blue
                                                .copyWith(
                                                    fontSize: 12,
                                                    color: Colors.red),
                                          ),
                                        ),
                                      ),
                                // Padding(
                                //   padding: const EdgeInsets.only(bottom: 16),
                                //   child: InkWell(
                                //     onTap: () async {
                                //       FocusManager.instance.primaryFocus
                                //           ?.unfocus();

                                //       setState(() {
                                //         listParking = AppFormat.getListParking();
                                //       });
                                //       _parkingLotController.text =
                                //           await choseParking(context) ??
                                //               _parkingLotController.text;

                                //       _parkingNameController.text = listParking[
                                //           int.parse(_parkingLotController.text)];
                                //     },
                                //     child: ChooseTextFromDrop(
                                //         // name: labelParking == parking
                                //         //     ? parkings[int.parse(
                                //         //             _parkingLotController.text)]
                                //         //         .toString()
                                //         //     : parkings[int.parse(_parkingLotController
                                //         //             .text = parking)]
                                //         //         .toString(),
                                //         textController: _parkingNameController,
                                //         lable: labelParking),
                                //   ),
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(bottom: 16),
                                //   child: CustomTFFRequired(
                                //       type: TextInputType.name,
                                //       textController: _parkingLotController,
                                //       name: "Bãi đỗ xe"),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: CustomTFFRequiredM(
                                      isDisable: false,
                                      isM: 1,
                                      type: TextInputType.number,
                                      textController: _floorAreaController,
                                      name: "Diện tích sàn"),
                                ),

                                floorArea
                                    ? const SizedBox(
                                        height: 8,
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 28, bottom: 8),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Diện tích sàn phải nhỏ hơn 10 000 m\u00B2",
                                            style: TxtStyle.heading5Blue
                                                .copyWith(
                                                    fontSize: 12,
                                                    color: Colors.red),
                                          ),
                                        ),
                                      ),

                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: CustomTFFRequiredM(
                                      isDisable: false,
                                      isM: 1,
                                      type: TextInputType.number,
                                      textController: _areaController,
                                      name: "Diện tích"),
                                ),

                                area
                                    ? const SizedBox(
                                        height: 8,
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 28, bottom: 8),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Diện tích sàn phải nhỏ hơn 10 000 m\u00B2",
                                            style: TxtStyle.heading5Blue
                                                .copyWith(
                                                    fontSize: 12,
                                                    color: Colors.red),
                                          ),
                                        ),
                                      ),

                                // !isRealSquare
                                //     ? Padding(
                                //         padding:
                                //             const EdgeInsets.only(bottom: 12),
                                //         child: Text(
                                //           "Diện tích sàn không được lớn hơn tích của chiều dài và chiều ngang.",
                                //           style: TxtStyle.heading5Blue.copyWith(
                                //               fontSize: 13,
                                //               color: const Color.fromARGB(
                                //                   255, 228, 0, 0)),
                                //         ),
                                //       )
                                //     : const SizedBox(),
                                // Padding(
                                //   padding: const EdgeInsets.only(bottom: 16),
                                //   child: CustomTFFRequired(
                                //       type: TextInputType.number,
                                //       textController: _landAreaController,
                                //       name: "landArea"),
                                // ),
                                CustomTFFRequiredPrice(
                                    type: TextInputType.number,
                                    textController: _priceController,
                                    name: "Giá"),
                              ],
                            ),
                          ),
                          Container(
                            width: AppFormat.width(context),
                            color: AppColor.boderColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                "TIÊU ĐỀ ĐĂNG TIN VÀ MÔ TẢ CHI TIẾT",
                                style: TxtStyle.heading5Blue
                                    .copyWith(fontSize: 18),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: CustomTFFRequiredM(
                              isDisable: false,
                              isM: 2,
                              type: TextInputType.name,
                              textController: _nameController,
                              name: "Tiêu đề",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 8, left: 16, right: 16),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    width: 1, color: AppColor.boderColor),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12, left: 12),
                                    child: RichText(
                                      text: TextSpan(
                                          text: "Mô tả",
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
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: HtmlEditor(
                                      controller: controller,
                                      callbacks: Callbacks(
                                          onInit: callbackDescription),
                                      //required
                                      htmlEditorOptions:
                                          const HtmlEditorOptions(
                                              // shouldEnsureVisible: true,

                                              // autoAdjustHeight: false,
                                              // hint: "Type you Text here",
                                              // characterLimit: 100
                                              // spellCheck:
                                              // mobileInitialScripts:
                                              // spellCheck: false
                                              ),
                                      htmlToolbarOptions:
                                          const HtmlToolbarOptions(
                                        // initiallyExpanded: true,
                                        defaultToolbarButtons: [
                                          // StyleButtons(),
                                          // FontSettingButtons(),
                                          // ColorButtons(),
                                          // ListButtons(),
                                          // InsertButtons(),
                                          FontButtons(
                                            clearAll: false,
                                            strikethrough: false,
                                            superscript: false,
                                            subscript: false,
                                          ),
                                          ParagraphButtons(
                                            increaseIndent: false,
                                            decreaseIndent: false,
                                            textDirection: false,
                                            lineHeight: false,
                                            caseConverter: false,
                                          )
                                        ],
                                        toolbarType:
                                            ToolbarType.nativeScrollable,
                                      ),
                                      otherOptions: const OtherOptions(
                                          height: 350,
                                          // height: 290,
                                          decoration: BoxDecoration(
                                            // color: Colors.transparent,
                                            // border: Border.fromBorderSide(BorderSide(
                                            //     color: Colors.white, width: 0)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(0)),
                                            // border:
                                            //     Border.fromBorderSide(BorderSide(color: Color(0xffececec), width: 1)),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          !isLimited
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 28, right: 16, bottom: 8),
                                  child: Text(
                                    "Mô tả không được bé hơn 10 kí tự và lớn hơn 100000 kí tự",
                                    style: TxtStyle.heading4
                                        .copyWith(color: Colors.red),
                                  ),
                                )
                              : const SizedBox(
                                  height: 8,
                                ),

                          Container(
                            width: AppFormat.width(context),
                            color: AppColor.boderColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                "THÔNG TIN THÊM",
                                style: TxtStyle.heading5Blue
                                    .copyWith(fontSize: 18),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: CustomTFFNoValid(
                              type: TextInputType.name,
                              textController: _rentalConditionsController,
                              name: "Điều kiện cho thuê",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 16, left: 16, bottom: 16),
                            child: CustomTFFNoValid(
                              type: TextInputType.name,
                              textController: _rentalTermController,
                              name: "Thời hạn cho thuê",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 16, left: 16, bottom: 16),
                            child: CustomTFFNoValid(
                              type: TextInputType.name,
                              textController: _depositTermController,
                              name: "Thời hạn đặt cọc",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 16, left: 16, bottom: 8),
                            child: CustomTFFRequiredM(
                                isDisable: false,
                                isM: 3,
                                type: TextInputType.number,
                                textController: _numberOfFrontageController,
                                name: "Số mặt tiền"),
                          ),
                          numberOfFrontAge
                              ? const SizedBox(
                                  height: 8,
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 28, bottom: 8),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Số mặt tiền không được vượt quá 3",
                                      style: TxtStyle.heading5Blue.copyWith(
                                          fontSize: 12, color: Colors.red),
                                    ),
                                  ),
                                ),

                          Padding(
                            padding: const EdgeInsets.only(
                                right: 16, left: 16, bottom: 16),
                            child: CustomTFFRequiredM(
                              isDisable: false,
                              isM: 2,
                              type: TextInputType.name,
                              textController: _paymentTermController,
                              name: "Chính sách thanh toán",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 16, left: 16, bottom: 16),
                            child: InkWell(
                              onTap: () async {
                                FocusManager.instance.primaryFocus?.unfocus();

                                setState(() {
                                  // listCertificate = certificates;
                                  listCertificate =
                                      AppFormat.getListCertificate();
                                });
                                _certificatesController.text =
                                    await choseCertificate(context) ??
                                        _certificatesController.text;

                                _certificateNameController.text =
                                    listCertificate[int.parse(
                                        _certificatesController.text)];
                              },
                              child: ChooseTextFromDrop(
                                  isDisable: false,

                                  // name: labelCertificate == certificate
                                  //     ? certificates[
                                  //             int.parse(_certificatesController.text)]
                                  //         .toString()
                                  //     : certificates[int.parse(_certificatesController
                                  //             .text = certificate)]
                                  //         .toString(),
                                  textController: _certificateNameController,
                                  lable: labelCertificate),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(
                              right: 16,
                              left: 16,
                            ),
                            child: InkWell(
                              onTap: () async {
                                FocusManager.instance.primaryFocus?.unfocus();

                                setState(() {
                                  listDirection = AppFormat.getListDirection();
                                });
                                _directionController.text =
                                    await choseDirection(context) ??
                                        _directionController.text;
                                _directionController.text != ""
                                    ? _directionNameController.text =
                                        listDirection[int.parse(
                                            _directionController.text)]
                                    : _directionNameController.text = "";
                              },
                              child: ChooseTextFromDrop(
                                  isDisable: false,
                                  textController: _directionNameController,
                                  lable: labelDirection),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    // SizedBox(
                                    //   height: AppFormat
                                    //           .heightWithoutAppBarAndStatusbar(
                                    //               context) *
                                    //       0.02,
                                    // ),

                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      // width: AppFormat.width(context),
                                      // height: 42,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: AppColor.boderColor)),
                                      child: PopupMenuButton<String>(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        constraints: BoxConstraints(
                                          // minWidth: 2.0 * 56.0,
                                          maxWidth:
                                              AppFormat.width(context) - 20,

                                          // maxWidth: MediaQuery.of(context).size.width,
                                        ),
                                        initialValue: selectedItem,
                                        onSelected: (val) =>
                                            setState(() => selectedItem = val),
                                        child: ListTile(
                                          dense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 0),
                                          title: Text(selectedItem!,
                                              style: TxtStyle.heading4),
                                        ),
                                        itemBuilder: (BuildContext context) {
                                          return listStatus
                                              .map(
                                                (e) => PopupMenuItem<String>(
                                                  value: e,
                                                  child: SizedBox(
                                                    width: AppFormat.width(
                                                        context),
                                                    child: selectedItem == e
                                                        ? Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(e,
                                                                  style: TxtStyle
                                                                      .heading4),
                                                              const FaIcon(
                                                                  FontAwesomeIcons
                                                                      .check)
                                                            ],
                                                          )
                                                        : SizedBox(
                                                            width:
                                                                AppFormat.width(
                                                                    context),

                                                            // width: 10000,
                                                            child: Text(e,
                                                                style: TxtStyle
                                                                    .heading4)),
                                                  ),
                                                ),
                                              )
                                              .toList();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  left: 6,
                                  top: 11,
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: RichText(
                                        text: TextSpan(
                                            text: "Trạng thái",
                                            style: TxtStyle.heading4.copyWith(
                                                color: AppColor.textColor,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold),
                                            children: [
                                              TextSpan(
                                                text: ' *',
                                                style: TxtStyle.heading4
                                                    .copyWith(
                                                        color: Colors.red,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 32,
                          ),

                          // Container(
                          //   width: AppFormat.width(context),
                          //   color: AppColor.boderColor,
                          //   child: Padding(
                          //     padding: const EdgeInsets.symmetric(
                          //         horizontal: 16, vertical: 8),
                          //     child: Text(
                          //       "VỀ NGƯỜI BÁN",
                          //       style: TxtStyle.heading5Blue.copyWith(fontSize: 18),
                          //     ),
                          //   ),
                          // ),
                          // CustomTFFUpdateValidEmpty(
                          // textController: _tagController, name: "Th"),
                          // CustomTFFUpdateValidEmpty(
                          // textController: _typeController, name: "type"),

                          // const ChooseAddressPage(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: SizedBox(
                              width: AppFormat.width(context),
                              child: ElevatedButton(
                                style: TxtStyle.buttonBlue,
                                onPressed: () async {
                                  var text = await controller.getText();
                                  if (2 < (medias.length + listImage.length) &&
                                      (medias.length + listImage.length) < 11) {
                                    setState(() {
                                      isHasImage = true;
                                    });
                                  } else {
                                    setState(() {
                                      isHasImage = false;
                                    });
                                  }
                                  // if (_verticalController.text.isNotEmpty &&
                                  //     _horizontalController.text.isNotEmpty &&
                                  //     _floorAreaController.text.isNotEmpty) {
                                  //   if (double.parse(AppFormat.saveMeterVN(
                                  //               _verticalController.text)) *
                                  //           double.parse(AppFormat.saveMeterVN(
                                  //               _horizontalController.text)) <
                                  //       double.parse(AppFormat.saveMeterVN(
                                  //           _floorAreaController.text))) {
                                  //     setState(() {
                                  //       isRealSquare = false;
                                  //     });
                                  //   } else {
                                  //     setState(() {
                                  //       isRealSquare = true;
                                  //     });
                                  //   }
                                  // }

                                  if (text.length > 10 &&
                                      text.length < 100000) {
                                    setState(() {
                                      isLimited = true;
                                    });
                                  } else {
                                    setState(() {
                                      isLimited = false;
                                    });
                                  }

                                  if (_formKey.currentState!.validate()) {
                                    if (double.parse(AppFormat.saveMeterVN(
                                            _floorAreaController.text)) >=
                                        10000) {
                                      setState(() {
                                        floorArea = false;
                                      });
                                    } else {
                                      setState(() {
                                        floorArea = true;
                                      });
                                    }

                                    if (double.parse(AppFormat.saveMeterVN(
                                            _areaController.text)) >=
                                        10000) {
                                      setState(() {
                                        area = false;
                                      });
                                    } else {
                                      setState(() {
                                        area = true;
                                      });
                                    }
                                    if (_numberOfFrontageController.text !=
                                        "") {
                                      if (int.parse(_numberOfFrontageController
                                                  .text) >
                                              3 ||
                                          int.parse(_numberOfFrontageController
                                                  .text) <
                                              0) {
                                        setState(() {
                                          numberOfFrontAge = false;
                                        });
                                      } else {
                                        setState(() {
                                          numberOfFrontAge = true;
                                        });
                                      }
                                    }

                                    if (double.parse(AppFormat.saveMeterVN(
                                            _verticalController.text)) >=
                                        100) {
                                      setState(() {
                                        vertical = false;
                                      });
                                    } else {
                                      setState(() {
                                        vertical = true;
                                      });
                                    }

                                    if (double.parse(AppFormat.saveMeterVN(
                                            _horizontalController.text)) >=
                                        100) {
                                      setState(() {
                                        horizontal = false;
                                      });
                                    } else {
                                      setState(() {
                                        horizontal = true;
                                      });
                                    }

                                    if (double.parse(AppFormat.saveMeterVN(
                                            _roadWidthController.text)) >=
                                        100) {
                                      setState(() {
                                        roadWidth = false;
                                      });
                                    } else {
                                      setState(() {
                                        roadWidth = true;
                                      });
                                    }

                                    if (double.parse(AppFormat.saveMeterVN(
                                            _frontageController.text)) >=
                                        100) {
                                      setState(() {
                                        frontage = false;
                                      });
                                    } else {
                                      setState(() {
                                        frontage = true;
                                      });
                                    }

                                    if (isHasImage &&
                                        // isRealSquare &&
                                        area &&
                                        isLimited &&
                                        horizontal &&
                                        vertical &&
                                        floorArea &&
                                        frontage &&
                                        numberOfFrontAge &&
                                        roadWidth) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      BlocProvider.of<PropertyForRentBloc>(context)
                                          .add(UpdateProperty(
                                              Property(
                                                  id: widget.property.id,
                                                  locationId: widget
                                                      .property.locationId,
                                                  brokerId:
                                                      widget.property.brokerId,
                                                  createDate: widget
                                                      .property.createDate,
                                                  // lastUpdateDate: DateTime.now(),
                                                  status: selectedItem ==
                                                          AppFormat.getListStatusProperty()[
                                                              0]
                                                      ? 1
                                                      : 2,
                                                  price: double.parse(AppFormat.savePrice(_priceController.text)) *
                                                      1000000,
                                                  // description: widget.property
                                                  //     .quillDeltaToHtml(
                                                  //         _controller.document.toDelta()),
                                                  // industryProperties: widget
                                                  //     .property
                                                  //     .industryProperties,
                                                  description: await controller
                                                      .getText(),
                                                  owners:
                                                      widget.property.owners,
                                                  area: double.parse(
                                                      AppFormat.saveMeterVN(
                                                          _areaController.text
                                                              .trim())),

                                                  // jsonEncode(_controller
                                                  //     .document
                                                  //     .toDelta()
                                                  //     .toJson()),

                                                  // tag: _tagController.text.trim(),
                                                  rejectReason:
                                                      widget.property.rejectReason,
                                                  type: int.parse(_typeController.text),
                                                  name: _nameController.text.trim(),
                                                  projectId: projectId,
                                                  direction: int.parse(_directionController.text),
                                                  floor: _floorController.text,
                                                  floorArea: double.parse(AppFormat.saveMeterVN(_floorAreaController.text)),
                                                  frontage: double.parse(AppFormat.saveMeterVN(_frontageController.text)),
                                                  // parkingLot: int.parse(_parkingLotController.text),
                                                  certificates: int.parse(_certificatesController.text),
                                                  vertical: double.parse(AppFormat.saveMeterVN(_verticalController.text)),
                                                  horizontal: double.parse(AppFormat.saveMeterVN(_horizontalController.text)),
                                                  roadWidth: double.parse(AppFormat.saveMeterVN(_roadWidthController.text)),
                                                  depositTerm: _depositTermController.text.trim(),
                                                  paymentTerm: _paymentTermController.text.trim(),
                                                  rentalCondition: _rentalConditionsController.text.trim(),
                                                  rentalTerm: _rentalTermController.text.trim(),
                                                  numberOfFrontage: int.parse(_numberOfFrontageController.text)),
                                              listImage,
                                              medias,
                                              widget.property.media));
                                    }

                                    // var json = jsonEncode(
                                    //     _controller.document.toDelta().toJson());
                                    // var a = _controller.document.toDelta().toString();

                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Text(
                                    'Cập nhật mặt bằng',
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
                      ),
                    ),
                  );
                },
              ),
            ),
          ))
          // ),
          ),
    );
  }

  Future<String?> choseCertificate(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState1) => DraggableScrollableSheet(
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
                              _searchController.clear();
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.close)),
                        Text(
                          labelCertificate,
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
                  // const SearchBarBrand(
                  //     title: "Nhập từ khóa để lọc"),

                  Container(
                    height: 40,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(width: 1, color: AppColor.boderColor)),
                    child: TextField(
                      onChanged: (value) {
                        setState1(() {
                          listCertificate = AppFormat.getListCertificate()
                              .where((certificateName) => certificateName
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                      controller: _searchController,
                      cursorColor: AppColor.secondColor,
                      style: const TextStyle(color: AppColor.secondColor),
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        // hintText: "Nhập",
                        hintStyle: TxtStyle.heading5Gray,
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColor.textColor,
                          size: 24,
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: listCertificate.length,
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                certificate = index.toString();

                                _searchController.clear();
                              });
                              Navigator.pop(context, index.toString());
                            },
                            child: Container(
                              decoration: const BoxDecoration(
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
                                    listCertificate[index].toString(),
                                    style: TxtStyle.heading4,
                                  )),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<String?> choseDirection(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState1) => DraggableScrollableSheet(
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
                              _searchController.clear();
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.close)),
                        Text(
                          labelDirection,
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
                  // const SearchBarBrand(
                  //     title: "Nhập từ khóa để lọc"),

                  // Container(
                  //   height: 40,
                  //   alignment: Alignment.centerLeft,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       border:
                  //           Border.all(width: 1, color: AppColor.boderColor)),
                  //   child: TextField(
                  //     onChanged: (value) {
                  //       setState1(() {
                  //         listDirection = AppFormat.getListDirection()
                  //             .where((directionName) => directionName
                  //                 .toLowerCase()
                  //                 .contains(value.toLowerCase()))
                  //             .toList();
                  //       });
                  //     },
                  //     controller: _searchController,
                  //     cursorColor: AppColor.secondColor,
                  //     style: const TextStyle(color: AppColor.secondColor),
                  //     decoration: const InputDecoration(
                  //       isDense: true,
                  //       border: InputBorder.none,
                  //       // hintText: "Nhập",
                  //       hintStyle: TxtStyle.heading5Gray,
                  //       prefixIcon: Icon(
                  //         Icons.search,
                  //         color: AppColor.textColor,
                  //         size: 24,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Expanded(
                    child: ListView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: listDirection.length,
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                direction = index.toString();

                                _searchController.clear();
                              });
                              Navigator.pop(context, index.toString());
                            },
                            child: Container(
                              decoration: const BoxDecoration(
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
                                    listDirection[index].toString(),
                                    style: TxtStyle.heading4,
                                  )),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<String?> choseParking(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState1) => DraggableScrollableSheet(
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
                              _searchController.clear();
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.close)),
                        Text(
                          labelParking,
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
                  // const SearchBarBrand(
                  //     title: "Nhập từ khóa để lọc"),

                  Container(
                    height: 40,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(width: 1, color: AppColor.boderColor)),
                    child: TextField(
                      onChanged: (value) {
                        setState1(() {
                          listParking = AppFormat.getListParking()
                              .where((parkingName) => parkingName
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                      controller: _searchController,
                      cursorColor: AppColor.secondColor,
                      style: const TextStyle(color: AppColor.secondColor),
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        // hintText: "Nhập",
                        hintStyle: TxtStyle.heading5Gray,
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColor.textColor,
                          size: 24,
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: listParking.length,
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                parking = index.toString();

                                _searchController.clear();
                              });
                              Navigator.pop(context, index.toString());
                            },
                            child: Container(
                              decoration: const BoxDecoration(
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
                                    listParking[index].toString(),
                                    style: TxtStyle.heading4,
                                  )),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<String?> chooseProject(BuildContext context, ProjectLoaded state) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState1) => DraggableScrollableSheet(
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
                              _searchController.clear();
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.close)),
                        Text(
                          "Nhập tên dự án",
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
                  // const SearchBarBrand(
                  //     title: "Nhập từ khóa để lọc"),

                  Container(
                    height: 40,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: AppColor.boderColor)),
                    child: TextField(
                      onChanged: (value) {
                        setState1(() {
                          listProject = state.projects
                              .where((projectName) => projectName.name!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                      controller: _searchController,
                      cursorColor: AppColor.secondColor,
                      style: const TextStyle(color: AppColor.secondColor),
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColor.textColor,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        // _projectIdController.text =
                        //     "null";
                        projectId = null;
                        _projectNameController.text = "";
                        _searchController.clear();
                      });
                      Navigator.pop(context, "");
                    },
                    child: Container(
                      width: AppFormat.width(context),
                      decoration: const BoxDecoration(
                          border: Border(
                        top: BorderSide(
                          color: AppColor.boderColor,
                          // width: 1,
                        ),
                        bottom: BorderSide(
                          color: AppColor.boderColor,
                          // width: 1,
                        ),
                      )),
                      child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text(
                            "Không",
                            style: TxtStyle.heading4,
                          )),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: listProject.length,
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _projectIdController.text =
                                    listProject[index].id.toString();
                                projectId = listProject[index].id!;
                                _projectNameController.text =
                                    listProject[index].name!;
                                _searchController.clear();
                              });
                              Navigator.pop(context, listProject[index].name);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
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
                                    listProject[index].name.toString(),
                                    style: TxtStyle.heading4,
                                  )),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<String?> chooseProjectNotInit(
      BuildContext context, ListProjectLoaded state) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState1) => DraggableScrollableSheet(
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
                              _searchController.clear();
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.close)),
                        Text(
                          "Nhập tên dự án",
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
                  // const SearchBarBrand(
                  //     title: "Nhập từ khóa để lọc"),

                  Container(
                    height: 40,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: AppColor.boderColor)),
                    child: TextField(
                      onChanged: (value) {
                        setState1(() {
                          listProject = state.projects
                              .where((projectName) => projectName.name!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                      controller: _searchController,
                      cursorColor: AppColor.secondColor,
                      style: const TextStyle(color: AppColor.secondColor),
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColor.textColor,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        // _projectIdController.text =
                        //     "null";
                        projectId = null;
                        _projectNameController.text = "";
                        _searchController.clear();
                      });
                      Navigator.pop(context, "");
                    },
                    child: Container(
                      width: AppFormat.width(context),
                      decoration: const BoxDecoration(
                          border: Border(
                        top: BorderSide(
                          color: AppColor.boderColor,
                          // width: 1,
                        ),
                        bottom: BorderSide(
                          color: AppColor.boderColor,
                          // width: 1,
                        ),
                      )),
                      child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text(
                            "Không",
                            style: TxtStyle.heading4,
                          )),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        // physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: listProject.length,
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _projectIdController.text =
                                    listProject[index].name!;
                                projectId = listProject[index].id!;
                                _projectNameController.text =
                                    listProject[index].name!;
                                _searchController.clear();
                              });
                              Navigator.pop(context, listProject[index].name!);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
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
                                    listProject[index].name.toString(),
                                    style: TxtStyle.heading4,
                                  )),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          );
        });
  }
}
