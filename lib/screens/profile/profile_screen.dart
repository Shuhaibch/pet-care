import 'package:flutter/material.dart';
import 'package:pet_care/config/config.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ProfileScreen(),
    );
  }

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: height * .5,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: const BorderRadius.all(
                Radius.elliptical(20, 20),
              ),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  width: double.infinity,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.settings),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: const CircleAvatar(
                    radius: 55,
                  ),
                ),
                kheight10,
                Column(
                  children: [
                    Text(
                      "UserName",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Text('Location',
                        style: Theme.of(context).textTheme.displaySmall)
                  ],
                ),
                //* Uplaod Button
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: width * .39,
                          height: height * .08,
                          decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: const BorderRadius.all(
                                  Radius.elliptical(20, 20))),
                          child: Center(
                            child: Text(
                              "Report",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
