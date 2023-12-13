part of 'brand_bloc.dart';

abstract class BrandState extends Equatable {
  const BrandState();

  @override
  List<Object> get props => [];
}

class BrandLoading extends BrandState {}

class BrandLoaded extends BrandState {
  final List<Brand> brands;
  final Brand? brand;

  final bool hasReachedMax;

  const BrandLoaded(
      {this.brands = const <Brand>[], this.hasReachedMax = false, this.brand});

  BrandLoaded copyWith({List<Brand>? brands, bool? hasReachedMax}) {
    return BrandLoaded(
        brands: brands ?? this.brands,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  List<Object> get props => [brands, hasReachedMax];
}

class BrandIdLoaded extends BrandState {
  final Brand brand;

  const BrandIdLoaded({required this.brand});
  @override
  List<Object> get props => [brand];
}

class BrandError extends BrandState {
  final String error;

  const BrandError(this.error);
  @override
  List<Object> get props => [error];
}
