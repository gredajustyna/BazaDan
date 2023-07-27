import 'package:baza_dan/src/config/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();
    Future.delayed( const Duration(seconds: 4), () =>
      Navigator.pushReplacementNamed( context,
        '/login'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 240, 0, 0),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2,
            child: Column(
              children: [
                Image.asset('assets/pizza_cropped.gif'),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Text('Pyszne jedzenie już nadchodzi...',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: mainOrange,
                      fontSize: 18,
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
