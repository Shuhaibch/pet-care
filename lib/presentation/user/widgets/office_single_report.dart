import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet_care/models/all_report.dart';
import '../../../../../config/config.dart';

class OfficeSingleReport extends StatefulWidget {
  const OfficeSingleReport({
    super.key,
    required this.height,
    required this.width,
    required this.report,
    required this.formattedDate,
  });

  final double height;
  final double width;
  final AllReport report;
  final String formattedDate;

  @override
  State<OfficeSingleReport> createState() => _OfficeSingleReport();
}

class _OfficeSingleReport extends State<OfficeSingleReport> {
  bool isLiked = false;
  List like = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      // height: widget.height * .45,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.25),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        children: [
          kheight10,

          //* Main Picture
          Container(
            width: widget.width * .8,
            height: widget.height * .23,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: CachedNetworkImage(
              imageUrl: widget.report.report.reportPhoto!,
              imageBuilder: (context, imageProvider) => Container(
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
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                size: 50,
              ),
            ),
          ),
          widget.report.report.description == null
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5),
                  child: Row(
                    children: [
                      Text(
                        widget.report.report.description ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
