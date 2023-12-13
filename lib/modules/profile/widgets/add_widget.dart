import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_required_content_term.dart';
import 'package:crel_mobile/modules/mission/widgets/custom_tff_required_title_term.dart';
import 'package:flutter/material.dart';

class AddWidget extends StatefulWidget {
  const AddWidget({Key? key}) : super(key: key);

  @override
  State<AddWidget> createState() => _AddWidgetState();
}

final _brandRepresentativeNameController = TextEditingController();
final _brandRepresentativeNameController1 = TextEditingController();

class _AddWidgetState extends State<AddWidget> {
  List<bool> isPlus = [];
  List<bool> isPlusChild = [];
  List<TextEditingController> titles = [];
  List<TextEditingController> contents = [];
  bool isOne = false;

  List<Widget> listTerms() {
    List<Widget> widgetTerm = [];
    for (int i = 0; i < isPlus.length; i++) {
      widgetTerm.add(SizedBox(
        width: AppFormat.width(context) - 32,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    // isPlus[1] = false;
                    isPlus.remove(isPlus[i]);
                    titles.remove(titles[i]);
                    contents.remove(contents[i]);
                    // widgetTerm.remove(term);
                  });
                },
                child: const Icon(Icons.close)),
            GestureDetector(
                onTap: () {
                  setState(() {
                    isPlus.add(true);
                    titles.add(TextEditingController()..text = "");
                    contents.add(TextEditingController()..text = "");
                  });
                },
                child: const Icon(Icons.add)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomTFFRequiredTitleTerm(
                            type: TextInputType.name,
                            textController: titles[i],
                            name: "Tiêu đề: ",
                          ),
                          CustomTFFRequiredContentTerm(
                            type: TextInputType.name,
                            textController: contents[i],
                            name: "Nội dung: ",
                          ),
                        ]),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            // setState(() {
                            //   term = false;
                            //   isPlus.remove(term);
                            // });
                          },
                          child: const Icon(Icons.close)),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              isPlusChild.add(true);
                              // isPlusChild[0] = true;
                            });
                          },
                          child: const Icon(Icons.add)),
                      // isPlusChild[0]
                      // ? Column(
                      //     children: listTermsChild(),
                      //   )
                      // : const SizedBox()
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ));
    }
    return widgetTerm;
  }

  List<Widget> listTermsChild() {
    List<Widget> widgetTermChild = [];
    for (var termChild in isPlusChild) {
      widgetTermChild.add(SizedBox(
        width: AppFormat.width(context) - 32 - 64 - 32,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // GestureDetector(
            //     onTap: () {
            //       setState(() {
            //         termChild = false;
            //         // isPlus.remove(term);
            //         // widgetTerm.remove(term);
            //       });
            //     },
            //     child: const Icon(Icons.close)),
            // GestureDetector(
            //     onTap: () {
            //       setState(() {
            //         isPlus.add(true);
            //       });
            //     },
            //     child: const Icon(Icons.add)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomTFFRequiredTitleTerm(
                            type: TextInputType.name,
                            textController: _brandRepresentativeNameController,
                            name: "Tiêu đề: ",
                          ),
                          CustomTFFRequiredContentTerm(
                            type: TextInputType.name,
                            textController: _brandRepresentativeNameController1,
                            name: "Nội dung: ",
                          ),
                        ]),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              termChild = false;
                              isPlusChild.remove(termChild);
                              // isPlus.remove(term);
                            });
                          },
                          child: const Icon(Icons.close)),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              isPlusChild.add(true);
                            });
                          },
                          child: const Icon(Icons.add)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ));
    }
    return widgetTermChild;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            isPlus.isNotEmpty
                ? Column(children: listTerms())
                : InkWell(
                    onTap: () {
                      setState(() {
                        isPlus.add(true);
                        titles.add(TextEditingController()..text = "");
                        contents.add(TextEditingController()..text = "");
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: const Text("Thêm điều khoản"),
                    ),
                  ),
          ],
        ),
      ),
    )));
  }
}
