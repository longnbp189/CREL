import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crel_mobile/models/models.dart';
import 'package:crel_mobile/modules/home/repos/property_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'property_for_rent_event.dart';
part 'property_for_rent_state.dart';

// class PropertyForRentBloc
//     extends Bloc<PropertyForRentEvent, PropertyForRentState> {
//   final PropertyForRentRepo propertyForRentRepo;
//   PropertyForRentBloc({required this.propertyForRentRepo})
//       : super(PropertyForRentLoading()) {
//     on<GetPropertyForRentRequested>(_onGetPropertyRequested);
//   }

//   void _onGetPropertyRequested(GetPropertyForRentRequested event,
//       Emitter<PropertyForRentState> emit) async {
//     emit(PropertyForRentLoading());
//     try {
//       List<PropertyForRent> propertyForRent =
//           await propertyForRentRepo.getPropertyForRent();
//       emit(PropertyForRentLoaded(propertyForRents: propertyForRent));
//     } catch (e) {
//       emit(PropertyForRentError(e.toString()));
//     }
//   }
// }

class PropertyForRentBloc
    extends Bloc<PropertyForRentEvent, PropertyForRentState> {
  final PropertyRepo propertyForRentRepo;
  int pageNum = 1;
  int pageSize = 10;
  int? status;
  PropertyForRentBloc({required this.propertyForRentRepo})
      : super(PropertyForRentLoading()) {
    on<GetPropertyForRentRequested>(_onGetPropertyRequested);
    on<RefreshPropertyForRentRequested>(_onRefreshPropertyForRentRequested);
    on<UpdateProperty>(_onUpdateProperty);
    on<SearchProperty>(_onSearchProperty);
    on<GetPropertyForRentByIdRequested>(_onGetPropertyForRentByIdRequested);
    on<GetRentedPropertyForRentRequested>(_onGetRentedPropertyForRentRequested);
    on<UpdateStatusProperty>(_onUpdateStatusProperty);
  }

  Future<void> _onGetPropertyRequested(GetPropertyForRentRequested event,
      Emitter<PropertyForRentState> emit) async {
    // if (event.isInit!) {
    //   emit(PropertyForRentLoading());
    // }
    if (event.isInit!) {
      emit(PropertyForRentLoading());
    }
    try {
      if (status != event.status) {
        emit(PropertyForRentLoading());
        status = event.status;
        pageNum = 1;
        final propertyForRent = await propertyForRentRepo.getPropertyForRent(
            pageNum, pageSize, event.status, event.name);
        // await Future<void>.delayed(const Duration(seconds: 1));

        emit(PropertyForRentLoaded(propertyForRents: propertyForRent));
      }
      final state = this.state;
      if (state is PropertyForRentLoading) {
        pageNum = 1;
        final propertyForRent = await propertyForRentRepo.getPropertyForRent(
            pageNum, pageSize, event.status, event.name);
        // await Future<void>.delayed(const Duration(seconds: 1));

        emit(PropertyForRentLoaded(propertyForRents: propertyForRent));
      } else {
        if (state is PropertyForRentLoaded) {
          final propertyForRent = await propertyForRentRepo.getPropertyForRent(
              ++pageNum, pageSize, status, event.name);

          if (propertyForRent.isEmpty) {
            emit(state.copyWith(hasReachedMax: true));
          } else {
            if (pageNum > 1) {
              emit(state.copyWith(
                  propertyForRents: state.propertyForRents + propertyForRent));
            } else {
              emit(PropertyForRentLoaded(propertyForRents: propertyForRent));
            }
          }
        }
      }
    } catch (e) {
      emit(PropertyForRentError(e.toString()));
    }
  }

  void _onRefreshPropertyForRentRequested(RefreshPropertyForRentRequested event,
      Emitter<PropertyForRentState> emit) async {
    emit(PropertyForRentLoading());
    final state = this.state;
    try {
      if (state is PropertyForRentLoading) {
        final propertyForRent = await propertyForRentRepo.getPropertyForRent(
            1, pageSize, event.status, event.name);
        pageNum = 1;
        emit(PropertyForRentLoaded(propertyForRents: propertyForRent));
      }

      // else {
      //   if (state is PropertyForRentLoaded) {
      //     final propertyForRent = await propertyForRentRepo.getPropertyForRent(
      //         ++pageNum, pageSize, event.status);

      //     if (propertyForRent.isEmpty) {
      //       emit(state.copyWith(hasReachedMax: true));
      //     } else {
      //       emit(state.copyWith(
      //           propertyForRents: state.propertyForRents + propertyForRent));
      //     }
      //   }
      // }
    } catch (e) {
      emit(PropertyForRentError(e.toString()));
    }
  }

  // FutureOr<void> _onGetPropertyForRentByIdRequested(
  //     GetPropertyForRentByIdRequested event,
  //     Emitter<PropertyForRentState> emit) async {
  //   final state = this.state;
  //   try {
  //     final propertyForRent =
  //         await propertyForRentRepo.getPropertyForRentById(event.id);
  //     emit(PropertyForRentByIdLoaded(propertyForRent));
  //   } catch (e) {
  //     emit(PropertyForRentError(e.toString()));
  //   }
  // }

  void _onUpdateProperty(
      UpdateProperty event, Emitter<PropertyForRentState> emit) async {
    // final state = this.state;
    // if (state is PropertyForRentLoaded) {
    emit(PropertyForRentLoading());

    try {
      await propertyForRentRepo.updateProperty(event.property);
      await propertyForRentRepo.updateImage(event.image, event.property.id!);

      await propertyForRentRepo.deleteMedia(event.mediaAdd!, event.mediaSaved!);
      // propertyForRentRepo.getPropertyForRentById(id)

      // add(const GetPropertyForRentRequested(2, "", true));
      // final propertyForRent =
      //     await propertyForRentRepo.getPropertyForRent(1, pageSize, 2, "");
      // var property =
      //     await propertyForRentRepo.getPropertyForRent(1, 5, 2, "");
      // await Future<void>.delayed(const Duration(seconds: 1));

      // emit(PropertyForRentLoaded(propertyForRents: property));
      // emit(PropertyForRentLoading());
      emit(UpdatedSuccessProperty());
      add(const GetPropertyForRentRequested(2, "", true));
    } catch (e) {
      emit(PropertyForRentError(e.toString()));
      // emit(const PropertyForRentLoaded());
    }
    // }
  }

  void _onSearchProperty(
      SearchProperty event, Emitter<PropertyForRentState> emit) async {
    final state = this.state;
    //  emit(PropertyForRentLoading());
    if (state is PropertyForRentLoaded ||
        state is RentedPropertyForRentLoaded) {
      try {
        emit(PropertyForRentLoading());
        final property = await propertyForRentRepo.searchProperty(
            1, 5, event.status, event.name);
        emit(PropertyForRentLoaded(propertyForRents: property));
      } catch (e) {
        emit(PropertyForRentError(e.toString()));
      }
    }
  }

  void _onGetPropertyForRentByIdRequested(GetPropertyForRentByIdRequested event,
      Emitter<PropertyForRentState> emit) async {
    final state = this.state;
    emit(PropertyForRentLoading());

    // if (state is PropertyForRentLoaded || event.isInit) {
    try {
      final property =
          await propertyForRentRepo.getPropertyForRentById(event.id);
      emit(PropertyForRentIdLoaded(property: property));
    } catch (e) {
      emit(PropertyForRentError(e.toString()));
    }
    // }
  }

  FutureOr<void> _onGetRentedPropertyForRentRequested(
      GetRentedPropertyForRentRequested event,
      Emitter<PropertyForRentState> emit) async {
    try {
      if (event.isInit!) {
        emit(PropertyForRentLoading());
      }
      final state = this.state;
      if (state is PropertyForRentLoading) {
        pageNum = 1;
        final propertyForRent = await propertyForRentRepo.getPropertyRented(
            pageNum, pageSize, event.name);
        // await Future<void>.delayed(const Duration(seconds: 1));

        emit(RentedPropertyForRentLoaded(propertyForRents: propertyForRent));
      } else {
        if (state is RentedPropertyForRentLoaded) {
          final propertyForRent = await propertyForRentRepo.getPropertyForRent(
              ++pageNum, pageSize, status, event.name);

          if (propertyForRent.isEmpty) {
            emit(state.copyWith(hasReachedMax: true));
          } else {
            if (pageNum > 1) {
              emit(state.copyWith(
                  propertyForRents: state.propertyForRents + propertyForRent));
            } else {
              emit(RentedPropertyForRentLoaded(
                  propertyForRents: propertyForRent));
            }
          }
        }
      }
    } catch (e) {
      emit(PropertyForRentError(e.toString()));
    }
  }

  FutureOr<void> _onUpdateStatusProperty(
      UpdateStatusProperty event, Emitter<PropertyForRentState> emit) async {
    emit(PropertyForRentLoading());

    try {
      await propertyForRentRepo.updateStatusProperty(event.property);
      emit(UpdatedSuccessProperty());
      // add(const GetPropertyForRentRequested(2, "", true));
    } catch (e) {
      emit(PropertyForRentError(e.toString()));
      // emit(const PropertyForRentLoaded());
    }
  }
}
