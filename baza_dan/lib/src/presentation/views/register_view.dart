import 'dart:convert';

import 'package:baza_dan/src/config/themes/colors.dart';
import 'package:baza_dan/src/presentation/blocs/check_email_bloc/check_email_bloc.dart';
import 'package:baza_dan/src/presentation/blocs/check_email_bloc/check_email_event.dart';
import 'package:baza_dan/src/presentation/blocs/check_email_bloc/check_email_state.dart';
import 'package:baza_dan/src/presentation/views/register_second_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;
  bool isChecked = false;
  String warningMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: buildBody(),
    );
  }

  Widget buildBody(){
    return BlocListener<CheckEmailBloc, CheckEmailState>(
      listener: (context, state){
        if(state is CheckEmailDone){
          Navigator.of(context).push(_createAnimatedRegisterRouteRight(passwordController.text, loginController.text));
        }else if(state is CheckEmailError){
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message!), backgroundColor: mainRed, duration: Duration(milliseconds: 400),));
        }
      },
      child: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
              child: Text('Wyśmienite smaki są o kilka kliknięć od ciebie!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: mainOrange,
                  fontSize: 20,
                ),
              ),
            ),
            buildRegistrationForm(),
            buildRulesRow(),
            buildRegisterButton(),
            buildSpinner()
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppbar(){
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: mainOrange,
      title: const Text(
        'Rejestracja',
        style: TextStyle(
          color: mainWhite,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildRegistrationForm(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 25, 0, 20),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 110,
                  child: Theme(
                    data: ThemeData(
                      colorScheme: ThemeData().colorScheme.copyWith(
                        primary: mainOrange,
                      ),
                      fontFamily: 'Montserrat',
                    ),
                    child: TextFormField(
                      //EDIT TEXT CONTROLLER
                      decoration: InputDecoration(
                        floatingLabelStyle: const TextStyle(
                          color: mainOrange,
                        ),
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.alternate_email_outlined, size: 24),
                        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: mainGrey,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: mainOrange,
                            width: 2.0,
                          ),
                        ),
                      ),
                      controller: loginController,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      onFieldSubmitted: (String value){

                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 110,
                    child: Theme(
                      data: ThemeData(
                        colorScheme: ThemeData().colorScheme.copyWith(
                          primary: mainOrange,
                        ),
                        fontFamily: 'Montserrat',
                      ),
                      child: TextFormField(
                        obscureText: isPasswordObscured,
                        decoration: InputDecoration(
                          floatingLabelStyle: const TextStyle(
                            color: mainOrange,
                          ),
                          labelText: "Hasło",
                          suffixIcon: IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: (){
                              setState(() {
                                isPasswordObscured = !isPasswordObscured;
                              });
                            },
                            icon: Icon(isPasswordObscured ? Icons.remove_red_eye_outlined : Icons.remove_red_eye_rounded,
                              size: 24,
                            ),
                          ),
                          prefixIcon: const Icon(Icons.lock, size: 24),
                          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: mainGrey,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              color: mainOrange,
                              width: 2.0,
                            ),
                          ),
                        ),
                        controller: passwordController,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                        onFieldSubmitted: (String value){

                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 110,
                  child: Theme(
                    data: ThemeData(
                      colorScheme: ThemeData().colorScheme.copyWith(
                        primary: mainOrange,
                      ),
                      fontFamily: 'Montserrat',
                    ),
                    child: TextFormField(
                      obscureText: isConfirmPasswordObscured,
                      decoration: InputDecoration(
                        floatingLabelStyle: const TextStyle(
                          color: mainOrange,
                        ),
                        labelText: "Potwierdź hasło",
                        suffixIcon: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: (){
                            setState(() {
                              isConfirmPasswordObscured = !isConfirmPasswordObscured;
                            });
                          },
                          icon: Icon(isConfirmPasswordObscured ? Icons.remove_red_eye_outlined : Icons.remove_red_eye_rounded,
                            size: 24,
                          ),
                        ),
                        prefixIcon: const Icon(Icons.lock_outlined, size: 24),
                        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: mainGrey,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: mainOrange,
                            width: 2.0,
                          ),
                        ),
                      ),
                      controller: confirmPasswordController,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      onFieldSubmitted: (String value){

                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildSpinner(){
    return BlocBuilder<CheckEmailBloc, CheckEmailState>(
      builder: (context, state){
        if(state is CheckEmailInProgress){
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: const SpinKitCircle(
              color: mainOrange,
              size: 20,
            ),
          );
        }else{
          return const SizedBox(width: 1,);
        }
    });
  }

  Widget buildRegisterButton(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: RawMaterialButton(
        onPressed: (){
          if(passwordController.text.isNotEmpty && loginController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty){
            if(passwordController.text == confirmPasswordController.text){
              if(isChecked){
                //templogIn(loginController.text);
                BlocProvider.of<CheckEmailBloc>(context).add(CheckEmail(loginController.text));
              }else{
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Zaakceptuj warunki korzystania z serwisu!'), backgroundColor: mainRed, duration: Duration(milliseconds: 400),));
              }
            }else{
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Hasła nie zgadzają się!'), backgroundColor: mainRed, duration: Duration(milliseconds: 400),));
            }
          }else{
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Uzupełnij dane!'), backgroundColor: mainRed, duration: Duration(milliseconds: 400),));
          }
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Zarejestruj się'),
        ),
        textStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Montserrat',
          fontSize: 17,
        ),
        elevation: 0,
        fillColor: mainOrange,
      ),
    );
  }

  Widget buildRulesRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          checkColor: mainWhite,
          fillColor: MaterialStateProperty.all(mainOrange),
          focusColor: mainOrange,
          activeColor: mainOrange,
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        Flexible(
          child: RichText(
            textAlign: TextAlign.center,
            maxLines: 3,
            softWrap: false,
            overflow: TextOverflow.fade,
            text: TextSpan(
              children:[
                const TextSpan(
                  text: 'Zapoznałem się z ',
                  style: TextStyle(
                    color: mainOrange,
                    fontFamily: 'Montserrat',
                  )
                ),
                TextSpan(
                  text: 'warunkami\n korzystania z serwisu',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _launchURL();
                    },
                  style: const TextStyle(
                    color: mainOrange,
                    decoration: TextDecoration.underline,
                    fontFamily: 'Montserrat',
                  )
                ),
                const TextSpan(
                    text: ' i akceptuję je.',
                    style: TextStyle(
                      color: mainOrange,
                      fontFamily: 'Montserrat',
                    )
                ),
              ]
            )
          ),
        ),
      ],
    );
  }


  _launchURL() async {
    const url = 'https://shorturl.at/buLS1';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Route<dynamic> _createAnimatedRegisterRouteRight(String password, String email) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => RegisterSecondView(password: password, email: email),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0);
        const end = Offset(0, 0);
        const curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  Future<dynamic> templogIn(String email) async{
    String url = "https://s402639.labagh.pl/register_init.php";
    final response = await http.post(Uri.parse(url), body:{
      "email" : email,
    });
    if(response.statusCode == 200){
      print(json.decode(response.body));
    }else{
      print(response.body);
      print(response.statusCode);
    }
  }

}
