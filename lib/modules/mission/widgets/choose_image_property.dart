import 'dart:io';

import 'package:crel_mobile/config/app_color.dart';
import 'package:crel_mobile/modules/home/blocs/media/media_bloc.dart';
import 'package:crel_mobile/modules/mission/pages/update_property_page.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ChooseImageProperty extends StatefulWidget {
  const ChooseImageProperty({Key? key, required this.widget}) : super(key: key);

  final UpdatePropetyPage widget;

  @override
  State<ChooseImageProperty> createState() => _ChooseImagePropertyState();
}

class _ChooseImagePropertyState extends State<ChooseImageProperty> {
  late MediaBloc _mediaBloc;
  List<XFile> listImage = [];

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

  List<Widget> listchooesenImage() {
    List<Widget> widgetImage = [];
    widgetImage.add(
      InkWell(
        onTap: () => getImage(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: DottedBorder(
            radius: const Radius.circular(10),
            borderType: BorderType.RRect,
            color: AppColor.primaryColor,
            strokeWidth: 2,
            dashPattern: const [16, 8],
            child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.cardColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: const [
                      Icon(Icons.camera_alt_rounded),
                      Text("asdasdasd")
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
    for (var image in listImage) {
      widgetImage.add(Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          SizedBox(
              height: 120,
              width: 120,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Image.file(File(image.path), fit: BoxFit.cover),
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
    return widgetImage;
  }

  @override
  void initState() {
    _mediaBloc = context.read<MediaBloc>()
      ..add(GetMediaByProperyId(widget.widget.property.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MediaBloc, MediaState>(
      listener: (context, state) {
        if (state is MediaError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("MediaError")));
        }
      },
      builder: (context, state) {
        if (state is MediaLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is MediaLoaded) {
          return Row(
            children: [
              Wrap(
                  direction: Axis.horizontal,
                  runSpacing: 10,
                  spacing: 10,
                  children: listchooesenImage()),
              Wrap(
                direction: Axis.horizontal,
                runSpacing: 10,
                spacing: 10,
                children: const [
                  // InkWell(
                  //   onTap: () => getImage(),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(16),
                  //     child: DottedBorder(
                  //       radius: const Radius.circular(10),
                  //       borderType: BorderType.RRect,
                  //       color: AppColor.primaryColor,
                  //       strokeWidth: 2,
                  //       dashPattern: const [16, 8],
                  //       child: Container(
                  //           height: 120,
                  //           width: 120,
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(10),
                  //             color: AppColor.cardColor,
                  //           ),
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(8.0),
                  //             child: Column(
                  //               children: const [
                  //                 Icon(Icons.camera_alt_rounded),
                  //                 Text("asdasdasd")
                  //               ],
                  //             ),
                  //           )),
                  //     ),
                  //   ),
                  // ),
                  // for (var i in widget.widget.property.media!)
                  //   Stack(
                  //     alignment: AlignmentDirectional.topEnd,
                  //     children: [
                  //       SizedBox(
                  //           height: 120,
                  //           width: 120,
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(16),
                  //             child: Image.network(i.link!, fit: BoxFit.cover),
                  //           )),
                  //       Positioned(
                  //         top: -10,
                  //         right: -8,
                  //         child: IconButton(
                  //             onPressed: () {
                  //               BlocProvider.of<MediaBloc>(context).add(
                  //                   DeleteMedia(
                  //                       i.id!, widget.widget.property.id!));
                  //             },
                  //             icon: const Icon(Icons.cancel)),
                  //       ),
                  //     ],
                  //   )
                ],
              ),
            ],
          );
        } else {
          return Text("$state");
        }
      },
    );
  }
}
