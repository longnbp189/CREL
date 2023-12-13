import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crel_mobile/models/project.dart';
import 'package:crel_mobile/modules/mission/repos/project_repo.dart';
import 'package:equatable/equatable.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepo projectRepo;

  ProjectBloc({required this.projectRepo}) : super(ProjectLoading()) {
    on<GetProjectByIdRequested>(_onGetProjectByIdRequested);
    on<GetProjectRequested>(_onGetProjectRequested);
    on<GetProjectByIdLoaded>(_onGetProjectByIdLoaded);
    on<GetProjectByDistrictRequested>(_onGetProjectByDistrictRequested);
  }

  void _onGetProjectByIdRequested(
      GetProjectByIdRequested event, Emitter<ProjectState> emit) async {
    emit(ProjectLoading());
    try {
      var project = await projectRepo.getProjectById(event.id);
      final projects = await projectRepo.getProject();

      emit(ProjectLoaded(project, projects));
    } catch (e) {
      emit(ProjectError(e.toString()));
    }
  }

  void _onGetProjectRequested(
      GetProjectRequested event, Emitter<ProjectState> emit) async {
    // if (state is ProjectLoaded) {
    try {
      emit(ProjectLoading());
      final projects = await projectRepo.getProject();
      emit(ListProjectLoaded(projects: projects));
      // emit(ProjectLoaded(project));
    } catch (e) {
      emit(ProjectError(e.toString()));
      // }
    }
  }

  FutureOr<void> _onGetProjectByIdLoaded(
      GetProjectByIdLoaded event, Emitter<ProjectState> emit) async {
    try {
      emit(ProjectLoading());
      final project = await projectRepo.getProjectById(event.id);
      emit(ProjectIdLoaded(project));
      // emit(ProjectLoaded(project));
    } catch (e) {
      emit(ProjectError(e.toString()));
      // }
    }
  }

  FutureOr<void> _onGetProjectByDistrictRequested(
      GetProjectByDistrictRequested event, Emitter<ProjectState> emit) async {
    emit(ProjectLoading());

    try {
      final projects = await projectRepo.getProjectByDistrict(event.id);
      emit(ListProjectLoaded(projects: projects));
      // emit(ProjectLoaded(project));
    } catch (e) {
      emit(ProjectError(e.toString()));
      // }
    }
  }
}
