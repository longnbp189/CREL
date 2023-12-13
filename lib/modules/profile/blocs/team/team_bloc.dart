import 'package:bloc/bloc.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:crel_mobile/modules/profile/repos/team_repo.dart';
import 'package:equatable/equatable.dart';

part 'team_event.dart';
part 'team_state.dart';

class TeamBloc extends Bloc<TeamEvent, TeamState> {
  final TeamRepo teamRepo;

  TeamBloc({required this.teamRepo}) : super(TeamLoading()) {
    on<GetTeamRequested>(_onGetTeamRequested);
  }

  void _onGetTeamRequested(
      GetTeamRequested event, Emitter<TeamState> emit) async {
    emit(TeamLoading());
    try {
      var team = await teamRepo.getStaffTeam();

      emit(TeamLoaded(team));
    } catch (e) {
      emit(TeamError(e.toString()));
    }
  }
}
