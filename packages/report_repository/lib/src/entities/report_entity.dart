// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ReportEntity extends Equatable {
  final String reportId;
  final String? userId;
  final String? reportPhoto;
  final Timestamp? date;
  final String? location;
  final String? description;
  final String catagory;
  final String? status;

  const ReportEntity({
    required this.reportId,
    required this.userId,
    required this.reportPhoto,
    required this.date,
    required this.location,
    required this.description,
    required this.catagory,
    this.status,
  });

  /// To The Firebase
  Map<String, Object?> toDocument() {
    return {
      'reportId': reportId,
      'userId': userId,
      'reportPhoto': reportPhoto,
      'date': date,
      'location': location,
      'description': description,
      'catagory':catagory,
      'status': status,
    };
  }

  ///From the firebase
  static ReportEntity fromDocument(Map<String, dynamic> doc) {
    return ReportEntity(
      reportId: doc['reportId'],
      userId: doc['userId'],
      reportPhoto: doc['reportPhoto'],
      date: doc['date'],
      location: doc['location'],
      description: doc['description'],
      catagory:doc['catagory'],
      status: doc['status'],
    );
  }

  /// toString override
  @override
  String toString() {
    return ''' ReportEntity(
      reportId: $reportId,
      userId: $userId,
      reportPhoto:$reportPhoto,
      date: $date,
      location: $location,
      description: $description,
      catagory:$catagory,
      status: $status,
    )''';
  }

  @override
  List<Object?> get props => [
        reportId,
        userId,
        reportPhoto,
        date,
        location,
        description,
        catagory,
        status,
      ];
}
