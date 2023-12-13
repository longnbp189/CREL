part of 'brand_bloc.dart';

abstract class BrandEvent extends Equatable {
  const BrandEvent();

  @override
  List<Object> get props => [];
}

class GetBrandRequested extends BrandEvent {
  final bool isInit;
  const GetBrandRequested(this.isInit);
  @override
  List<Object> get props => [isInit];
}

class SearchBrand extends BrandEvent {
  final String name;
  const SearchBrand({required this.name});
  @override
  List<Object> get props => [name];
}

class GetBrandByIdRequested extends BrandEvent {
  final int id;
  const GetBrandByIdRequested(this.id);
  @override
  List<Object> get props => [id];
}

class RefreshBrandRequested extends BrandEvent {}
