import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:report_repository/report_repository.dart';

class FirebaseReportRepository extends ReportRepository {
  final reportCollection = FirebaseFirestore.instance.collection("report");
  List<Report> reportList = [];
  List<Report> allReportList = [];

  //* create Report
  @override
  Future<void> createReport(Report report, String userId) async {
    try {
      await reportCollection
          .doc(report.reportId)
          .set(report.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  //* get report
  @override
  Future<List<Report>> getReport(String userId) async {
    try {
      QuerySnapshot reportSnapshot =
          await reportCollection.where('userId', isEqualTo: userId).get();

      reportSnapshot.docs.map(
        (doc) => reportList.add(
          Report(
            reportId: doc['reportId'],
            userId: doc['userId'],
            reportPhoto: doc['reportPhoto'],
            date: doc['date'],
            caption: doc['caption'],
            location: doc['location'],
            description: doc['description'],
          ),
        ),
      );
      return reportList;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  //* delete report
  @override
  Future<void> deleteReport(
    String reportId,
  ) async {
    try {
      final documentRef = reportCollection.doc(reportId);
      await documentRef.delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

//* Update Report
  @override
  Future<void> updateReport(Report report) async {
    await reportCollection
        .doc(report.reportId)
        .update(report.toEntity().toDocument());
  }

//* get all reports
  @override
  Future<List<Report>> getAllReport() async {
    try {
      allReportList = [];
      QuerySnapshot allReportSnapshot = await reportCollection.get();
      allReportSnapshot.docs.map(
        (doc) => allReportList.add(
          Report(
            reportId: doc['reportId'],
            userId: doc['userId'],
            reportPhoto: doc['reportPhoto'],
            date: doc['date'],
            caption: doc['caption'],
            location: doc['location'],
            description: doc['description'],
          ),
        ),
      );
      return allReportList;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
