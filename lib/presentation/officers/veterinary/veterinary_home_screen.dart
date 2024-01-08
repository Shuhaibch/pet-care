// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/app_view.dart';
import 'package:pet_care/models/all_report.dart';
import 'package:pet_care/presentation/admin/screens/ad_report/widgets/single_report_screen.dart';
import 'package:pet_care/presentation/user/screens/main_screen.dart';
import 'package:pet_care/presentation/user/screens/profile/profile_screen.dart';
import 'package:pet_care/presentation/user/widgets/office_single_report.dart';
import 'package:user_repository/user_repository.dart';

import '../../../application/bloc/report/report_bloc.dart';

class VeterinaryHomeScreen extends StatelessWidget {
  const VeterinaryHomeScreen({
    super.key,
    required this.title,
    this.myUser,
  });
  final String title;
  final MyUser? myUser;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ReportBloc>(context).add(GetAllReport());
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                navigatorKey.currentState!.push(MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ));
              },
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                BlocProvider.of<ReportBloc>(context).add(GetAllReport());
              },
              child: const Icon(
                Icons.replay_outlined,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          BlocConsumer<ReportBloc, ReportState>(
            // buildWhen: (previous, current) => current is GetAllReportSuccess,
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetAllReportSuccess) {
                final List<AllReport> report = state.reportList;

                return ReportList(
                  report: report,
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
      ),
    );
  }
}

class ReportList extends StatelessWidget {
  final List<AllReport> report;
  const ReportList({
    super.key,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: report.length,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemBuilder: (context, index) {
          final AllReport singleReport = report[index];
          Timestamp timestamp = Timestamp(singleReport.report.date!.seconds,
              singleReport.report.date!.nanoseconds);

          DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
            timestamp.seconds * 1000 +
                (timestamp.nanoseconds / 1000000).round(),
            isUtc: true,
          );
          String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

          //* Single AllReport Container
          return InkWell(
            onTap: () {
              navigatorKey.currentState!.push(MaterialPageRoute(
                builder: (context) => SingleReportScreen(report: singleReport),
              ));
            },
            child: OfficeSingleReport(
              height: height,
              width: width,
              report: singleReport,
              formattedDate: formattedDate,
            ),
          );
        },
      ),
    );
  }
}
