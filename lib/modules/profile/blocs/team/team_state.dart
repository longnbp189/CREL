part of 'team_bloc.dart';

abstract class TeamState extends Equatable {
  const TeamState();

  @override
  List<Object> get props => [];
}

class TeamLoading extends TeamState {}

class TeamLoaded extends TeamState {
  final List<Team> team;
  const TeamLoaded(this.team);
  @override
  List<Object> get props => [team];
}

class TeamError extends TeamState {
  final String error;

  const TeamError(this.error);
  @override
  List<Object> get props => [error];
}
