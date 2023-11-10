import 'package:flutter/material.dart';
import 'package:pet_care/config/config.dart';

import 'widgets/list_container.dart';

class ReportScreen extends StatelessWidget {
  static const String routeName = '/report';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ReportScreen(),
    );
  }

  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Report',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          kheight10,
          Expanded(
            child: ListView(
              shrinkWrap: false,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/police');
                  },
                  child: ListCard(
                      height: height,
                      title: "Police",
                      imagelocation: 'assets/images/policeman.png'),
                ),
                ListCard(
                    height: height,
                    title: "Forest",
                    imagelocation: 'assets/images/forest.png'),
                ListCard(
                    height: height,
                    title: "Vectinary",
                    imagelocation: 'assets/images/clinic.png'),
                ListCard(
                    height: height,
                    title: "Adopt Me",
                    imagelocation: 'assets/images/adopt.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
