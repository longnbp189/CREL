part of 'ward_bloc.dart';

abstract class WardEvent extends Equatable {
  const WardEvent();

  @override
  List<Object> get props => [];
}

class GetWardByDistrictIdRequested extends WardEvent {
  final int id;
  const GetWardByDistrictIdRequested(this.id);
  @override
  List<Object> get props => [id];
}
