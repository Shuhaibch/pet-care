import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/config/width.dart';
import 'package:pet_care/screens/main_screen.dart';

import '../../widgets/cust_text_feild.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passWordCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            //* Image Container
            Expanded(
              flex: 2,
              child: Container(
                width: size.width * .60,
                height: size.height * .01,
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
              // child: Image.asset(
              //   'assets/images/auth-.png',
              //   height: size.height * .05,
              //   width: size.width * .55,
              // ),
            ),
            kheight30,

            //* Text feilds
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Form(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "New To Here! SignUp",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        CustTextFeild(
                          controller: nameCtrl,
                          cusIcon: Icons.person_2_outlined,
                          hintText: "User Name",
                        ),
                        CustTextFeild(
                          controller: nameCtrl,
                          cusIcon: Icons.mail_outline_outlined,
                          hintText: "Email",
                        ),
                        CustTextFeild(
                          controller: nameCtrl,
                          cusIcon: Icons.key,
                          hintText: "PassWord",
                          suffIcon: const Icon(
                            Icons.remove_red_eye_outlined,
                          ),
                        ),
                        CustTextFeild(
                          controller: nameCtrl,
                          cusIcon: Icons.key,
                          hintText: "Confirm PassWord",
                          suffIcon: const Icon(Icons.remove_red_eye_outlined),
                        ),

                        //* Submit Button
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: InkWell(
                                  onTap: () {
                                    navigatorKey.currentState!
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => MainScreen(),
                                    ));
                                  },
                                  child: Container(
                                    width: size.width * .9,
                                    height: size.height * .065,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[900],
                                      borderRadius: const BorderRadius.all(
                                        Radius.elliptical(20, 20),
                                      ),
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Sign Up",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Already have an account? ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        navigatorKey.currentState!
                                            .pushReplacement(MaterialPageRoute(
                                          builder: (context) => MainScreen(),
                                        ));
                                      },
                                      child: Text(
                                        "Log in",
                                        style: GoogleFonts.exo2(
                                          color: Colors.grey[100],
                                          fontSize: 16,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: size.width * .15,
                                height: size.height * .035,
                                decoration: const BoxDecoration(
                                  // color: Colors.amber,
                                  image: DecorationImage(
                                    // fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/images/google.png',
                                    ),
                                  ),
                                ),
                                alignment: Alignment.topCenter,
                              ),
                              Text(
                                "Sign Up With Google",
                                style: Theme.of(context).textTheme.displaySmall,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
