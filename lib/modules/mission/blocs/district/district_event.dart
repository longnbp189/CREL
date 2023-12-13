part of 'district_bloc.dart';

abstract class DistrictEvent extends Equatable {
  const DistrictEvent();

  @override
  List<Object> get props => [];
}

class GetDistrictById extends DistrictEvent {
  final int id;
  const GetDistrictById(this.id);
  @override
  List<Object> get props => [id];
}

class GetDistrictRequested extends DistrictEvent {}
