part of 'owner_bloc.dart';

abstract class OwnerState extends Equatable {
  const OwnerState();

  @override
  List<Object> get props => [];
}

class ContactLoading extends OwnerState {}

class ContactLoaded extends OwnerState {
  final List<Owner> contact;
  const ContactLoaded(this.contact);
  @override
  List<Object> get props => [contact];
}

class ContactError extends OwnerState {
  final String error;

  const ContactError(this.error);
  @override
  List<Object> get props => [error];
}
