part of 'store_bloc.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  final List<Store> stores;
  final bool hasReachedMax;
  final int? status;

  const StoreLoaded(
      {this.stores = const <Store>[], this.hasReachedMax = false, this.status});

  StoreLoaded copyWith(
      {List<Store>? stores, bool? hasReachedMax, int? status}) {
    return StoreLoaded(
        stores: stores ?? this.stores,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [stores, hasReachedMax];
}

class StoreError extends StoreState {
  final String error;

  const StoreError(this.error);
  @override
  List<Object> get props => [error];
}
