// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/application/bloc/report/report_bloc.dart';
import 'package:pet_care/config/config.dart';
import 'package:pet_care/models/all_report.dart';
import 'package:pet_care/presentation/user/screens/main_screen.dart';
import 'package:report_repository/report_repository.dart';

import '../../../../../app_view.dart';

class SingleReportScreen extends StatelessWidget {
  SingleReportScreen({
    super.key,
    required this.report,
  });

  final List<String> progressList = [
    "Reported",
    'Investigating',
    "Completed"
  ];
  String? progress;
  AllReport report;
  final ValueNotifier<String> updateProgress = ValueNotifier("Select progress");
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  width: double.infinity,
                  // height: height * .43,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: const BorderRadius.all(
                      Radius.elliptical(20, 20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        //?profile
                        Container(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.transparent,
                                child: CachedNetworkImage(
                                  imageUrl: report.report.reportPhoto!,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                  placeholder: (context, url) => const SizedBox(
                                    height: 2.0,
                                    width: 2.0,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Color.fromARGB(255, 100, 6, 6),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                    size: 50,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        kheight10,
                        Column(
                          children: [
                            Text(
                              report.user.name,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            kheight10,
                            Text(
                              report.report.location!,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            kheight10,
                            Text(
                              report.report.catagory.isEmpty
                                  ? 'Catagoty'
                                  : report.report.catagory,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            kheight10,
                            Text(
                              report.report.reportId,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            kheight10,
                            Text(
                              report.report.status!,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            kheight10,
                            //* Drop Down List
                            SizedBox(
                              width: double.infinity,
                              child: Center(
                                child: ValueListenableBuilder(
                                  valueListenable: updateProgress,
                                  builder: (context, value, child) {
                                    return DropdownButton(
                                      alignment: AlignmentDirectional.center,
                                      dropdownColor: Colors.black,
                                      hint: Text(
                                        updateProgress.value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                      underline: const Divider(
                                          color: Colors.transparent),
                                      items: progressList.map((String value) {
                                        return DropdownMenuItem(
                                          onTap: () {
                                            updateProgress.value = value;
                                            progress = value;
                                          },
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (_) {
                                        updateProgress;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     Column(
                        //       children: [
                        //         Text(
                        //           "Posts",
                        //           style: Theme.of(context)
                        //               .textTheme
                        //               .displayMedium,
                        //         ),
                        //         Text(
                        //           state.userPostList.length.toString(),
                        //           style: Theme.of(context)
                        //               .textTheme
                        //               .displayMedium,
                        //         )
                        //       ],
                        //     ),
                        //     Column(
                        //       children: [
                        //         Text(
                        //           "Reports",
                        //           style: Theme.of(context)
                        //               .textTheme
                        //               .displayMedium,
                        //         ),
                        //         Text(
                        //           state.userReportList.length.toString(),
                        //           style: Theme.of(context)
                        //               .textTheme
                        //               .displayMedium,
                        //         )
                        //       ],
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              kheight10,
              // //* Uplaod Button
              BlocConsumer<ReportBloc, ReportState>(
                listener: (context, state) {
                  if (state is UpdateReportSuccess) {
                    // navigatorKey.currentState!
                    //     .pushReplacement(MaterialPageRoute(
                    //   builder: (context) => ADMainScreen(),
                    // ));
                    navigatorKey.currentState!.pop();
                  } else if(state is UpdateReportError){

                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            if (progress != null) {
                              Report updatedReport = report.report;
                              updatedReport =
                                  updatedReport.copyWith(status: progress);
                              context
                                  .read<ReportBloc>()
                                  .add(UpdateReport(report: updatedReport));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Update Status")));
                            }
                          },
                          child: Container(
                            width: width * .39,
                            height: height * .08,
                            decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: const BorderRadius.all(
                                    Radius.elliptical(20, 20))),
                            child: Center(
                              child: state is UpdateReportLoading
                                  ? CircularProgressIndicator(
                                      color: Colors.grey[900],
                                    )
                                  : Text(
                                      "Update",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
