import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crel_mobile/models/store.dart';
import 'package:crel_mobile/modules/appointment/repos/store_repo.dart';
import 'package:equatable/equatable.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final StoreRepo storeRepo;

  int pageNum = 1;
  int pageSize = 30;
  StoreBloc({required this.storeRepo}) : super(StoreLoading()) {
    on<GetListStore>(_onGetListStore);
  }

  FutureOr<void> _onGetListStore(
      GetListStore event, Emitter<StoreState> emit) async {
    final state = this.state;

    try {
      if (event.isInit) {
        emit(StoreLoading());

        final stores = await storeRepo.getStore(1, pageSize, event.brandId);
        emit(StoreLoaded(stores: stores));
      } else {
        if (state is StoreLoaded) {
          final stores =
              await storeRepo.getStore(++pageNum, pageSize, event.brandId);
          if (stores.isEmpty) {
            emit(state.copyWith(hasReachedMax: true));
          } else {
            if (pageNum > 1) {
              emit(state.copyWith(stores: state.stores + stores));
            } else {
              emit(StoreLoaded(stores: stores));
            }
          }
        }
      }
    } catch (e) {
      emit(StoreError(e.toString()));
    }
  }
}
