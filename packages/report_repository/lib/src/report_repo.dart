import 'package:report_repository/report_repository.dart';

abstract class ReportRepository {
  Future<List<Report>> getReport(String userId);
  Future<void> updateReport(Report report);
  Future<void> createReport(Report report);
  Future<void> deleteReport(String reportId);
  Future<List<Report>> getAllReport();
  Future<String> upLoadPicture(String file, String reportId);

}
