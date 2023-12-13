part of 'suggest_property_bloc.dart';

abstract class SuggestPropertyEvent extends Equatable {
  const SuggestPropertyEvent();

  @override
  List<Object> get props => [];
}

class GetListSuggestPropertyByBrand extends SuggestPropertyEvent {
  final int idBrand;
  final bool isInit;
  const GetListSuggestPropertyByBrand(this.idBrand, this.isInit);

  @override
  List<Object> get props => [idBrand];
}

class CreateListSuggestPropertyByBrand extends SuggestPropertyEvent {
  // final List<int> properties;
  final List<int>? isIntBefore;
  final List<int>? isIntAfter;
  final int idBrand;

  const CreateListSuggestPropertyByBrand(
      this.isIntBefore, this.isIntAfter, this.idBrand);

  @override
  List<Object> get props => [idBrand];
}

// class RemoveListSuggestPropertyByBrand extends SuggestPropertyEvent {
//   final List<int> properties;
//   final int idBrand;

//   const RemoveListSuggestPropertyByBrand(this.properties, this.idBrand);

//   @override
//   List<Object> get props => [properties, idBrand];
// }
