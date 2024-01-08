import 'package:flutter/material.dart';
import 'screens/screen.dart';
import 'package:pet_care/presentation/admin/widgets/ad_custom_nav_bar.dart';

class ADMainScreen extends StatelessWidget {
   ADMainScreen({super.key});
 
  

  final _pages = [
    const ADHomeScreen(),
    const ADReportScreen(),
    const ADPostScreen(),
    const ADProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: adIndexChangeNotifier,
        builder: (context, index, _) {
          return _pages[index];
        },
      )),
      bottomNavigationBar: const ADCustomNavBar(),
    );
  }
}
