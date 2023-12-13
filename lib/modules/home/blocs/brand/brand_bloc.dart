import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crel_mobile/models/brand.dart';
import 'package:crel_mobile/modules/home/repos/brand_repo.dart';
import 'package:equatable/equatable.dart';

part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final BrandRepo brandRepo;
  int pageNum = 1;
  int pageSize = 30;

  BrandBloc({required this.brandRepo}) : super(BrandLoading()) {
    on<GetBrandRequested>(_onGetBrandRequested);
    on<RefreshBrandRequested>(_onRefreshBrandRequested);
    on<SearchBrand>(_onSearchBrand);
    on<GetBrandByIdRequested>(_onGetBrandByIdRequested);
  }

  void _onGetBrandRequested(
      GetBrandRequested event, Emitter<BrandState> emit) async {
    final state = this.state;
    if (event.isInit) {
      emit(BrandLoading());
    }
    try {
      if (state is BrandLoading || event.isInit) {
        pageNum = 1;

        final brands = await brandRepo.getListBrand(pageNum, pageSize);
        emit(BrandLoaded(brands: brands));
      } else {
        if (state is BrandLoaded) {
          final brands = await brandRepo.getListBrand(++pageNum, pageSize);

          if (brands.isEmpty) {
            emit(state.copyWith(hasReachedMax: true));
          } else {
            if (pageNum > 1) {
              emit(state.copyWith(brands: state.brands + brands));
            } else {
              emit(BrandLoaded(brands: brands));
            }
          }
        }
      }
    } catch (e) {
      emit(BrandError(e.toString()));
    }
  }

  void _onRefreshBrandRequested(
      RefreshBrandRequested event, Emitter<BrandState> emit) async {
    emit(BrandLoading());
    final state = this.state;
    try {
      if (state is BrandLoading) {
        pageNum = 1;
        final brands = await brandRepo.getListBrand(pageNum, pageSize);
        emit(BrandLoaded(brands: brands));
      }
      // else {
      //   if (state is BrandLoaded) {
      //     final brands = await brandRepo.getListBrand(++pageNum, pageSize);
      //     emit(BrandLoaded(brands: brands));
      //     if (brands.isEmpty) {
      //       emit(state.copyWith(hasReachedMax: true));
      //     } else {
      //       emit(state.copyWith(brands: state.brands + brands));
      //     }
      //   }
      // }
    } catch (e) {
      emit(BrandError(e.toString()));
    }
  }

  void _onSearchBrand(SearchBrand event, Emitter<BrandState> emit) async {
    final state = this.state;
    //  emit(PropertyForRentLoading());
    if (state is BrandLoaded) {
      try {
        emit(BrandLoading());
        final brand = await brandRepo.searchBrand(1, 10, event.name);
        emit(BrandLoaded(brands: brand));
      } catch (e) {
        emit(BrandError(e.toString()));
      }
    }
  }

  FutureOr<void> _onGetBrandByIdRequested(
      GetBrandByIdRequested event, Emitter<BrandState> emit) async {
    emit(BrandLoading());
    try {
      var brand = await brandRepo.getBrandById(event.id);
      // final brands = await brandRepo.getListBrand( 1,10);

      emit(BrandIdLoaded(brand: brand));
    } catch (e) {
      emit(BrandError(e.toString()));
    }
  }
}
