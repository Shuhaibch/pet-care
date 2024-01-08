part of 'report_bloc.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

//* Get Report
class GetAllReportSuccess extends ReportState {
  final List<AllReport> reportList;
  const GetAllReportSuccess({required this.reportList});
}

class GetAllReportLoading extends ReportState {}

class GetAllReportError extends ReportState {}

//* Create Report
class CreateReportSuccess extends ReportState {}

class CreateReportLoading extends ReportState {}

class CreateReportError extends ReportState {
  final String? errorMsg;
  const CreateReportError({required this.errorMsg});
}
//* Create Report
class UpdateReportSuccess extends ReportState {}

class UpdateReportLoading extends ReportState {}

class UpdateReportError extends ReportState {
  final String? errorMsg;
  const UpdateReportError({required this.errorMsg});
}
