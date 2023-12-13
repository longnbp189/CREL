part of 'contract_bloc.dart';

abstract class ContractEvent extends Equatable {
  const ContractEvent();

  @override
  List<Object> get props => [];
}

class CreateContract extends ContractEvent {
  final Contract contract;
  // final List<XFile> image;
  // final List<Media>? mediaAdd;
  // final List<Media>? mediaSaved;
  // final Store store;
  const CreateContract(this.contract
      // , this.image
      // , this.mediaAdd, this.mediaSaved
      // , this.store
      );
  @override
  List<Object> get props => [
        contract
        // , image
        // , store
      ];
}

class DownloadContract extends ContractEvent {
  final Contract contract;
  const DownloadContract(this.contract);
  @override
  List<Object> get props => [contract];
}

class SearchContractByMonth extends ContractEvent {
  final DateTime startDayOfMonth;
  final DateTime endDayOfMonth;
  // final int status;
  final bool isInit;
  const SearchContractByMonth(
      this.startDayOfMonth, this.endDayOfMonth, this.isInit);
  @override
  List<Object> get props => [startDayOfMonth, endDayOfMonth, isInit];
}

class UpdateContract extends ContractEvent {
  final Contract contract;
  const UpdateContract(this.contract);
  @override
  List<Object> get props => [contract];
}

class UpdateImageContract extends ContractEvent {
  final Contract contract;

  final List<XFile> image;
  final int id;

  const UpdateImageContract(this.contract, this.image, this.id);
  @override
  List<Object> get props => [contract, image, id];
}

class DeleteContract extends ContractEvent {
  final Contract contract;
  const DeleteContract(this.contract);
  @override
  List<Object> get props => [contract];
}

class GetContractByIdRequested extends ContractEvent {
  final int id;
  const GetContractByIdRequested(this.id);
  @override
  List<Object> get props => [id];
}

class GetContractByBrand extends ContractEvent {
  final int id;
  const GetContractByBrand(this.id);
  @override
  List<Object> get props => [id];
}

class GetContractRequested extends ContractEvent {
  final bool isInit;
  const GetContractRequested(this.isInit);
  @override
  List<Object> get props => [isInit];
}
