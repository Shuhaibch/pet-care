// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:report_repository/report_repository.dart';

/// User Model
class Report extends Equatable {
  final String reportId;
  final String? userId;
  final String? reportPhoto;
  final Timestamp? date;
  final String? location;
  final String? description;
  final String? status;
  final String catagory;

  const Report({
    required this.reportId,
    required this.userId,
    required this.reportPhoto,
    required this.date,
    required this.location,
    required this.description,
    required this.catagory,
    this.status,
  });

  /// Empty User
  static final empty = Report(
    reportId: '',
    userId: '',
    reportPhoto: "",
    date: Timestamp.now(),
    description: '',
    location: '',
    catagory: '',
    status: '',
  );

  /// Report Copywith
  Report copyWith({
    String? reportId,
    String? userId,
    String? reportPhoto,
    Timestamp? date,
    String? location,
    String? description,
    String? catagory,
    String? status,
  }) {
    return Report(
      reportId: reportId ?? this.reportId,
      userId: userId ?? this.userId,
      reportPhoto: reportPhoto ?? this.reportPhoto,
      date: date ?? this.date,
      location: location ?? this.location,
      description: description ?? this.description,
      catagory: catagory??this.catagory,
      status: status ?? this.status,
    );
  }

  /// Convienent getter to determine wheather the user is empty
  bool get isEmpty => this == Report.empty;

  /// Convienent getter to determine wheather the user is not empty
  bool get isNotEmpty => this != Report.empty;

  ///from local to firebase
  ReportEntity toEntity() {
    return ReportEntity(
        reportId: reportId,
        userId: userId,
        reportPhoto: reportPhoto,
        date: date,
        location: location,
        description: description,
        catagory:catagory,
        status: status);
  }

  ///Form Firebase to local storage
  static Report fromEntity(ReportEntity entity) {
    return Report(
      reportId: entity.reportId,
      userId: entity.userId,
      reportPhoto: entity.reportPhoto,
      date: entity.date,
      location: entity.location,
      description: entity.description,
      catagory:entity.catagory,
      status: entity.status,
    );
  }

  @override
  List<Object?> get props => [
        reportId,
        userId,
        reportPhoto,
        date,
        location,
        description,
        status,
      ];
}
