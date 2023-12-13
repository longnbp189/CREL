import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crel_mobile/config/app_format.dart';
import 'package:crel_mobile/models/contract.dart';
import 'package:crel_mobile/modules/appointment/repos/contract_repo.dart';
import 'package:crel_mobile/modules/home/repos/property_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'contract_event.dart';
part 'contract_state.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  final ContractRepo contractRepo;
  PropertyRepo? propertyRepo;
  int pageNum = 1;
  int pageSize = 20;
  DateTime date = DateTime(DateTime.now().year, DateTime.now().month);

  // int? status;
  ContractBloc({required this.contractRepo, this.propertyRepo})
      : super(ContractLoading()) {
    on<CreateContract>(_onCreateContract);
    on<GetContractByIdRequested>(_onGetContractByIdRequested);
    on<GetContractRequested>(_onGetContractRequested);
    on<GetContractByBrand>(_onGetContractByBrand);
    on<UpdateContract>(_onUpdateContract);
    on<DeleteContract>(_onDeleteContract);
    on<SearchContractByMonth>(_onSearchContractByMonth);
    // on<DownloadContract>(_onDownloadContract);
    on<UpdateImageContract>(_onUpdateImageContract);
  }

  FutureOr<void> _onCreateContract(
      CreateContract event, Emitter<ContractState> emit) async {
    emit(ContractLoading());

    try {
      var contract = await contractRepo.createContract(event.contract);
      event.contract.id = contract.id;
      await contractRepo.downloadNoti(event.contract);
      // await contractRepo.downloadFile(event.contract);

      // contract = event.contract;
      // event.contract.id = contract.id;
      // await contractRepo.updateImageContract(event.image, event.contract.id!);
      // event.contract.property = contract.property;
      // event.contract.property!.status = 3;
      // await propertyRepo!.updateStatusProperty(event.contract.property!);
      // await contractRepo.deleteMediaContract(event.mediaAdd!, event.mediaSaved!);
      // event.store.startDate = contract.startDate;
      // event.store.endDate = contract.endDate;
      // await contractRepo.createStore(event.store);
      // event.contract.storeId = store.id;
      // emit(ContractLoaded(contracts: contract));
      emit(ContractCreateSuccess());
      add(SearchContractByMonth(
          AppFormat.startDayOfMonth(AppFormat.getYearAndMonthNow()),
          AppFormat.endDayOfMonth(AppFormat.getYearAndMonthNow()),
          true));

      // add(GetContractByIdRequested(event.contract.id!));
    } catch (e) {
      emit(ContractError(e.toString()));
    }
  }

  FutureOr<void> _onGetContractByIdRequested(
      GetContractByIdRequested event, Emitter<ContractState> emit) async {
    emit(ContractLoading());
    try {
      final contract = await contractRepo.getContractById(event.id);
      emit(ContractByIdLoaded(contract: contract));
    } catch (e) {
      emit(ContractError(e.toString()));
    }
  }

  FutureOr<void> _onGetContractRequested(
      GetContractRequested event, Emitter<ContractState> emit) async {
    final state = this.state;

    if (event.isInit) {
      emit(ContractLoading());
    }
    try {
      if (state is ContractLoading || event.isInit) {
        pageNum = 1;

        final contracts = await contractRepo.getListContract(pageNum, pageSize);
        emit(ContractLoaded(contracts: contracts));
      } else {
        if (state is ContractLoaded) {
          final contracts =
              await contractRepo.getListContract(++pageNum, pageSize);

          if (contracts.isEmpty) {
            emit(state.copyWith(hasReachedMax: true));
          } else {
            if (pageNum > 1) {
              emit(state.copyWith(contracts: state.contracts + contracts));
            } else {
              emit(ContractLoaded(contracts: contracts));
            }
          }
        }
      }
    } catch (e) {
      emit(ContractError(e.toString()));
    }
  }

  FutureOr<void> _onGetContractByBrand(
      GetContractByBrand event, Emitter<ContractState> emit) async {
    emit(ContractLoading());
    try {
      final contract = await contractRepo.getContractByBrand(event.id);
      emit(ContractByIdLoaded(contract: contract));
    } catch (e) {
      emit(ContractError(e.toString()));
    }
  }

  FutureOr<void> _onUpdateContract(
      UpdateContract event, Emitter<ContractState> emit) async {
    // final state = this.state;
    // if (state is ContractLoaded || state is ContractByIdLoaded) {
    try {
      emit(ContractLoading());

      await contractRepo.updateContract(event.contract);
      // event.contract.property = contract.property;
      // event.contract.property!.status = 3;
      // await propertyRepo!.updateStatusProperty(event.contract.property!);
      await contractRepo.downloadNoti(event.contract);

      emit(ContractUpdateSuccess());
      // emit(ContractLoaded(contracts: contract));
      // add(GetContractByIdRequested(event.contract.id!));
      add(SearchContractByMonth(
          AppFormat.startDayOfMonth(AppFormat.getYearAndMonthNow()),
          AppFormat.endDayOfMonth(AppFormat.getYearAndMonthNow()),
          true));
    } catch (e) {
      emit(ContractError(e.toString()));
    }
    // }
  }

  FutureOr<void> _onDeleteContract(
      DeleteContract event, Emitter<ContractState> emit) async {
    // final state = this.state;
    // if (state is ContractLoaded || state is ContractByIdLoaded) {
    emit(ContractLoading());

    try {
      await contractRepo.updateContract(event.contract);

      // contract = event.contract;
      // event.contract.id = contract.id;
      // await contractRepo.updateImageContract(event.image, event.contract.id!);
      // event.contract.property = contract.property;
      // event.contract.property!.status = 0;
      // contract.property = event.contract.property;
      // contract.property!.status = 0;
      // await propertyRepo!.updateStatusProperty(contract.property!);

      emit(ContractDeleteSuccess());
      add(SearchContractByMonth(
          AppFormat.startDayOfMonth(AppFormat.getYearAndMonthNow()),
          AppFormat.endDayOfMonth(AppFormat.getYearAndMonthNow()),
          true));

      // emit(ContractLoaded(contracts: contract));
      // add(SearchContractByMonth(AppFormat.startDayOfMonth(date),
      //     AppFormat.endDayOfMonth(date), true));
    } catch (e) {
      emit(ContractError(e.toString()));
    }
    // }
  }

  FutureOr<void> _onSearchContractByMonth(
      SearchContractByMonth event, Emitter<ContractState> emit) async {
    // emit(AppointmentLoading());
    final state = this.state;

    try {
      if (event.isInit) {
        emit(ContractLoading());

        final contracts = await contractRepo.searchContractByMonth(
            1, pageSize, event.startDayOfMonth, event.endDayOfMonth);
        emit(ContractLoaded(contracts: contracts));
      } else {
        if (state is ContractLoaded) {
          final contracts = await contractRepo.searchContractByMonth(
              ++pageNum, pageSize, event.startDayOfMonth, event.endDayOfMonth);
          if (contracts.isEmpty) {
            emit(state.copyWith(hasReachedMax: true));
          } else {
            if (pageNum > 1) {
              emit(state.copyWith(contracts: state.contracts + contracts));
            } else {
              emit(ContractLoaded(contracts: contracts));
            }
          }
        }
      }
    } catch (e) {
      emit(ContractError(e.toString()));
    }
  }

  // FutureOr<void> _onDownloadContract(
  //     DownloadContract event, Emitter<ContractState> emit) async {
  //   emit(ContractLoading());

  //   try {
  //     var isDownload = await contractRepo.downloadFile(event.contract);

  //     if (isDownload) {
  //       emit(ContractDownloadSuccess());
  //     } else {
  //       emit(ContractDownloadFail());
  //     }
  //   } catch (e) {
  //     emit(ContractError(e.toString()));
  //   }
  // }

  FutureOr<void> _onUpdateImageContract(
      UpdateImageContract event, Emitter<ContractState> emit) async {
    emit(ContractLoading());

    try {
      await contractRepo.updateImageContract(event.image, event.id);
      event.contract.property!.status = 3;
      await propertyRepo!.updateStatusProperty(event.contract.property!);
      // event.contract.property!.status = 3;
      await contractRepo.updateContract(event.contract);

      emit(ContractUpdateImageSuccess());
      // emit(ContractLoaded(contracts: contract));
      // add(GetContractByIdRequested(event.contract.id!));
      add(SearchContractByMonth(
          AppFormat.startDayOfMonth(AppFormat.getYearAndMonthNow()),
          AppFormat.endDayOfMonth(AppFormat.getYearAndMonthNow()),
          true));
    } catch (e) {
      emit(ContractUpdateImageFail(e.toString()));
    }
  }
}
