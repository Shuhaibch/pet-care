import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:pet_care/app_view.dart';
import 'package:pet_care/presentation/user/screens/report/widgets/report_details_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OpenStreetMapSearchAndPick(
        onPicked: (pickedData) {
          setState(() {
            addressname = pickedData.addressName;
            addressName.value = pickedData.addressName;
          });
          if (addressname != null) {
            navigatorKey.currentState!.pop();
          }
        },
      ),
    );
  }
}
