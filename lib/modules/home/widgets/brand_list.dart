import 'package:crel_mobile/config/app_router.dart';
import 'package:crel_mobile/modules/home/blocs/brand/brand_bloc.dart';
import 'package:crel_mobile/modules/home/widgets/brand_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandList extends StatelessWidget {
  final ScrollController scrollController;
  final BrandLoaded state;
  final RefreshCallback onRefresh1;
  const BrandList(
      {Key? key,
      required this.scrollController,
      required this.state,
      required this.onRefresh1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Expanded(
      child: RefreshIndicator(
        onRefresh: onRefresh1,
        child: ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            controller: scrollController,
            // scrollDirection: Axis.vertical,
            itemCount: state.hasReachedMax
                ? state.brands.length
                : state.brands.length + 1,
            itemBuilder: (context, index) {
              if (index >= state.brands.length) {
                return Center(
                    child: (state.brands.length >= 5)
                        ? const CircularProgressIndicator()
                        : const SizedBox());
              } else {
                return InkWell(
                    onTap: () {
                      // context
                      //     .read<StoreBloc>()
                      //     .add(GetListStore(true, state.brands[index].id!));
                      context
                          .read<BrandBloc>()
                          .add(GetBrandByIdRequested(state.brands[index].id!));
                      Navigator.pushNamed(context, AppRouter.brandDetail,
                          arguments: 0);
                    },
                    child: BrandCard(size: size, brand: state.brands[index]));
              }
            }),
      ),
    );
  }
}
