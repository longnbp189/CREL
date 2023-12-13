import 'package:crel_mobile/config/configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class Editor extends StatelessWidget {
  const Editor({
    Key? key,
    required QuillController controller,
  })  : _controller = controller,
        super(key: key);

  final QuillController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: AppColor.boderColor),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          RichText(
            text: TextSpan(
                text: "Mô tả",
                style: TxtStyle.heading4.copyWith(
                    color: AppColor.textColor, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: ' *',
                    style: TxtStyle.heading4.copyWith(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ]),
          ),
          QuillToolbar.basic(
            controller: _controller,
            // multiRowsDisplay: false,
            // showAlignmentButtons: false,
            // showCenterAlignment: false,
            // showBackgroundColorButton: false,
            // showAlignmentButtons: true,
            // showClearFormat: false,
            showBackgroundColorButton: false,
            showColorButton: false,
            showClearFormat: false,
            showLink: false,
            showFontFamily: false,
            showIndent: false,
            showAlignmentButtons: true,
            // showCenterAlignment: true,
            toolbarIconSize: 16,
            showListBullets: false,
            showListNumbers: false,
            showSmallButton: false,
            showFontSize: false,
            showCodeBlock: false,
            showDirection: false,
            showDividers: false,
            showHeaderStyle: false,
            showInlineCode: false,
            showListCheck: false,
            showQuote: false,
            showSearchButton: false,
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(12.5),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(10, 20),
                    blurRadius: 10,
                    spreadRadius: 0,
                    color: Colors.grey.withOpacity(.05)),
              ],
            ),
            child: QuillEditor.basic(
              controller: _controller,
              readOnly: false, // true for view only mode
            ),
          )
        ],
      ),
    );
  }
}
