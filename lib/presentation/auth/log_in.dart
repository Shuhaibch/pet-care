import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_care/app_view.dart';
import 'package:pet_care/application/bloc/auth_bloc/my_user_bloc/my_users_bloc.dart';
import 'package:pet_care/presentation/auth/sign_up.dart';
import 'package:pet_care/presentation/splash/splash_screen.dart';
import 'package:pet_care/presentation/user/screens/profile/profile_screen.dart';
import 'package:user_repository/user_repository.dart';
import '../../application/bloc/auth_bloc/authentication/authentication_bloc.dart';
import '../../application/bloc/auth_bloc/sign_in/sign_in_bloc.dart';
import '../../application/bloc/auth_bloc/sign_up/sign_up_bloc.dart';
import '../../config/config.dart';
import '../user/widgets/cust_text_feild.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailCtrl = TextEditingController();

  final TextEditingController passWordCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  IconData passWordIcon = Icons.remove_red_eye_outlined;

  String? errorMsg;

  bool isVisible = true;

  bool signInRequired = false;
  @override
  void initState() {
    super.initState();
    myUser = MyUser.empty;
    user = FirebaseAuth.instance.currentUser;
  }

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
        child: BlocListener<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is SignInLoading) {
              setState(() {
                signInRequired = true;
              });
            } else if (state is SignInSuccess) {
              setState(() {
                signInRequired = false;
              });
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => MyUsersBloc(
                    userRepository:
                        context.read<AuthenticationBloc>().userRepository,
                  )..add(
                      GetMyUsers(
                        myUsersId:
                            context.read<AuthenticationBloc>().state.user!.uid,
                      ),
                    ),
                  child: SplashScreen(),
                ),
              ));
            } else if (state is SignInfailed) {
              setState(() {
                signInRequired = false;
                errorMsg = 'invalid Password or email';
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMsg!)));
            }
          },
          child: Column(
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
                              "Welcome Back! Login",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),

                          CustTextFeild(
                            controller: emailCtrl,
                            prefixIcon: const Icon(Icons.mail_outline_outlined),
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
                            obscureText: isVisible,
                            controller: passWordCtrl,
                            prefixIcon: const Icon(Icons.key),
                            hintText: "PassWord",
                            sufixIcon: IconButton(
                              icon: Icon(passWordIcon),
                              onPressed: () {
                                setState(
                                  () {
                                    isVisible = !isVisible;
                                    if (isVisible) {
                                      passWordIcon = Icons.visibility;
                                    } else {
                                      passWordIcon =
                                          Icons.visibility_off_outlined;
                                    }
                                  },
                                );
                              },
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please Fill the Feild';
                              } else if (!passRexExp.hasMatch(val)) {
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
                                          context.read<SignInBloc>().add(
                                              SignInRequired(
                                                  email: emailCtrl.text,
                                                  password: passWordCtrl.text));
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
                                      child: Center(
                                        child: !signInRequired
                                            ? Text(
                                                "Log in",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              )
                                            : const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                color: Colors.white,
                                              )),
                                      ),
                                    ),
                                  ),
                                ),

                                //* SignUp Button
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "New around here? ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                              create: (context) => SignUpBloc(
                                                  userRepository: context
                                                      .read<
                                                          AuthenticationBloc>()
                                                      .userRepository),
                                              child: const SignUpScreen(),
                                            ),
                                          ));
                                        },
                                        child: Text(
                                          "Sign up",
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
                            padding: const EdgeInsets.symmetric(vertical: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
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
                                Text(
                                  "Log in With Google",
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
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
      ),
    );
  }
}
