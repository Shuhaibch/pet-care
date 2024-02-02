import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/app_view.dart';
import 'package:pet_care/config/string.dart';
import 'package:pet_care/config/width.dart';
import 'package:pet_care/presentation/auth/log_in.dart';
import '../../application/bloc/auth_bloc/authentication/authentication_bloc.dart';
import '../../application/bloc/auth_bloc/sign_up/sign_up_bloc.dart';
import '../user/widgets/cust_text_feild.dart';
import '../user/screens/main_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameCtrl = TextEditingController();

  final TextEditingController emailCtrl = TextEditingController();

  final TextEditingController passWordCtrl = TextEditingController();

  final TextEditingController confirmPassWordCtrl = TextEditingController();

  final TextEditingController addressCtrl = TextEditingController();

  final TextEditingController phoneCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  IconData passWordIcon = Icons.remove_red_eye_outlined;

  String? errorMsg;

  bool isVisible = true;

  bool signInRequired = false;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      // bottomSheet: Column(
      //   children: [Text('data')],
      // ),

      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpLoading) {
              setState(() {
                signInRequired = true;
              });
            } else if (state is SignUpSuccess) {
              setState(() {
                signInRequired = false;
              });
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => MainScreen(),
              ));
            } else if (state is SignUpError) {
              setState(() {
                signInRequired = false;
                errorMsg = 'invalid Password or email';
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMsg!)));
            }
          },
          builder: (context, state) {
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
                  // child: Image.asset(
                  //   'assets/images/auth-.png',
                  //   height: height * .05,
                  //   width: width * .55,
                  // ),
                ),
                kheight30,

                //* Text feilds
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                "New To Here! SignUp",
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                            CustTextFeild(
                              errorMsg: errorMsg,
                              controller: nameCtrl,
                              prefixIcon: const Icon(
                                Icons.person_2_outlined,
                              ),
                              hintText: "User Name",
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Please Fill the Feild';
                                } else if (!nameRegExp.hasMatch(val)) {
                                  return 'Please Enter a Valid name';
                                }
                                return null;
                              },
                            ),
                            CustTextFeild(
                              errorMsg: errorMsg,
                              controller: emailCtrl,
                              prefixIcon: const Icon(
                                Icons.mail_outline_outlined,
                              ),
                              hintText: "Email",
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please Fill the Feild';
                                } else if (!emailRexExp.hasMatch(val)) {
                                  return 'Please Enter a Valid Email';
                                }
                                return null;
                              },
                            ),
                            CustTextFeild(
                              controller: passWordCtrl,
                              obscureText: isVisible,
                              prefixIcon: const Icon(Icons.key),
                              errorMsg: errorMsg,
                              hintText: "PassWord",
                              sufixIcon: IconButton(
                                icon: Icon(
                                  passWordIcon,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                    if (isVisible) {
                                      passWordIcon = Icons.visibility;
                                    } else {
                                      passWordIcon =
                                          Icons.visibility_off_outlined;
                                    }
                                  });
                                },
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please Fill the Feild';
                                } else if (!passRexExp.hasMatch(val)) {
                                  return 'Please Enter a Valid passWord';
                                }
                                return null;
                              },
                            ),
                            CustTextFeild(
                              controller: confirmPassWordCtrl,
                              obscureText: isVisible,
                              prefixIcon: const Icon(Icons.key),
                              hintText: "Confirm PassWord",
                              errorMsg: errorMsg,
                              sufixIcon: IconButton(
                                icon: Icon(
                                  passWordIcon,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                    if (isVisible) {
                                      passWordIcon = Icons.visibility;
                                    } else {
                                      passWordIcon =
                                          Icons.visibility_off_outlined;
                                    }
                                  });
                                },
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Please Fill the Feild';
                                } else if (val!=passWordCtrl.text) {
                                  return 'Please Enter a Valid Password';
                                }
                                return null;
                              },
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
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            context.read<SignUpBloc>().add(
                                                SignUpRequired(
                                                    userName: nameCtrl.text,
                                                    passWord: passWordCtrl.text,
                                                    email: emailCtrl.text,
                                                    role: "User"));
                                          });
                                        }
                                      },
                                      child: Container(
                                        width: width * .9,
                                        height: height * .065,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[900],
                                          borderRadius: const BorderRadius.all(
                                            Radius.elliptical(20, 20),
                                          ),
                                          border: Border.all(
                                            color: Colors.white,
                                          ),
                                        ),
                                        child: !signInRequired
                                            ? Center(
                                                child: Text(
                                                  "Sign Up",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                ),
                                              )
                                            : const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                color: Colors.white,
                                              )),
                                      ),
                                    ),
                                  ),

                                  //* Login Button
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
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        BlocProvider.value(
                                                          value: BlocProvider
                                                              .of<AuthenticationBloc>(
                                                                  context),
                                                          child:
                                                              const LoginScreen(),
                                                        )));
                                          },
                                          child: Text(
                                            "Log in",
                                            style: GoogleFonts.exo2(
                                              fontSize: 16,
                                              color: Colors.grey[100],
                                              decoration:
                                                  TextDecoration.underline,
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 25.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                    //  context.read<SignUpBloc>().add(
                                    //            SignInWithGoogle());
                                    },
                                    child: Container(
                                      width: width * .15,
                                      height: height * .035,
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
                                  ),
                                  Text(
                                    "Sign Up With Google",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
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
            );
          },
        ),
      ),
    );
  }
}
