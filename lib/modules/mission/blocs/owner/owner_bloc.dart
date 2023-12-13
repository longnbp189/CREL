import 'package:bloc/bloc.dart';
import 'package:crel_mobile/models/owner.dart';
import 'package:equatable/equatable.dart';

part 'owner_event.dart';
part 'owner_state.dart';

class OwnerBloc extends Bloc<OwnerEvent, OwnerState> {
  OwnerBloc() : super(ContactLoading()) {
    on<OwnerEvent>((event, emit) {});
  }
}
