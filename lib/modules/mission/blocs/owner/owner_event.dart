part of 'owner_bloc.dart';

abstract class OwnerEvent extends Equatable {
  const OwnerEvent();

  @override
  List<Object> get props => [];
}

class AddContactRequested extends OwnerEvent {}

class RemoveContactRequested extends OwnerEvent {}
