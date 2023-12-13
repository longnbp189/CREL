part of 'property_for_rent_bloc.dart';

abstract class PropertyForRentState extends Equatable {
  const PropertyForRentState();

  @override
  List<Object> get props => [];
}

class PropertyForRentLoading extends PropertyForRentState {}

class PropertyForRentUpdated extends PropertyForRentState {}

class UpdatedSuccessProperty extends PropertyForRentState {}

class PropertyForRentIdLoaded extends PropertyForRentState {
  final Property property;

  const PropertyForRentIdLoaded({required this.property});
  @override
  List<Object> get props => [property];
}

class PropertyForRentLoaded extends PropertyForRentState {
  final List<Property> propertyForRents;
  final bool hasReachedMax;
  final int? status;

  const PropertyForRentLoaded(
      {this.propertyForRents = const <Property>[],
      this.hasReachedMax = false,
      this.status});

  PropertyForRentLoaded copyWith(
      {List<Property>? propertyForRents, bool? hasReachedMax, int? status}) {
    return PropertyForRentLoaded(
        propertyForRents: propertyForRents ?? this.propertyForRents,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [propertyForRents, hasReachedMax];
}

class RentedPropertyForRentLoaded extends PropertyForRentState {
  final List<Property> propertyForRents;
  final bool hasReachedMax;

  const RentedPropertyForRentLoaded({
    this.propertyForRents = const <Property>[],
    this.hasReachedMax = false,
  });

  RentedPropertyForRentLoaded copyWith(
      {List<Property>? propertyForRents, bool? hasReachedMax, int? status}) {
    return RentedPropertyForRentLoaded(
      propertyForRents: propertyForRents ?? this.propertyForRents,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [propertyForRents, hasReachedMax];
}

// class PropertyForRentByIdLoaded extends PropertyForRentState {
//   final Property propertyForRent;
//   const PropertyForRentByIdLoaded(this.propertyForRent);
//   @override
//   List<Object> get props => [propertyForRent];
// }

class PropertyForRentError extends PropertyForRentState {
  final String error;

  const PropertyForRentError(this.error);
  @override
  List<Object> get props => [error];
}
