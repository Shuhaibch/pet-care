import 'package:flutter/material.dart';

import '../../app_view.dart';
import '../../config/config.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //* Image Container
        Expanded(
          flex: 2,
          child: Container(
            width: width * .60,
            height: height * .01,
            decoration: const BoxDecoration(
              // color: Colors.amber,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/auth-.png',
                ),
              ),
            ),
            alignment: Alignment.topCenter,
          ),
        ),
        kheight30,
       
      ],
    );
  }
}
