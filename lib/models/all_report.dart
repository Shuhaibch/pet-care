import 'package:equatable/equatable.dart';
import 'package:report_repository/report_repository.dart';
import 'package:user_repository/user_repository.dart';

class AllReport extends Equatable {
  final Report report;
  final MyUser user;

  const AllReport({
    required this.report,
    required this.user,
  });

  /// Empty Report
  static final empty = AllReport(report: Report.empty, user: MyUser.empty);

  /// Copy Report Methord
  AllReport copyWith({
    Report? report,
    MyUser? user,
  }) {
    return AllReport(
      report: report ?? this.report,
      user: user ?? this.user,
    );
  }

  /// Convienent getter to determine wheather the Report is empty
  bool get isEmpty => this == AllReport.empty;

  /// Convienent getter to determine wheather the Report is not empty
  bool get isNotEmpty => this != AllReport.empty;
  @override
  String toString() {
    return '''Allreport(
      Report: $report
        user: $user
        )''';
  }

  // addLike({required String userId}) {
  //   Report.like!.add(userId);
  //   return Report.like;
  // }

  // removeLike({required String userId}) {
  //   Report.like!.remove(userId);
  //   return Report.like;
  // }

  @override
  List<Object?> get props => [];
}
