import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/config/configs.dart';
import 'package:crel_mobile/modules/appointment/blocs/contract/contract_bloc.dart';
import 'package:crel_mobile/modules/home/blocs/brand/brand_bloc.dart';
import 'package:crel_mobile/modules/home/blocs/property_for_rent/property_for_rent_bloc.dart';
import 'package:crel_mobile/modules/profile/blocs/profile/profile_bloc.dart';
import 'package:crel_mobile/modules/profile/widgets/contract_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';

class ContractPage extends StatefulWidget {
  final int? id;
  const ContractPage({Key? key, this.id}) : super(key: key);

  @override
  State<ContractPage> createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController()
    ..text = "";
  bool isInit = true;

  @override
  void initState() {
    context.read<ContractBloc>().add(SearchContractByMonth(
        AppFormat.startDayOfMonth(date), AppFormat.endDayOfMonth(date), true));
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

  DateTime? returnMonth;
  callbackDate(returnData) {
    setState(() {
      returnMonth = returnData;
    });
  }

  DateTime date = DateTime(DateTime.now().year, DateTime.now().month);

  Future pickDate(BuildContext context) async {
    final chooseDate = await showMonthPicker(
        context: context,
        // builder: (context, child) => Theme(
        //       data: ThemeData.light().copyWith(
        //           colorScheme: const ColorScheme.light(
        //         primary: AppColor.primaryColor,
        //       )),
        //       child: child!,
        //     ),
        selectedMonthBackgroundColor: AppColor.primaryColor,
        unselectedMonthTextColor: AppColor.primaryColor,
        initialDate: date,
        // firstDate: DateTime.no(),
        lastDate: DateTime(2100));

    if (chooseDate == null) return;
    setState(() {
      date = chooseDate;

      context.read<ContractBloc>().add(SearchContractByMonth(
          AppFormat.startDayOfMonth(date),
          AppFormat.endDayOfMonth(date),
          true));
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.id == 1) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRouter.customNavBar, (route) => false,
              arguments: 4);
        } else {
          Navigator.pop(context);
        }

        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Hợp đồng",
              style: TxtStyle.textAppBar,
            ),
            backgroundColor: AppColor.primaryColor,
            centerTitle: true,
            leading: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                if (widget.id == 1) {
                  context.read<ProfileBloc>().add(GetProfileRequested());
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRouter.customNavBar, (route) => false,
                      arguments: 4);
                } else {
                  Navigator.pop(context);
                }
              },
              icon: SvgPicture.asset(
                'assets/icons/arrow-left.svg',
                color: Colors.white,
                // height: 250,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColor.primaryColor,
            onPressed: () {
              context.read<BrandBloc>().add(const GetBrandRequested(true));
              context
                  .read<PropertyForRentBloc>()
                  .add(const GetPropertyForRentRequested(2, "", true));
              Navigator.pushNamed(context, AppRouter.createContract);
            },
            child: const FaIcon(
              FontAwesomeIcons.plus,
            ),
            // label: const Text('Approve'),
          ),
          body: SafeArea(
              child: Container(
            color: AppColor.backgroundColor,
            child: BlocConsumer<ContractBloc, ContractState>(
              listener: (context, state) {
                if (state is ContractError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("ContractError")));
                }
                if (state is ContractLoaded) {
                  isInit = false;
                  // ScaffoldMessenger.of(context).showSnackBar(
                  // const SnackBar(content: Text("ContractError")));
                }
              },
              buildWhen: (previous, current) =>
                  previous != current && (current is ContractLoaded || isInit),
              builder: (context, state) {
                if (state is ContractLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ContractLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, right: 16),
                        child: GestureDetector(
                          onTap: () {
                            pickDate(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColor.boderColor)),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                child: Text(
                                  AppFormat.parseMonth(date.toString()),
                                  style: TxtStyle.heading4,
                                )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        child: state.contracts.isEmpty
                            ? Center(
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
                              )
                            : ContractList(
                                onRefresh: _onRefresh,
                                scrollController: _scrollController,
                                state: state,
                              ),
                      ),
                    ],
                  );
                }
                return Text('$state');
              },
            ),
          ))),
    );
  }

  Future<void> _onRefresh() async {
    isInit = true;
    context.read<ContractBloc>().add(SearchContractByMonth(
        AppFormat.startDayOfMonth(date), AppFormat.endDayOfMonth(date), true));
  }

  void _onScroll() {
    FocusManager.instance.primaryFocus?.unfocus();
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      // ignore: avoid_single_cascade_in_expression_statements
      context.read<ContractBloc>().add(SearchContractByMonth(
          AppFormat.startDayOfMonth(date),
          AppFormat.endDayOfMonth(date),
          false));
    }
  }
}

class ContractList extends StatelessWidget {
  final ScrollController scrollController;
  final ContractLoaded state;
  final RefreshCallback onRefresh;
  const ContractList({
    required this.scrollController,
    required this.state,
    required this.onRefresh,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        controller: scrollController,
        padding:
            const EdgeInsets.only(left: 16, right: 16, bottom: 48, top: 16),
        itemCount: state.hasReachedMax
            ? state.contracts.length
            : state.contracts.length + 1,
        itemBuilder: (context, index) {
          if (index >= state.contracts.length) {
            return (state.contracts.length >= 20)
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox();
          } else {
            return GestureDetector(
                onTap: () {
                  context.read<PropertyForRentBloc>().add(
                      GetPropertyForRentByIdRequested(
                          state.contracts[index].propertyId!));

                  context.read<BrandBloc>().add(
                      GetBrandByIdRequested(state.contracts[index].brandId!));
                  // context.read<AppointmentBloc>().add(
                  //     GetAppointmentByIdRequested(
                  //         state.contracts[index].appointmentId!, true));
                  if (state.contracts[index].status == 1) {
                    Navigator.pushNamed(context, AppRouter.editContractPage,
                        arguments: state.contracts[index]);
                  } else {
                    context.read<ContractBloc>().add(
                        GetContractByIdRequested(state.contracts[index].id!));
                    Navigator.pushNamed(context, AppRouter.contractDetailPage,
                        arguments: state.contracts[index]);
                  }
                },
                child: ContractItem(
                  contract: state.contracts[index],
                ));
          }
        },
      ),
    );
  }
}
