import 'dart:developer';

import 'package:flutter/material.dart';

ValueNotifier<int> adIndexChangeNotifier = ValueNotifier(0);

class ADCustomNavBar extends StatelessWidget {
  const ADCustomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      // color: Colors.amber,
      height: 70,
      child: ValueListenableBuilder(
        valueListenable: adIndexChangeNotifier,
        builder: (context, value, _) {
          return BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: value,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            selectedIconTheme: const IconThemeData(
              color: Colors.white,
            ),
            unselectedIconTheme: const IconThemeData(
              color: Colors.white60,
            ),
            onTap: (index) {
              adIndexChangeNotifier.value = index;
              log(value.toString());
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.supervised_user_circle_rounded,
                  // color: Colors.white,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.report,
                  // color: Colors.white,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.image,
                  // color: Colors.white,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  // color: Colors.white,
                ),
                label: '',
              ),
            ],
          );
        },
      ),
    );
  }
}
