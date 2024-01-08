import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:report_repository/report_repository.dart';

class FirebaseReportRepository extends ReportRepository {
  final reportCollection = FirebaseFirestore.instance.collection("report");
  List<Report> reportList = [];
  List<Report> allReportList = [];

  //* create Report
  @override
  Future<void> createReport(Report report) async {
    try {
      String url = await upLoadPicture(report.reportPhoto!, report.reportId);
      report = report.copyWith(reportPhoto: url);
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
      return await reportCollection
          .where('userId', isEqualTo: userId)
          .get()
          .then((value) => value.docs
              .map(
                  (e) => Report.fromEntity(ReportEntity.fromDocument(e.data())))
              .toList());
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
      return await reportCollection.get().then((value) => value.docs
          .map((e) => Report.fromEntity(ReportEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  //* upload image
  @override
  Future<String> upLoadPicture(String file, String reportId) async {
    try {
      File imageFile = File(file);
      Reference fireBaseStoreRef =
          FirebaseStorage.instance.ref().child('Report/$reportId');
      await fireBaseStoreRef.putFile(
          imageFile,
          SettableMetadata(
            contentType: "image/jpeg",
          ));
      String url = await fireBaseStoreRef.getDownloadURL();
      url = url.toString();
      return url;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
