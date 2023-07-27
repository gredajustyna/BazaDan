import 'package:baza_dan/src/config/themes/colors.dart';
import 'package:baza_dan/src/domain/entities/user.dart';
import 'package:flutter/material.dart';

import '../main_view.dart';

class RegisterSuccessView extends StatefulWidget {
  final User user;
  const RegisterSuccessView({Key? key, required this.user}) : super(key: key);

  @override
  _RegisterSuccessViewState createState() => _RegisterSuccessViewState();
}

class _RegisterSuccessViewState extends State<RegisterSuccessView> {
  late User user;

  @override
  void initState() {
    user = widget.user;
    Future.delayed( const Duration(seconds: 4), () =>
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MainView(user: user)))
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
                Image.asset('assets/cookingloader.gif'),
                const Padding(
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Text('Przygotowujemy twoje menu...',
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
