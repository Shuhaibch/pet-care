// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pet_care/app_view.dart';
import 'package:pet_care/models/all_report.dart';
import 'package:pet_care/presentation/officers/office_chat/office_chat_screen.dart';
import 'package:pet_care/presentation/officers/office_profile/office_profle_screen.dart';
import 'package:pet_care/presentation/user/widgets/office_single_report.dart';
import 'package:user_repository/user_repository.dart';

import '../../../application/bloc/report/report_bloc.dart';
import '../../admin/screens/ad_report/widgets/single_report_screen.dart';
import '../../user/screens/chat/new_chat/new_chat_screen.dart';

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
      backgroundColor: title == 'User'
          ? Colors.grey[900]
          : title == 'Forest'
              ? Colors.green[900]
              : title == 'Police'
                  ? const Color.fromARGB(255, 8, 42, 93)
                  : Colors.red[900],
      appBar: AppBar(
        backgroundColor: title == 'User'
            ? Colors.grey[900]
            : title == 'Forest'
                ? Colors.green[900]
                : title == 'Police'
                    ? const Color.fromARGB(255, 8, 42, 93)
                    : Colors.red[900],
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
                  builder: (context) => const OfficeChatScreen(),
                ));
              },
              child: const Icon(
                Icons.message,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                navigatorKey.currentState!.push(MaterialPageRoute(
                  builder: (context) => const OfficerProfileScreen(),
                ));
              },
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          BlocConsumer<ReportBloc, ReportState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetAllReportSuccess) {
                final List<AllReport> report = state.reportList
                    .where((element) => element.report.catagory == title)
                    .toList();

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
                  child: Image(
                    alignment: Alignment.center,
                    height: 80,
                    image: AssetImage(
                      "assets/images/petapplogo.png",
                    ),
                    fit: BoxFit.cover,
                  ),
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
                builder: (context) =>
                    ADSingleReportScreen(report: singleReport),
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
