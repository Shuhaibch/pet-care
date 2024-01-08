part of 'admin_bloc.dart';

abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

class AdminInitial extends AdminState {}

class GetAllDataSuccess extends AdminState {
  final List<AllData> allData;

  const GetAllDataSuccess({required this.allData});
}

class GetAllDataError extends AdminState {
  final String? errorMsg;

  const GetAllDataError({required this.errorMsg});
}

class GetAllDataLoading extends AdminState {}
