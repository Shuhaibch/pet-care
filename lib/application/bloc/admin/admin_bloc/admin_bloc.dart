import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_care/models/all_data.dart';
import 'package:post_repository/post_repository.dart';
import 'package:report_repository/report_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final ReportRepository _reportRepository;
  final PostRepo _postRepo; 
  final UserRepository _userRepository;
  AdminBloc({
    required UserRepository userRepository,
    required ReportRepository reportRepository,
    required PostRepo postRepo,
  })  : _postRepo = postRepo,
        _userRepository = userRepository,
        _reportRepository = reportRepository,
        super(AdminInitial()) {
    List<Report> reportList = [];
    List<MyUser> myUserList = [];
    List<Post> postList = [];
    // List<AllData> allPostList = [];
    // List<AllData> allReportList = [];
    //* GEt All Data
    on<GetAllData>((event, emit) async {
      emit(GetAllDataLoading());
      try {
        reportList = await _reportRepository.getAllReport();
        postList = await _postRepo.getAllPost();
        myUserList = await _userRepository.getAllUser();
        List<AllData> allUserList = [];

        for (var userElement in myUserList) {
          if (userElement.userRole == "Admin") {
            continue;
          } else {
            List<Post> post = [];
            List<Report> report = [];
            for (var reportElement in reportList) {
              if (reportElement.userId == userElement.id) {
                report.add(reportElement);
              }
            }
            for (var postElement in postList) {
              if (postElement.userId == userElement.id) {
                post.add(postElement);
              }
            }
            AllData allData =
                AllData(myUser: userElement, post: post, report: report);
            allUserList.add(allData);
          }
        }
        log(allUserList.length.toString());
        emit(GetAllDataSuccess(allData: allUserList));
      } catch (e) {
        log(e.toString(), name: "on User Report");
        emit(GetAllDataError(errorMsg: e.toString()));
      }
    });
  }
}
