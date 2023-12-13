import 'package:crel_mobile/common/widgets/stateful/search_with_button.dart';
import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
import 'package:crel_mobile/modules/home/widgets/property_for_rent_list_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabPFRRented extends StatefulWidget {
  const TabPFRRented({Key? key}) : super(key: key);

  @override
  State<TabPFRRented> createState() => _TabPFRRentedState();
}

class _TabPFRRentedState extends State<TabPFRRented> {
  final ScrollController _scrollController = ScrollController();
  late PropertyForRentBloc _propertyForRentBloc;
  final TextEditingController _searchController = TextEditingController()
    ..text = "";

  @override
  void initState() {
    _propertyForRentBloc = context.read<PropertyForRentBloc>()
      ..add(const GetRentedPropertyForRentRequested("", true));
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
              status: 3,
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
            },
            child: BlocBuilder<PropertyForRentBloc, PropertyForRentState>(
                buildWhen: (previous, current) =>
                    previous != current &&
                    current is RentedPropertyForRentLoaded,
                builder: (context, state) {
                  if (state is PropertyForRentLoading ||
                      state is PropertyForRentIdLoaded) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is PropertyForRentLoaded) {
                    return PropertyForRentListTwo(
                      onRefresh: _onRefresh,
                      scrollController: _scrollController,
                      properties: state.propertyForRents,
                      hasReachMax: state.hasReachedMax,
                    );
                  }
                  if (state is RentedPropertyForRentLoaded) {
                    return PropertyForRentListTwo(
                      onRefresh: _onRefresh,
                      scrollController: _scrollController,
                      properties: state.propertyForRents,
                      hasReachMax: state.hasReachedMax,
                    );
                  }
                  return Text("$state");
                }),
          )
        ],
      ),
    );
  }

  Future<void> _onRefresh() async {
    _propertyForRentBloc
        .add(RefreshPropertyForRentRequested(3, _searchController.text));
  }

  void _onScroll() {
    FocusManager.instance.primaryFocus?.unfocus();
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      // ignore: avoid_single_cascade_in_expression_statements
      _propertyForRentBloc
        ..add(GetRentedPropertyForRentRequested(_searchController.text, false));
    }
  }
}
