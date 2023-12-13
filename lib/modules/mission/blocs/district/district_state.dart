part of 'district_bloc.dart';

abstract class DistrictState extends Equatable {
  const DistrictState();

  @override
  List<Object> get props => [];
}

class DistrictLoading extends DistrictState {}

class DistrictLoaded extends DistrictState {
  // final District district;
  final List<District> districts;
  const DistrictLoaded(
      // this.district,
      this.districts);
  @override
  List<Object> get props => [
        // district,
        districts
      ];
}

class DistrictByIDLoaded extends DistrictState {
  final District district;

  const DistrictByIDLoaded(this.district);
  @override
  List<Object> get props => [district];
}

class DistrictError extends DistrictState {
  final String error;

  const DistrictError(this.error);
  @override
  List<Object> get props => [error];
}
