import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/modules/home/blocs/brand/brand_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBarBrand extends StatefulWidget {
  final String title;
  const SearchBarBrand({Key? key, required this.title}) : super(key: key);

  @override
  State<SearchBarBrand> createState() => _SearchBarBrandState();
}

TextEditingController controller = TextEditingController()..text = "";

class _SearchBarBrandState extends State<SearchBarBrand> {
  // @override
  // void initState() {
  //   controller.text = "";
  //   super.initState();
  // }

  @override
  void dispose() {
    // controller.clear();
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: AppColor.boderColor)),
              child: TextFormField(
                controller: controller,
                cursorColor: AppColor.secondColor,
                style: const TextStyle(color: AppColor.secondColor),
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: widget.title,
                  hintStyle: TxtStyle.heading5Gray,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColor.textColor,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              BlocProvider.of<BrandBloc>(context)
                  .add(SearchBrand(name: controller.text));
            },
            child: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(
                  Icons.filter_list_outlined,
                  color: AppColor.textColor,
                )),
          ),
        ],
      ),
    );
  }
}
