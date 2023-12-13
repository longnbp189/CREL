part of 'contract_bloc.dart';

abstract class ContractState extends Equatable {
  const ContractState();

  @override
  List<Object> get props => [];
}

class ContractLoading extends ContractState {}

class ContractUpdateSuccess extends ContractState {}

class ContractUpdateImageSuccess extends ContractState {}

class ContractUpdateImageFail extends ContractState {
  final String error;

  const ContractUpdateImageFail(this.error);
  @override
  List<Object> get props => [error];
}

class ContractDeleteSuccess extends ContractState {}

class ContractDownloadSuccess extends ContractState {}

class ContractDownloadFail extends ContractState {}

class ContractCreateSuccess extends ContractState {}

// class ContractLoaded extends ContractState {
//   final List<Contract> contracts;
//   final bool hasReachedMax;
//   final int? status;

//   const ContractLoaded(
//       {this.contracts = const <Contract>[],
//       this.hasReachedMax = false,
//       this.status});

//   ContractLoaded copyWith(
//       {List<Contract>? contracts, bool? hasReachedMax, int? status}) {
//     return ContractLoaded(
//         contracts: contracts ?? this.contracts,
//         hasReachedMax: hasReachedMax ?? this.hasReachedMax,
//         status: status ?? this.status);
//   }

//   @override
//   List<Object> get props => [contracts, hasReachedMax];
// }

class ContractLoaded extends ContractState {
  final List<Contract> contracts;
  final bool hasReachedMax;
  final int? status;

  const ContractLoaded(
      {this.contracts = const <Contract>[],
      this.hasReachedMax = false,
      this.status});

  ContractLoaded copyWith(
      {List<Contract>? contracts, bool? hasReachedMax, int? status}) {
    return ContractLoaded(
        contracts: contracts ?? this.contracts,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [contracts, hasReachedMax];
}

class ContractByIdLoaded extends ContractState {
  final Contract contract;

  const ContractByIdLoaded({required this.contract});
  @override
  List<Object> get props => [contract];
}

class ContractError extends ContractState {
  final String error;

  const ContractError(this.error);
  @override
  List<Object> get props => [error];
}
