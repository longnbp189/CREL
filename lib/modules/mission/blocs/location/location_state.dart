part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final Location location;
  const LocationLoaded(this.location);
  @override
  List<Object> get props => [location];
}

class LocationError extends LocationState {
  final String error;

  const LocationError(this.error);
  @override
  List<Object> get props => [error];
}
