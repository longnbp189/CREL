part of 'store_bloc.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object> get props => [];
}

class GetListStore extends StoreEvent {
  final bool isInit;
  final int brandId;
  const GetListStore(this.isInit, this.brandId);
  @override
  List<Object> get props => [isInit, brandId];
}
