import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return (Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
               Padding(
                padding: const  EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: Center(
                  child: Semantics(
                    child: const  Text('Shopping made easy with Finddany',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                  child: ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.center,
                          end: FractionalOffset.bottomCenter,
                          colors: [Colors.black, Colors.transparent],
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstIn,
                      child: const Image(
                          image: AssetImage('assets/images/splash.png'),
                          fit: BoxFit.contain))),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: const Color(0xff5956E9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 80,
                    vertical: 22,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "auth");
                },
                child: const Text('Get Started'),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
