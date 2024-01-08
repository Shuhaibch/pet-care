part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object> get props => [];
}

class CreateReport extends ReportEvent {
  final Report report;
  const CreateReport({required this.report});
}

class GetAllReport extends ReportEvent {}

class UpdateReport extends ReportEvent {
  final Report report;

  const UpdateReport({required this.report});
}

class DelteReport extends ReportEvent {
  final String reportId;

  const DelteReport({required this.reportId});
}
