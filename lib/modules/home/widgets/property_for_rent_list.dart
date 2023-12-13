import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
import 'package:crel_mobile/modules/home/widgets/property_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

// class PropertyForRentList extends StatelessWidget {
//   final List<PropertyForRent> propertyForRents;
//   const PropertyForRentList({Key? key, required this.propertyForRents})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return ListView.builder(
//         shrinkWrap: true,
//         // scrollDirection: Axis.vertical,
//         physics: const NeverScrollableScrollPhysics(),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//         itemCount: propertyForRents.length,
//         itemBuilder: (context, index) {
//           return PropertyForRentCard(
//               size: size, propertyForRent: propertyForRents[index]);
//         });
//   }
// }

class PropertyForRentList extends StatelessWidget {
  final ScrollController scrollController;
  final RefreshCallback onRefresh;
  final List<Property> properties;
  final bool hasReachMax;

  const PropertyForRentList(
      {Key? key,
      required this.scrollController,
      required this.hasReachMax,
      required this.properties,
      required this.onRefresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (properties.isEmpty) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
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
    return Expanded(
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: scrollController,
            // shrinkWrap: true,
            padding:
                const EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 16),
            itemCount: hasReachMax ? properties.length : properties.length + 1,
            itemBuilder: (context, index) {
              if (index >= properties.length) {
                return (properties.length >= 3)
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox();
              } else {
                return InkWell(
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute<PropertyDetail>(
                    //     builder: (_) => BlocProvider.value(
                    //       value: BlocProvider.of<PropertyForRentBloc>(context),
                    //       child: PropertyDetail(
                    //         propertyForRent: properties[index],
                    //       ),
                    //     ),
                    //   ),
                    // );
                    context.read<PropertyForRentBloc>().add(
                        GetPropertyForRentByIdRequested(properties[index].id!));

                    Navigator.pushNamed(context, AppRouter.propertyDetail,
                        arguments: properties[index]);

                    // Navigator.pushNamed(context, AppRouter.propertyDetail,
                    //     arguments: state.propertyForRents[index]);
                  },
                  child: PropertyCard(
                    size: size,
                    propertyForRent: properties[index],
                  ),
                );
              }
            }),
      ),
    );
  }
}

// class RentedPropertyForRentList extends StatelessWidget {
//   final ScrollController scrollController;
//   final RentedPropertyForRentLoaded state;
//   final RefreshCallback onRefresh;
//   const RentedPropertyForRentList(
//       {Key? key,
//       required this.scrollController,
//       required this.state,
//       required this.onRefresh})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Expanded(
//       child: RefreshIndicator(
//         onRefresh: onRefresh,
//         child: ListView.builder(
//             physics: const AlwaysScrollableScrollPhysics(),
//             controller: scrollController,
//             // shrinkWrap: true,
//             padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
//             itemCount: state.hasReachedMax
//                 ? state.propertyForRents.length
//                 : state.propertyForRents.length + 1,
//             itemBuilder: (context, index) {
//               if (index >= state.propertyForRents.length) {
//                 return (state.propertyForRents.length >= 3)
//                     ? const Center(child: CircularProgressIndicator())
//                     : const SizedBox();
//               } else {
//                 return InkWell(
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute<PropertyDetail>(
//                         builder: (_) => BlocProvider.value(
//                           value: BlocProvider.of<PropertyForRentBloc>(context),
//                           child: PropertyDetail(
//                             propertyForRent: state.propertyForRents[index],
//                           ),
//                         ),
//                       ),
//                     );
//                     // Navigator.pushNamed(context, AppRouter.propertyDetail,
//                     //     arguments: state.propertyForRents[index]);
//                   },
//                   child: PropertyCard(
//                     size: size,
//                     propertyForRent: state.propertyForRents[index],
//                   ),
//                 );
//               }
//             }),
//       ),
//     );
//   }
// }
