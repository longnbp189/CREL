import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/modules/home/blocs/brand/brand_bloc.dart';
import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchWithButton extends StatefulWidget {
  const SearchWithButton(
      {Key? key,
      required TextEditingController textController,
      // required this.child,
      required this.bloc,
      required this.status,
      required this.hintText})
      : _textController = textController,
        super(key: key);

  final TextEditingController _textController;
  final String hintText;
  final Bloc bloc;
  final int status;
  // final Widget child;

  @override
  State<SearchWithButton> createState() => _SearchWithButtonState();
}

class _SearchWithButtonState extends State<SearchWithButton> {
  FocusNode focus = FocusNode();
  @override
  void initState() {
    focus.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchRealTime(
            focus: focus,
            widget: widget,
            bloc: widget.bloc,
          ),
        ),
        GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            if (widget.bloc is PropertyForRentBloc) {
              widget.bloc.add(SearchProperty(
                  name: widget._textController.text.trim(),
                  status: widget.status));
            }
            if (widget.bloc is BrandBloc) {
              widget.bloc
                  .add(SearchBrand(name: widget._textController.text.trim()));
            }
            // BlocProvider.of<PropertyForRentBloc>(context).add(
            //     SearchProperty(name: widget._textController.text, status: 2));
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColor.boderColor),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: FaIcon(FontAwesomeIcons.magnifyingGlass,
                      size: 16, color: AppColor.primaryColor),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SearchRealTime extends StatelessWidget {
  const SearchRealTime({
    Key? key,
    required this.focus,
    required this.widget,
    required this.bloc,
    // required this.widget,
    // required this.widget,
  }) : super(key: key);

  final FocusNode focus;
  final SearchWithButton widget;
  // final Bloc bloc;
  final Bloc bloc;
  // final SearchWithButton widget;
  // final SearchWithButton widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: TextField(
        focusNode: focus,
        textAlign: TextAlign.start,
        controller: widget._textController,
        cursorColor: AppColor.secondColor,
        textAlignVertical: TextAlignVertical.center,
        style: TxtStyle.heading5Blue
            .copyWith(fontWeight: FontWeight.normal, fontSize: 14),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 0, top: 0, left: 10),
          // floatingLabelBehavior: FloatingLabelBehavior.never,
          isDense: true,
          enabledBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: AppColor.boderColor,
            ),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              widget._textController.clear();
              FocusManager.instance.primaryFocus?.unfocus();
              if (bloc is PropertyForRentBloc) {
                bloc.add(SearchProperty(name: "", status: widget.status));
              }
              if (bloc is BrandBloc) {
                bloc.add(const SearchBrand(name: ""));
              }
              // BlocProvider.of<PropertyForRentBloc>(context)
              //     .add(const SearchProperty(name: "", status: 2));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.xmark,
                  color: focus.hasFocus
                      ? AppColor.secondColor
                      : AppColor.textColor,
                  // size: 24,
                ),
              ],
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.primaryColor,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: widget.hintText,
          hintStyle: TxtStyle.heading5Gray.copyWith(
              fontSize: 14,
              color:
                  focus.hasFocus ? AppColor.secondColor : AppColor.textColor),
        ),
      ),
    );
  }
}
