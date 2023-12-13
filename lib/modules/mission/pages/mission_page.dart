import 'package:crel_mobile/config/app_color.dart';
import 'package:crel_mobile/config/text_style.dart';
import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
import 'package:crel_mobile/modules/home/repos/property_repo.dart';
import 'package:crel_mobile/modules/mission/widgets/update_property_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MissionPage extends StatefulWidget {
  const MissionPage({Key? key}) : super(key: key);

  @override
  State<MissionPage> createState() => _MissionPageState();
}

class _MissionPageState extends State<MissionPage> {
  final ScrollController _scrollController = ScrollController();
  // late PropertyForRentBloc _propertyForRentBloc;
  final TextEditingController _searchController = TextEditingController()
    ..text = "";

  @override
  void initState() {
    // _propertyForRentBloc = context.read<PropertyForRentBloc>()
    //   ..add(const GetPropertyForRentRequested(1, "", true));
    _scrollController.addListener(_onScroll);
    _searchController.text = "";
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text(
          "Nhiệm vụ",
          style: TxtStyle.textAppBar,
        ),
        centerTitle: true,
        leading: const SizedBox(),
      ),
      body: SafeArea(
          child: Container(
        color: AppColor.backgroundColor,
        child: Column(
          children: [
            // const Padding(
            //   padding: EdgeInsets.only(right: 16, left: 16, top: 8, bottom: 16),
            //   child: SearchBarProperty(
            //       title: "Nhập tên bất động sản mà bạn muốn tìm kiếm!"),
            // ),
            // Padding(
            //   padding:
            //       const EdgeInsets.only(right: 16, left: 16, top: 8, bottom: 16),
            //   child: SearchWithButton(
            //     isMission: true,
            //     bloc: BlocProvider.of<PropertyForRentBloc>(context),
            //     textController: _searchController,
            //     hintText: "Nhập tên bất động sản bạn muốn tìm kiếm!",
            //   ),
            // ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: BlocProvider<PropertyForRentBloc>(
                create: (context) => PropertyForRentBloc(
                  propertyForRentRepo:
                      RepositoryProvider.of<PropertyRepo>(context),
                )..add(const GetPropertyForRentRequested(1, "", true)),
                child: BlocConsumer<PropertyForRentBloc, PropertyForRentState>(
                  listener: (context, state) {
                    if (state is PropertyForRentError) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("PropertyForRentError")));
                    }
                  },
                  builder: (context, state) {
                    if (state is PropertyForRentLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is PropertyForRentLoaded) {
                      if (state.propertyForRents.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/empty.svg',
                                height: 250,
                              ),
                              const Text(
                                "Danh sách mặt bằng trống",
                                style: TxtStyle.heading2,
                              ),
                            ],
                          ),
                        );
                      }
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Những mặt bằng cần phải cập nhật:",
                                style: TxtStyle.heading3.copyWith(fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          UpdatePropertyList(
                            onRefresh: _onRefresh,
                            scrollController: _scrollController,
                            state: state,
                          ),
                        ],
                      );
                    } else {
                      return Text("$state");
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Future<void> _onRefresh() async {
    context
        .read<PropertyForRentBloc>()
        .add(RefreshPropertyForRentRequested(1, _searchController.text));
  }

  void _onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      // ignore: avoid_single_cascade_in_expression_statements
      context.read<PropertyForRentBloc>()
        ..add(GetPropertyForRentRequested(1, _searchController.text, false));
    }
  }
}
