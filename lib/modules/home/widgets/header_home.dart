import 'package:crel_mobile/config/configs.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text("CREL", style: TxtStyle.heading2),
              ),
              // IconButton(
              //     onPressed: () async {
              //       final result = await FilePicker.platform.pickFiles();
              //       if (result == null) return;

              //       final file = result.files.first;
              //       openFile(file);

              //       print("Name: ${file.name}");
              //       print("Byte: ${file.bytes}");
              //       print("Size: ${file.size}");
              //       print("Extension: ${file.extension}");
              //       print("Path: ${file.path}");
              //     },
              //     icon: const Icon(Icons.fiber_dvr)),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouter.notificationPage);
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   // do something
                    //   return const LoadingSpinner();
                    // }));
                  },
                  icon: const Icon(Icons.notifications_outlined))
            ],
          ),

          // Row(
          //   children: const [
          //     Expanded(
          //         child: SearchBar(
          //       title: "Nhập tên bất động sản bạn mà muốn tìm kiếm!",
          //     )),
          //     Padding(
          //         padding: EdgeInsets.only(left: 8),
          //         child: Icon(
          //           Icons.filter_list_outlined,
          //           color: AppColor.textColor,
          //         )),
          //   ],
          // ),
        ],
      ),
    );
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
}
