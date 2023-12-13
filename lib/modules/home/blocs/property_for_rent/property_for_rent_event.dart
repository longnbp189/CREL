part of 'property_for_rent_bloc.dart';

abstract class PropertyForRentEvent extends Equatable {
  const PropertyForRentEvent();

  @override
  List<Object> get props => [];
}

class GetPropertyForRentRequested extends PropertyForRentEvent {
  final int? status;
  final String name;
  final bool? isInit;
  const GetPropertyForRentRequested(this.status, this.name, this.isInit);
  @override
  List<Object> get props => [];
}

class GetRentedPropertyForRentRequested extends PropertyForRentEvent {
  final String name;
  final bool? isInit;
  const GetRentedPropertyForRentRequested(this.name, this.isInit);
  @override
  List<Object> get props => [];
}

class SearchProperty extends PropertyForRentEvent {
  final String name;
  final int status;
  const SearchProperty({required this.name, required this.status});
  @override
  List<Object> get props => [name, status];
}

class UpdateProperty extends PropertyForRentEvent {
  final Property property;
  final List<XFile> image;
  final List<Media>? mediaAdd;
  final List<Media>? mediaSaved;

  const UpdateProperty(
      this.property, this.image, this.mediaAdd, this.mediaSaved);
  @override
  List<Object> get props => [property, image];
}

class UpdateStatusProperty extends PropertyForRentEvent {
  final Property property;
  // final int status;

  const UpdateStatusProperty(this.property);
  @override
  List<Object> get props => [property];
}

class GetPropertyForRentByIdRequested extends PropertyForRentEvent {
  final int id;
  // final bool isInit;
  const GetPropertyForRentByIdRequested(this.id
      // , this.isInit
      );
  @override
  List<Object> get props => [
        id,
        // isInit
      ];
}

class RefreshPropertyForRentRequested extends PropertyForRentEvent {
  final int? status;
  final String name;
  const RefreshPropertyForRentRequested(this.status, this.name);
  @override
  List<Object> get props => [];
}
