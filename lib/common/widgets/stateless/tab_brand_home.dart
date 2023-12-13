import 'package:crel_mobile/common/widgets/stateful/search_with_button.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/modules/home/blocs/brand/brand_bloc.dart';
import 'package:crel_mobile/modules/home/widgets/brand_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabBrandHome extends StatefulWidget {
  const TabBrandHome({Key? key}) : super(key: key);

  @override
  State<TabBrandHome> createState() => _TabBrandHomeState();
}

class _TabBrandHomeState extends State<TabBrandHome> {
  final ScrollController _scrollController = ScrollController();
  late BrandBloc _brandBloc;
  final TextEditingController _searchController = TextEditingController()
    ..text = "";

  @override
  void initState() {
    super.initState();
    _brandBloc = context.read<BrandBloc>()..add(const GetBrandRequested(true));
    _scrollController.addListener(_onScroll);
    _searchController.text = "";
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SearchWithButton(
                    status: 0,
                    bloc: BlocProvider.of<BrandBloc>(context),
                    hintText: "Nhập tên thương hiệu bạn muốn tìm.",
                    textController: _searchController,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            BlocListener<BrandBloc, BrandState>(
              listener: (context, state) {
                if (state is BrandError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("BrandError")));
                }
              },
              child: BlocBuilder<BrandBloc, BrandState>(
                builder: (context, state) {
                  if (state is BrandLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is BrandLoaded) {
                    if (state.brands.isEmpty) {
                      return RefreshIndicator(
                        onRefresh: _onRefresh,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/empty.svg',
                                  height: 250,
                                ),
                                const Text(
                                  "Danh sách trống",
                                  style: TxtStyle.heading2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    return BrandList(
                      onRefresh1: _onRefresh,
                      scrollController: _scrollController,
                      state: state,
                    );
                  } else {
                    return Text("$state.");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    _searchController.clear();
    _brandBloc.add(RefreshBrandRequested());
  }

  void _onScroll() {
    FocusManager.instance.primaryFocus?.unfocus();

    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      // ignore: avoid_single_cascade_in_expression_statements
      _brandBloc..add(const GetBrandRequested(false));
    }
  }
}
