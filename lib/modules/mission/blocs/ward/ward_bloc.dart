import 'package:bloc/bloc.dart';
import 'package:crel_mobile/models/ward.dart';
import 'package:crel_mobile/modules/mission/repos/ward_repo.dart';
import 'package:equatable/equatable.dart';

part 'ward_event.dart';
part 'ward_state.dart';

class WardBloc extends Bloc<WardEvent, WardState> {
  final WardRepo wardRepo;
  WardBloc({required this.wardRepo}) : super(WardLoading()) {
    on<GetWardByDistrictIdRequested>(_onGetWardByDistrictIdRequested);
  }

  void _onGetWardByDistrictIdRequested(
      GetWardByDistrictIdRequested event, Emitter<WardState> emit) async {
    emit(WardLoading());
    try {
      var ward = await wardRepo.getWardByDistrictId(event.id);

      emit(WardLoaded(ward));
    } catch (e) {
      emit(WardError(e.toString()));
    }
  }
}
