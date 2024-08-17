import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/mobile/widgets/delete_modal.dart';
import 'package:shoppingyou/mobile/widgets/privacy_policy_page.dart';
import 'package:shoppingyou/mobile/widgets/toast.dart';
import 'package:shoppingyou/responsive/responsive_config.dart';
import 'package:shoppingyou/service/constant.dart';
import 'package:shoppingyou/service/controller.dart';
import '../../../service/state/ui_manager.dart';
import '../../widgets/custominput.dart';
import '../../widgets/custompassword.dart';
import '../../widgets/headline.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //final _formKey=GlobalKey<FormState>();

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xff5956E9),
        body: Padding(
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
            top: 0,
            // bottom: MediaQuery.of(context).viewInsets.bottom
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    const Image(
                        image: AssetImage('assets/images/EllipseMorado.png')),
                    ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: FractionalOffset.center,
                            colors: [Colors.black, Colors.transparent],
                          ).createShader(rect);
                        },
                        blendMode: BlendMode.dstIn,
                        child: const Image(
                            image: AssetImage('assets/images/EllipseRosa.png'),
                            fit: BoxFit.contain)),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Headline(title: 'Welcome back'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 50.0, bottom: 27.0),
                      child: const Image(
                        image: AssetImage('assets/images/EllipseMorado.png'),
                      ),
                    )
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: Responsive.isDesktop(context) ||
                          Responsive.isTablet(context)
                      ? MediaQuery.of(context).size.width * 0.5
                      : MediaQuery.of(context).size.width,
                  child: ListView(shrinkWrap: true, children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50, 20),
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(height: 20),
                            const Text(
                              'Login',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Raleway',
                                fontSize: 18.0,
                              ),
                            ),
                            const CustomInput(),
                            const CustomPassword(),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Modals.forgetPasswordModal(
                                          context, controller);
                                    },
                                    child: const Text('Forgot Password?',
                                        style: TextStyle(
                                            color: Color(0xff5956E9)))),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  bool check =
                                      await Controls.validateForm(context);
                                  if (check == false) {
                                    showToast2(
                                        context, 'Incorrect emal or password',
                                        isError: true);

                                    return;
                                  }
                                  // ignore: use_build_context_synchronously
                                  bool doThis =
                                      await Controls.authUserLogin(context);

                                  if (doThis) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushReplacementNamed(
                                        context, "/");
                                  } else {}
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 107, 105, 240),
                                    fixedSize: const Size(314.0, 75.0),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 22),
                                    textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                child: context.watch<UiProvider>().isLoading
                                    ? const CupertinoActivityIndicator(
                                        color: Colors.white,
                                        radius: 15,
                                      )
                                    : const Text('Log In')),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, "signUp");
                                },
                                child: const Text(
                                  'Create account',
                                  style: TextStyle(
                                      color: Color(0xff5956E9), fontSize: 17.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PrivacyPolicy()));
                                  // Navigator.pushReplacementNamed(
                                  //     context, "privacy");
                                },
                                child: const Text(
                                  'By Signing in you agree to our terms and conditions.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
