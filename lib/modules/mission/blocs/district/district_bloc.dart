import 'package:bloc/bloc.dart';
import 'package:crel_mobile/models/district.dart';
import 'package:crel_mobile/modules/mission/repos/district_repo.dart';
import 'package:equatable/equatable.dart';

part 'district_event.dart';
part 'district_state.dart';

class DistrictBloc extends Bloc<DistrictEvent, DistrictState> {
  final DistrictRepo districtRepo;
  DistrictBloc({required this.districtRepo}) : super(DistrictLoading()) {
    on<GetDistrictById>(_onGetDistrictById);
    on<GetDistrictRequested>(_onGetDistrictRequested);
  }

  void _onGetDistrictById(
      GetDistrictById event, Emitter<DistrictState> emit) async {
    emit(DistrictLoading());
    try {
      // var districts = await districtRepo.getDistrict();
      var district = await districtRepo.getDistrictById(event.id);
      emit(DistrictByIDLoaded(district));
    } catch (e) {
      emit(DistrictError(e.toString()));
    }
  }

  void _onGetDistrictRequested(
      GetDistrictRequested event, Emitter<DistrictState> emit) async {
    emit(DistrictLoading());
    try {
      var districts = await districtRepo.getDistrict();
      emit(DistrictLoaded(districts));
    } catch (e) {
      emit(DistrictError(e.toString()));
    }
  }
}
