part of 'project_bloc.dart';

abstract class ProjectState extends Equatable {
  const ProjectState();

  @override
  List<Object> get props => [];
}

class ProjectLoading extends ProjectState {}

class ProjectLoaded extends ProjectState {
  final Project project;
  final List<Project> projects;
  const ProjectLoaded(this.project, this.projects);
  @override
  List<Object> get props => [project, projects];
}

class ProjectIdLoaded extends ProjectState {
  final Project project;
  const ProjectIdLoaded(this.project
      // this.projects
      );
  @override
  List<Object> get props => [
        project,
        // projects
      ];
}

class ListProjectLoaded extends ProjectState {
  final List<Project> projects;
  const ListProjectLoaded({required this.projects});
  @override
  List<Object> get props => [projects];
}

class ProjectError extends ProjectState {
  final String error;

  const ProjectError(this.error);
  @override
  List<Object> get props => [error];
}
