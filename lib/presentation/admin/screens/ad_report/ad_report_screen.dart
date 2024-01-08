import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/app_view.dart';
import 'package:pet_care/application/bloc/report/report_bloc.dart';
import 'package:pet_care/models/all_report.dart';
import 'package:pet_care/presentation/admin/screens/ad_report/widgets/single_report_screen.dart';
import 'package:pet_care/presentation/user/screens/main_screen.dart';
import 'package:pet_care/presentation/user/widgets/office_single_report.dart';

class ADReportScreen extends StatefulWidget {
  const ADReportScreen({super.key});

  @override
  State<ADReportScreen> createState() => _ADReportScreenState();
}

class _ADReportScreenState extends State<ADReportScreen> {
  @override
  void initState() {
    context.read<ReportBloc>().add(GetAllReport());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Reports',
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        BlocConsumer<ReportBloc, ReportState>(
          // buildWhen: (previous, current) => current is GetAllReportSuccess,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetAllReportSuccess) {
              return Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemCount: state.reportList.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemBuilder: (context, index) {
                    final AllReport report = state.reportList[index];
                    Timestamp timestamp = Timestamp(report.report.date!.seconds,
                        report.report.date!.nanoseconds);

                    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                      timestamp.seconds * 1000 +
                          (timestamp.nanoseconds / 1000000).round(),
                      isUtc: true,
                    );
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(dateTime);

                    //* Single AllReport Container
                    return InkWell(
                      onTap: () {
                        navigatorKey.currentState!.push(MaterialPageRoute(
                          builder: (context) =>
                              SingleReportScreen(report: report),
                        ));
                      },
                      child: OfficeSingleReport(
                        height: height,
                        width: width,
                        report: report,
                        formattedDate: formattedDate,
                      ),
                    );
                  },
                ),
              );
            } else if (state is GetAllReportError) {
              return Center(
                child: Text(
                  "Error Occured",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              );
            }
            return const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ],
    );
  }
}
