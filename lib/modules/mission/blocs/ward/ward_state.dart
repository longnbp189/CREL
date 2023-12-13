part of 'ward_bloc.dart';

abstract class WardState extends Equatable {
  const WardState();

  @override
  List<Object> get props => [];
}

class WardLoading extends WardState {}

class WardLoaded extends WardState {
  final List<Ward> ward;
  const WardLoaded(this.ward);
  @override
  List<Object> get props => [ward];
}

class WardError extends WardState {
  final String error;

  const WardError(this.error);
  @override
  List<Object> get props => [error];
}
