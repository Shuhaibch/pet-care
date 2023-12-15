// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:report_repository/report_repository.dart';

/// User Model
class Report extends Equatable {
  final String reportId;
  final String userId;
  final String reportPhoto;
  final Timestamp date;
  final String caption;
  final GeoPoint location;
  final String description;

  const Report({
    required this.reportId,
    required this.userId,
    required this.reportPhoto,
    required this.date,
    required this.caption,
    required this.location,
    required this.description,
  });

  /// Empty User
  static final empty = Report(
    reportId: '',
    userId: '',
    reportPhoto: "",
    date: Timestamp.now(),
    caption: '',
    description: '',
    location: const GeoPoint(11.0732, 76.0740),
  );

  /// Report Copywith
  Report copyWith({
    String? reportId,
    String? userId,
    String? reportPhoto,
    Timestamp? date,
    String? caption,
    GeoPoint? location,
    String? description,
  }) {
    return Report(
      reportId: reportId ?? this.reportId,
      userId: userId ?? this.userId,
      reportPhoto: reportPhoto ?? this.reportPhoto,
      date: date ?? this.date,
      caption: caption ?? this.caption,
      location: location ?? this.location,
      description: description ?? this.description,
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
      caption: caption,
      location: location,
      description: description,
    );
  }

  ///Form Firebase to local storage
  static Report formEntity(ReportEntity entity) {
    return Report(
      reportId: entity.reportId,
      userId: entity.userId,
      reportPhoto: entity.reportPhoto,
      date: entity.date,
      caption: entity.caption,
      location: entity.location,
      description: entity.description,
    );
  }

  @override
  List<Object?> get props => [
        reportId,
        userId,
        reportPhoto,
        date,
        caption,
        location,
        description,
      ];
}
