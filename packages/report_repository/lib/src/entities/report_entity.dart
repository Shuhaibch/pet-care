import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ReportEntity extends Equatable {
  final String reportId;
  final String userId;
  final String reportPhoto;
  final Timestamp date;
  final String caption;
  final GeoPoint location;
  final String description;

  const ReportEntity({
    required this.reportId,
    required this.userId,
    required this.reportPhoto,
    required this.date,
    required this.caption,
    required this.location,
    required this.description,
  });

  /// To The Firebase
  Map<String, Object?> toDocument() {
    return {
      'reportId': reportId,
      'userId': userId,
      'reportPhoto': reportPhoto,
      'date': date,
      'caption': caption,
      'location': location,
      'description': description,
    };
  }

  ///From the firebase
  static ReportEntity formDocument(Map<String, dynamic> doc) {
    return ReportEntity(
      reportId: doc['reportId'],
      userId: doc['userId'],
      reportPhoto: doc['reportPhoto'],
      date: doc['date'],
      caption: doc['caption'],
      location: doc['location'],
      description: doc['description'],
    );
  }

  /// toString override
  @override
  String toString() {
    return ''' ReportEntity(
      reportId: $reportId,
      userId: $caption,
      reportPhoto:$reportPhoto,
      date: $date,
      caption: $caption,
      location: $location,
      description: $description,
    )''';
  }

  @override
  List<Object?> get props => [
        reportId,
        userId,
        caption,
        reportPhoto,
        date,
        caption,
        location,
        description
      ];
}
