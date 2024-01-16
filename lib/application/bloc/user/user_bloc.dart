import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_repository/post_repository.dart';
import 'package:report_repository/report_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ReportRepository _reportRepository;
  final PostRepo _postRepo;
  final UserRepository _userRepository;
  UserBloc({
    required UserRepository userRepository,
    required ReportRepository reportRepository,
    required PostRepo postRepo,
  })  : _postRepo = postRepo,
        _userRepository = userRepository,
        _reportRepository = reportRepository,
        super(UserInitial()) {
    List<Report> userReportList = [];
    List<Post> userPostList = [];
    //* get User report
    on<GetUserData>((event, emit) async {
      emit(GetUserDataLoading());
      try {
        userReportList = await _reportRepository.getReport(event.userId);
        userPostList = await _postRepo.getUserPost(event.userId);
        final MyUser user = await _userRepository.getUserData(event.userId);
        log(user.toString(), name: ' user details');
        emit(GetUserDataSuccess(
            userReportList: userReportList,
            userPostList: userPostList,
            userDetail: user));
      } catch (e) {
        log(e.toString(), name: "on User Report");
        emit(GetUserDataError(errorMsg: e.toString()));
      }
    });
    // *  Update Report
    on<UpdateReport>((event, emit) async {
      emit(UpdateReportLoading());
      try {
        _reportRepository.updateReport(event.report);
        emit(UpdateReportSuccess());
      } catch (e) {
        log(e.toString(), name: "on Update Report");
        emit(UpdateReportError(errorMsg: e.toString()));
      }
    });

    //* Delete Report
    on<DeleteReport>((event, emit) {
      log("delete");
      emit(DeleteReportLoading());
      try {
        _reportRepository.deleteReport(event.reportId);
        emit(DeleteReportSuccess());
      } catch (e) {
        log(e.toString(), name: "on Deltete Report");
        emit(DeleteReportError(errorMsg: e.toString()));
      }
    });

    //* update post
    on<UpdatePost>((event, emit) async {
      try {
        await _postRepo.updatePost(event.post);
      } catch (e) {
        log(e.toString());
      }
    });

    //* Remove User Profile pic
    on<RemoveProfilePic>((event, emit) async {
      emit(RemoveProfileLoading());
      try {
        await _userRepository.updateUserDetails(event.myUser);
        emit(RemoveProfileSuccess());
      } catch (e) {
        log(e.toString(), name: "on User Report");
        emit(RemoveProfileError(errorMsg: e.toString()));
      }
    });

    //* Delete Post
    on<DeletePost>((event, emit){
      emit(DeletePostLoading());
      try {
        _postRepo.deletePost(event.post);
        emit(DeletePostSuccess());
      } catch (e) {
        log(e.toString(), name: "on Deltete Post");
        emit(DeletePostError(errorMsg: e.toString()));
      }
    });
  }
}
