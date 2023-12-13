part of 'project_bloc.dart';

abstract class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object> get props => [];
}

class GetProjectRequested extends ProjectEvent {}

class GetProjectByDistrictRequested extends ProjectEvent {
  final int id;
  const GetProjectByDistrictRequested(this.id);
  @override
  List<Object> get props => [id];
}

class GetProjectByIdRequested extends ProjectEvent {
  final int id;
  const GetProjectByIdRequested(this.id);
  @override
  List<Object> get props => [id];
}

class GetProjectByIdLoaded extends ProjectEvent {
  final int id;
  const GetProjectByIdLoaded(this.id);
  @override
  List<Object> get props => [id];
}
