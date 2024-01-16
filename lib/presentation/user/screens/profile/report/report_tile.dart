// ignore_for_file: public_member_api_docs, sort_constructors_first, no_leading_underscores_for_local_identifiers
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pet_care/presentation/user/widgets/networl_image.dart';
import 'package:report_repository/report_repository.dart';

import 'package:pet_care/app_view.dart';
import 'package:user_repository/user_repository.dart';

import '../../notifier/notifier.dart';
import 'widget/single_report.screen.dart';

class ReportTile extends StatelessWidget {
  final String title;
  const ReportTile({
    super.key,
    required this.title,
    required this.report,
    required this.myUser,
  });
  final List<Report> report;
  final MyUser myUser;

  @override
  Widget build(BuildContext context) {
    log(report.length.toString());
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.chevron_left_outlined,
            color: Colors.white,
          ),
        ),
        titleSpacing: .01,
        title: Text(
          title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        centerTitle: false,
      ),
      body: ValueListenableBuilder(
          valueListenable: reportListNotifier,
          builder: (context, value, child) {
            if (value.isNotEmpty) {
              return Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 15,
                  ),
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    final _report = value[index];
                    return InkWell(
                      onTap: () {
                        navigatorKey.currentState!.push(MaterialPageRoute(
                            builder: (context) => SingleReportScreen(
                                report: _report, user: myUser)));
                      },
                      child: SizedBox(
                        width: width * 02,
                        height: height * .4,
                        child: CustNetWorkImage(imageUrl: _report.reportPhoto),
                      ),
                    );
                  },
                ),
              );
            } else if (value.isEmpty) {
              return Center(
                child: Text(
                  "List is Empty",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              );
            }
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.grey,
            ));
          }),
    );
  }
}
