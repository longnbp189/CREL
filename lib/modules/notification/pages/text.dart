import 'package:flutter/material.dart';

class TextFieldDesignPage extends StatefulWidget {
  const TextFieldDesignPage(
      {Key? key,
      required this.lable,
      required this.name,
      required this.textController})
      : super(key: key);
  final String lable;
  final String name;
  final TextEditingController textController;

  @override
  _TextFieldDesignPageState createState() => _TextFieldDesignPageState();
}

class _TextFieldDesignPageState extends State<TextFieldDesignPage> {
  final FocusNode _focusNode = FocusNode();

  Color _borderColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    // Change color for border if focus was changed
    _focusNode.addListener(() {
      setState(() {
        _borderColor = _focusNode.hasFocus ? Colors.orange : Colors.grey;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: _borderColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextField(
            focusNode: _focusNode,
            style: const TextStyle(color: Colors.grey),
            keyboardType: TextInputType.number,
            controller: widget.textController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              labelText: widget.lable,
            ),
          ),
        ),
      ),
    );
  }
}
