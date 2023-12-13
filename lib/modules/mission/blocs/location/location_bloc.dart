import 'package:bloc/bloc.dart';
import 'package:crel_mobile/models/location.dart';
import 'package:crel_mobile/modules/mission/repos/location_repo.dart';
import 'package:equatable/equatable.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepo locationRepo;
  LocationBloc({required this.locationRepo}) : super(LocationLoading()) {
    on<GetLocationByIdRequested>(_onGetLocationByIdRequested);
  }

  void _onGetLocationByIdRequested(
      GetLocationByIdRequested event, Emitter<LocationState> emit) async {
    emit(LocationLoading());
    try {
      var location = await locationRepo.getLocationById(event.id);

      emit(LocationLoaded(location));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }
}
