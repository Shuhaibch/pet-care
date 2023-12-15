import 'package:flutter/material.dart';

import '../../widgets/cust_text_feild.dart';
import '../main_screen.dart';

class LoginBottomSheet extends StatelessWidget {
  LoginBottomSheet({
    super.key,
    required this.size,
  });

  final Size size;
  final TextEditingController nameCtrll = TextEditingController();
  final TextEditingController passWordCtrll = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: size.height * 8,
      color: Colors.grey[900],

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Welcome Back! Login",
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            CustTextFeild(
              controller: nameCtrll,
              cusIcon: Icons.person_2_outlined,
              hintText: "User Name",
            ),
            CustTextFeild(
              controller: passWordCtrll,
              cusIcon: Icons.key,
              hintText: "PassWord",
              suffIcon: const Icon(
                Icons.remove_red_eye_outlined,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
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
                        "Login",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ),
                ),
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
                    "Log In With Google",
                    style: Theme.of(context).textTheme.displaySmall,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
