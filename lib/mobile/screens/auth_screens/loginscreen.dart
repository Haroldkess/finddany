import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingyou/mobile/widgets/delete_modal.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xff5956E9),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(left: 8,right: 8,top: 8,bottom: MediaQuery.of(context).viewInsets.bottom),
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
              Form(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: Responsive.isDesktop(context) ||
                          Responsive.isTablet(context)
                      ? MediaQuery.of(context).size.width * 0.5
                      : MediaQuery.of(context).size.width,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(50.0, 36.0, 50, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
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
                          TextButton(
                              onPressed: () {
                                Modals.forgetPasswordModal(context, controller);
                              },
                              child: const Text('Forgot Password?',
                                  style: TextStyle(color: Color(0xff5956E9)))),
                          ElevatedButton(
                              onPressed: () async {
                                bool check = await Controls.validateForm(context);
                                if (check == false) {
                                  
                                              
                                     showToast2(context,  'Incorrect emal or password', isError: true);
                                  
                                  return;
                                }
                                // ignore: use_build_context_synchronously
                                bool doThis = await Controls.authUserLogin(context);

                                if (doThis) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushReplacementNamed(context, "/");
                                } else {}
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff5956E9),
                                  fixedSize: const Size(314.0, 70.0),
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 22),
                                  textStyle: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w700)),
                              child: context.watch<UiProvider>().isLoading
                                  ? const CupertinoActivityIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text('Log In')),
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, "signUp");
                              },
                              child: const Text(
                                'Create account',
                                style: TextStyle(
                                    color: Color(0xff5956E9), fontSize: 17.0),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
