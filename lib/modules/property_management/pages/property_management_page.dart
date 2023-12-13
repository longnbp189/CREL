import 'package:crel_mobile/common/widgets/stateful/custom_tab_bar_manager_property.dart';
import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
import 'package:crel_mobile/modules/home/repos/property_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PropertyManagementPage extends StatelessWidget {
  const PropertyManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PropertyForRentBloc>(
      create: (context) => PropertyForRentBloc(
        propertyForRentRepo: RepositoryProvider.of<PropertyRepo>(context),
      ),
      child: const CustomTabBarManagerProperty(),
    );
  }
}
