part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class GetLocationByIdRequested extends LocationEvent {
  final int id;
  const GetLocationByIdRequested(this.id);
  @override
  List<Object> get props => [id];
}
