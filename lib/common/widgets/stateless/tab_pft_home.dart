import 'package:crel_mobile/common/widgets/stateful/search_with_button.dart';
import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
import 'package:crel_mobile/modules/home/widgets/property_for_rent_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabPFRHome extends StatefulWidget {
  const TabPFRHome({Key? key}) : super(key: key);

  @override
  State<TabPFRHome> createState() => _TabPFRHomeState();
}

class _TabPFRHomeState extends State<TabPFRHome> {
  final ScrollController _scrollController = ScrollController();
  late PropertyForRentBloc _propertyForRentBloc;
  final TextEditingController _searchController = TextEditingController()
    ..text = "";

  bool isInit = true;

  @override
  void initState() {
    _propertyForRentBloc = context.read<PropertyForRentBloc>()
      ..add(const GetPropertyForRentRequested(2, "", true));
    _scrollController.addListener(_onScroll);
    _searchController.text = "";
    FocusManager.instance.primaryFocus?.unfocus();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // _searchController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
            child: SearchWithButton(
              status: 2,
              bloc: BlocProvider.of<PropertyForRentBloc>(context),
              textController: _searchController,
              hintText: "Nhập tên bất động sản bạn muốn tìm.",
            ),
          ),
          // const Padding(
          //     padding: EdgeInsets.only(bottom: 8, left: 16, right: 16),
          //     child: SearchBarProperty(
          //       title: "Nhập tên bất động sản mà bạn muốn tìm kiếm!",
          //     )),
          BlocListener<PropertyForRentBloc, PropertyForRentState>(
            listener: (context, state) {
              if (state is PropertyForRentError) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("PropertyForRentError")));
              }
              if (state is PropertyForRentLoaded) {
                isInit = false;
              }
            },
            child: BlocBuilder<PropertyForRentBloc, PropertyForRentState>(
                buildWhen: (previous, current) =>
                    previous != current &&
                    (current is PropertyForRentLoaded || isInit),
                builder: (context, state) {
                  if (state is PropertyForRentLoading ||
                      state is PropertyForRentIdLoaded) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is PropertyForRentLoaded) {
                    return PropertyForRentList(
                      onRefresh: _onRefresh,
                      scrollController: _scrollController,
                      properties: state.propertyForRents,
                      hasReachMax: state.hasReachedMax,
                    );
                  }
                  // if (state is RentedPropertyForRentLoaded) {
                  //   return PropertyForRentList(
                  //     onRefresh: _onRefresh,
                  //     scrollController: _scrollController,
                  //     properties: state.propertyForRents,
                  //     hasReachMax: state.hasReachedMax,
                  //   );
                  // }
                  return Text("$state");
                }),
          )
        ],
      ),
    );
  }

  Future<void> _onRefresh() async {
    isInit = true;
    _searchController.clear();
    _propertyForRentBloc.add(const RefreshPropertyForRentRequested(2, ""));
  }

  void _onScroll() {
    FocusManager.instance.primaryFocus?.unfocus();
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      // ignore: avoid_single_cascade_in_expression_statements
      _propertyForRentBloc
        ..add(GetPropertyForRentRequested(2, _searchController.text, false));
    }
  }
}
