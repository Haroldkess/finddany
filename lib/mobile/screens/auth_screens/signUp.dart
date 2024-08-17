import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/mobile/widgets/privacy_policy_page.dart';
import 'package:shoppingyou/responsive/responsive_config.dart';
import 'package:shoppingyou/service/state/ui_manager.dart';
import '../../../service/controller.dart';
import '../../widgets/custominput.dart';
import '../../widgets/custompassword.dart';
import '../../widgets/headline.dart';
import '../../widgets/name.dart';
import '../../widgets/toast.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UiProvider stream = context.watch<UiProvider>();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xff5956E9),
        body: Padding(
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
            top: 0,
            //  bottom: MediaQuery.of(context).viewInsets.bottom
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
                FadeInDown(
                  animate: true,
                  duration: const Duration(milliseconds: 500),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Headline(title: 'Hello, Friend'),
                  ),
                ),
                FadeInLeft(
                  animate: true,
                  duration: const Duration(milliseconds: 1000),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(
                      'Lets get you started',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontFamily: 'Raleway',
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 50.0, bottom: 5.0),
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
                        padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50, 0),
                        child: Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              // const Text(
                              //   'SignUp',
                              //   style: TextStyle(
                              //     fontWeight: FontWeight.bold,
                              //     fontFamily: 'Raleway',
                              //     fontSize: 18.0,
                              //   ),
                              // ),
                              const CustomName(),
                              const CustomInput(),
                              const CustomPassword(),
                              const SizedBox(
                                height: 50,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    bool check =
                                        await Controls.validateForm2(context);
                                    if (check == false) {
                                      showToast2(context,
                                          'Please fill in the form properly. ',
                                          isError: true);
                                      print('incorrect');
                                      return;
                                    }
                                    print('auth user');
                                    bool doThis =
                                        // ignore: use_build_context_synchronously
                                        await Controls.authUserSignUp(context);

                                    if (doThis) {
                                      // ignore: use_build_context_synchronously
                                      Navigator.pushReplacementNamed(
                                          context, "/");
                                    } else {}
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff5956E9),
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
                                  child: stream.isLoading
                                      ? const CupertinoActivityIndicator(
                                          color: Colors.white,
                                          radius: 15,
                                        )
                                      : const Text('Create Account')),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, "auth");
                                  },
                                  child: const Text(
                                    'Already have an account',
                                    style: TextStyle(
                                        color: Color(0xff5956E9),
                                        fontSize: 17.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    // Navigator.pushReplacementNamed(
                                    //     context, "privacy");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PrivacyPolicy()));
                                  },
                                  child: const Text(
                                    'By Signing up you agree to our terms and conditions.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 50,
                    )
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
