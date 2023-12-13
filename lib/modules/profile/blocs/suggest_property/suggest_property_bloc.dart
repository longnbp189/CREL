import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crel_mobile/models/suggest_property.dart';
import 'package:crel_mobile/modules/profile/repos/suggest_property_repo.dart';
import 'package:equatable/equatable.dart';

part 'suggest_property_event.dart';
part 'suggest_property_state.dart';

class SuggestPropertyBloc
    extends Bloc<SuggestPropertyEvent, SuggestPropertyState> {
  final SuggestPropertyRepo suggestPropertyRepo;

  int pageNum = 1;
  int pageSize = 30;
  SuggestPropertyBloc({required this.suggestPropertyRepo})
      : super(SuggestPropertyLoading()) {
    on<GetListSuggestPropertyByBrand>(_onGetListSuggestPropertyByBrand);
    on<CreateListSuggestPropertyByBrand>(_onCreateListSuggestPropertyByBrand);
    // on<RemoveListSuggestPropertyByBrand>(_onRemoveListSuggestPropertyByBrand);
  }

  FutureOr<void> _onGetListSuggestPropertyByBrand(
      GetListSuggestPropertyByBrand event,
      Emitter<SuggestPropertyState> emit) async {
    final state = this.state;

    if (event.isInit) {
      emit(SuggestPropertyLoading());
    }
    try {
      if (state is SuggestPropertyLoading || event.isInit) {
        final properties = await suggestPropertyRepo.getListSuggestProperty(
            event.idBrand, 1, pageSize);
        emit(SuggestPropertyLoaded(properties: properties));
      } else {
        if (state is SuggestPropertyLoaded) {
          final properties = await suggestPropertyRepo.getListSuggestProperty(
              event.idBrand, ++pageNum, pageSize);
          if (properties.isEmpty) {
            emit(state.copyWith(hasReachedMax: true));
          } else {
            if (pageNum > 1) {
              emit(state.copyWith(properties: state.properties + properties));
            } else {
              emit(SuggestPropertyLoaded(properties: properties));
            }
          }
        }
      }
    } catch (e) {
      emit(SuggestPropertyError(e.toString()));
    }
  }

  FutureOr<void> _onCreateListSuggestPropertyByBrand(
      CreateListSuggestPropertyByBrand event,
      Emitter<SuggestPropertyState> emit) async {
    final state = this.state;
    try {
      if (state is SuggestPropertyLoaded) {
        emit(SuggestPropertyLoading());

        await suggestPropertyRepo.addListSuggestProperty(
            event.idBrand, event.isIntBefore ?? [], event.isIntAfter ?? []);

        await suggestPropertyRepo.removeListSuggestProperty(
            event.idBrand, event.isIntBefore ?? [], event.isIntAfter ?? []);

        emit(SuggestCreateListSuggestPropertyByBrand());
      }
    } catch (e) {
      emit(SuggestPropertyError(e.toString()));
    }
  }
}
