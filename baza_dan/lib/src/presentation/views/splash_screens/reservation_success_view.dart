import 'package:baza_dan/src/config/themes/colors.dart';
import 'package:baza_dan/src/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../main_view.dart';

class ReservationSuccessView extends StatefulWidget {
  final User user;
  const ReservationSuccessView({Key? key, required this.user}) : super(key: key);

  @override
  _ReservationSuccessViewState createState() => _ReservationSuccessViewState();
}

class _ReservationSuccessViewState extends State<ReservationSuccessView> {
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
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MainView(user: widget.user)));
                      },
                      icon: Icon(LineIcons.timesCircle,
                        size: 50,
                        color: mainOrange,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/4,
                  height: MediaQuery.of(context).size.width/4,
                  child: Image.asset('assets/welcome.gif',
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
                    child: Text('Rezerwacja została zapisana!'
                        '\n Zapraszamy wkrótce!',
                      textAlign: TextAlign.center,
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
