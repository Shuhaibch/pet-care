import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_care/models/all_report.dart';
import 'package:report_repository/report_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ReportRepository _reportRepository;
  final UserRepository _userRepository;

  List<Report> allReportList = [];
  List<MyUser> allUserList = [];
  List<AllReport> reportList = [];
  AllReport report = AllReport.empty;
  ReportBloc({
    required ReportRepository reportRepository,
    required UserRepository userRepository,
  })  : _reportRepository = reportRepository,
        _userRepository = userRepository,
        super(ReportInitial()) {
    //* create Report
    on<CreateReport>((event, emit) async {
      emit(CreateReportLoading());
      try {
        await _reportRepository.createReport(event.report);
        emit(CreateReportSuccess());
      } catch (e) {
        log(e.toString(), name: "on create");
        emit(CreateReportError(errorMsg: e.toString()));
      }
    });

    //* get All Report
    on<GetAllReport>((event, emit) async {
      emit(GetAllReportLoading());
      try {
        allReportList = await _reportRepository.getAllReport();
        allUserList = await _userRepository.getAllUser();
        reportList = [];

        for (var reportElement in allReportList) {
          for (var userElement in allUserList) {
            if (reportElement.userId == userElement.id) {
              report = report.copyWith(
                report: reportElement,
                user: userElement,
              );
              reportList.add(report);
            }
          }
        }
        reportList.sort(
          (a, b) => b.report.date!.compareTo(a.report.date!),
        );
        emit(GetAllReportSuccess(reportList: reportList));
      } catch (e) {
        log(e.toString(), name: "on Get All Report");
      }
    });

    //* Update Report
    on<UpdateReport>((event, emit) async {
      emit(UpdateReportLoading());
      try {
        await _reportRepository.updateReport(event.report);
        emit(UpdateReportSuccess());
      } catch (e) {
        log(e.toString(), name: "on Update Report");
        emit(UpdateReportError(errorMsg: e.toString()));
      }
    });

  
  }
}
