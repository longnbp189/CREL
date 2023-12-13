part of 'suggest_property_bloc.dart';

abstract class SuggestPropertyState extends Equatable {
  const SuggestPropertyState();

  @override
  List<Object> get props => [];
}

class SuggestPropertyLoading extends SuggestPropertyState {}

class SuggestCreateListSuggestPropertyByBrand extends SuggestPropertyState {}

class SuggestPropertyLoaded extends SuggestPropertyState {
  final List<SuggestProperty> properties;
  final bool hasReachedMax;
  const SuggestPropertyLoaded({
    this.properties = const <SuggestProperty>[],
    this.hasReachedMax = false,
  });

  SuggestPropertyLoaded copyWith(
      {List<SuggestProperty>? properties, bool? hasReachedMax}) {
    return SuggestPropertyLoaded(
      properties: properties ?? this.properties,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [properties];
}

class SuggestPropertyError extends SuggestPropertyState {
  final String error;

  const SuggestPropertyError(this.error);
  @override
  List<Object> get props => [error];
}
