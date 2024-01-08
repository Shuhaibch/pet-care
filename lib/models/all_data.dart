import 'package:equatable/equatable.dart';
import 'package:post_repository/post_repository.dart';
import 'package:report_repository/report_repository.dart';
import 'package:user_repository/user_repository.dart';

class AllData extends Equatable {
  final MyUser myUser;
  final List<Post> post;
  final List<Report> report;

  const AllData({
    required this.myUser,
    required this.post,
    required this.report,
  });

  /// Empty Report
  static const empty = AllData(
    report: [],
    myUser: MyUser.empty,
    post: [],
  );

  /// Copy Report Methord
  AllData copyWith({
    List<Report>? report,
    MyUser? myUser,
    List<Post>? post,
  }) {
    return AllData(
      report: report ?? this.report,
      myUser: myUser ?? this.myUser,
      post: post ?? this.post,
    );
  }

  /// Convienent getter to determine wheather the Report is empty
  bool get isEmpty => this == AllData.empty;

  /// Convienent getter to determine wheather the Report is not empty
  bool get isNotEmpty => this != AllData.empty;
  @override
  String toString() {
    return '''AllData(
      Report: $report
        user: $myUser
        post: $post
        )''';
  }

  @override
  List<Object?> get props => [
        myUser,
        post,
        report,
      ];
}
