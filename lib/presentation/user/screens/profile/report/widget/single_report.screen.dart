// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/app_view.dart';
import 'package:pet_care/application/bloc/user/user_bloc.dart';
import 'package:pet_care/presentation/user/screens/home/home_screen.dart';
import 'package:pet_care/presentation/user/screens/notifier/notifier.dart';
import 'package:report_repository/report_repository.dart';
import 'package:user_repository/user_repository.dart';
import '../../../../../../config/config.dart';
import '../../../../widgets/widget.dart';
import '../../../home/widget/widget.dart';
import 'upload_button.dart';

class SingleReportScreen extends StatefulWidget {
  const SingleReportScreen({
    super.key,
    required this.report,
    required this.user,
  });
  final Report report;
  final MyUser user;

  @override
  State<SingleReportScreen> createState() => _SingleReportScreenState();
}

class _SingleReportScreenState extends State<SingleReportScreen> {
  String? formattedDate;
  @override
  void initState() {
    super.initState();
    formattedDate = formateDate(widget.report.date!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.25),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Column(
            children: [
              //* profile with name and photo
              ProfileRowInMainCard(
                width: width,
                height: height,
                imageUrl: widget.report.reportPhoto!,
                date: formattedDate!,
                userName: widget.user.name,
              ),
              kheight10,

              //* Main Picture
              Container(
                width: width * .8,
                height: height * .23,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: CustNetWorkImage(
                  imageUrl: widget.report.reportPhoto,
                ),
              ),
              widget.report.description == null
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Description :",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10.0),
                            width: width * 0.62,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              widget.report.description!,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
              kheight10,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Location :",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    width: width * 0.65,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      widget.report.location!,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ],
              ),

              kheight10,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Catagory :",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 25.0),
                    // width: width * 0.65/,
                    // height: height * .,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      // maxLines: 5,
                      widget.report.catagory,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ],
              ),
              kheight10,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Status :",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 45.0),
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      widget.report.status!,
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: widget.report.status == 'reported'
                                    ? Colors.red
                                    : widget.report.status == 'Completed'
                                        ? Colors.green
                                        : Colors.yellow,
                              ),
                    ),
                  ),
                ],
              ),
              kheight20,
              BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is DeleteReportSuccess) {
                    final myList = reportListNotifier.value
                        .where((item) => item != widget.report)
                        .toList();

                    reportListNotifier.value = myList;

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Delete Success"),
                    ));
                    navigatorKey.currentState!.pop();
                  } else if (state is DeleteReportError) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Delete failed"),
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is DeleteReportLoading) {
                    return const LoadingButton();
                  }
                  return InkWell(
                    onTap: () {
                      context
                          .read<UserBloc>()
                          .add(DeleteReport(reportId: widget.report.reportId));
                    },
                    child: const UploadButton(title: "Delete"),
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
