import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
import 'package:crel_mobile/modules/mission/pages/update_property_page.dart';
import 'package:crel_mobile/modules/mission/widgets/update_property_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePropertyList extends StatelessWidget {
  final ScrollController scrollController;
  final PropertyForRentLoaded state;
  final RefreshCallback onRefresh;
  const UpdatePropertyList(
      {Key? key,
      required this.scrollController,
      required this.state,
      required this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: scrollController,
          // shrinkWrap: true,
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          itemCount: state.hasReachedMax
              ? state.propertyForRents.length
              : state.propertyForRents.length + 1,
          itemBuilder: (context, index) {
            if (index >= state.propertyForRents.length) {
              return (state.propertyForRents.length >= 6)
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox();
            } else {
              return InkWell(
                  onTap: () {
                    // state.propertyForRents[index].projectId != null
                    //     ? context.read<ProjectBloc>().add(
                    //         GetProjectByIdRequested(
                    //             state.propertyForRents[index].projectId!))
                    //     : context
                    //         .read<ProjectBloc>()
                    //         .add(GetProjectRequested());
                    // context.read<PropertyForRentBloc>().add(
                    //     GetPropertyForRentByIdRequested(
                    //         state.propertyForRents[index].id!));

                    Navigator.of(context).push(
                      MaterialPageRoute<UpdatePropetyPage>(
                        builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<PropertyForRentBloc>(context),
                          child: UpdatePropetyPage(
                            property: state.propertyForRents[index],
                          ),
                        ),
                      ),
                    );
                    // Navigator.pushNamed(context, AppRouter.updateProperty,
                    // arguments: state.propertyForRents[index]);
                  },
                  child: UpdatePropertyCard(
                    // location: state.propertyForRents[index].location!.address!,
                    propertyForRent: state.propertyForRents[index],
                  ));
            }
          },
        ),
      ),
    );
  }
}
