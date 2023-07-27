import 'package:baza_dan/src/config/themes/colors.dart';
import 'package:baza_dan/src/domain/entities/user.dart';
import 'package:baza_dan/src/presentation/blocs/register_bloc/register_bloc.dart';
import 'package:baza_dan/src/presentation/blocs/register_bloc/register_event.dart';
import 'package:baza_dan/src/presentation/blocs/register_bloc/register_state.dart';
import 'package:baza_dan/src/presentation/views/splash_screens/register_success_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterSecondView extends StatefulWidget {
  final String email;
  final String password;
  const RegisterSecondView({Key? key, required this.password, required this.email}) : super(key: key);

  @override
  _RegisterSecondViewState createState() => _RegisterSecondViewState();
}

class _RegisterSecondViewState extends State<RegisterSecondView> {

  TextEditingController phoneController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  bool isChecked = false;
  late final String email;
  late final String password;

  @override
  void initState() {
    email = widget.email;
    password = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: buildBody(),
    );
  }

  Widget buildBody(){
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state){
        if(state is RegisterError){
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message!), backgroundColor: mainOrange, duration: Duration(milliseconds: 400),));
        }else if (state is RegisterDone){
          Navigator.of(context).pushAndRemoveUntil(_createAnimatedRegisterRouteLeft(state.user!), (route) => false);
        }
      },
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
                child: Text('To jeszcze nie wszystko! Uzupełnij dane, abyśmy wiedzieli, gdzie doręczyć zamówienie!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: mainOrange,
                    fontSize: 20,
                  ),
                ),
              ),
              buildRegistrationForm(),
              buildRegisterButton(),
              buildSpinner()
            ],
          ),
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
                        labelText: "Imię",
                        prefixIcon: const Icon(Icons.account_box_outlined, size: 24),
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
                      controller: nameController,
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
                        decoration: InputDecoration(
                          floatingLabelStyle: const TextStyle(
                            color: mainOrange,
                          ),
                          labelText: "Nazwisko",
                          prefixIcon: const Icon(Icons.account_box, size: 24),
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
                        controller: lastNameController,
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
                      decoration: InputDecoration(
                        floatingLabelStyle: const TextStyle(
                          color: mainOrange,
                        ),
                        labelText: "Ulica",
                        prefixIcon: const Icon(Icons.map, size: 24),
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
                      controller: streetController,
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
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 330,
                            child: TextFormField(
                              decoration: InputDecoration(
                                floatingLabelStyle: const TextStyle(
                                  color: mainOrange,
                                ),
                                labelText: "Nr. domu",
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
                              controller: homeController,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                              onFieldSubmitted: (String value){

                              },
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Container(
                            width: MediaQuery.of(context).size.width - 330,
                            child: TextFormField(
                              decoration: InputDecoration(
                                floatingLabelStyle: const TextStyle(
                                  color: mainOrange,
                                ),
                                labelText: "Nr. miesz.",
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
                              controller: apartmentController,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                              onFieldSubmitted: (String value){

                              },
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Container(
                            width: MediaQuery.of(context).size.width - 293,
                            child: TextFormField(
                              decoration: InputDecoration(
                                floatingLabelStyle: const TextStyle(
                                  color: mainOrange,
                                ),
                                labelText: "Kod",
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
                              controller: codeController,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                              onFieldSubmitted: (String value){

                              },
                            ),
                          ),
                        ],
                      )
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
                      decoration: InputDecoration(
                        floatingLabelStyle: const TextStyle(
                          color: mainOrange,
                        ),
                        labelText: "Miasto",
                        prefixIcon: const Icon(Icons.location_city, size: 24),
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
                      controller: cityController,
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
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
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
                        decoration: InputDecoration(
                          floatingLabelStyle: const TextStyle(
                            color: mainOrange,
                          ),
                          labelText: "Numer telefonu",
                          prefixIcon: const Icon(Icons.phone, size: 24),
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
                        controller: phoneController,
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
          ],
        ),
      ),
    );
  }

  Widget buildRegisterButton(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: RawMaterialButton(
        onPressed: (){
          if(apartmentController.text.isNotEmpty){
            Map<String, String> credentials = {
              'email': email,
              'password' : password,
              'name':nameController.text,
              'lastname' : lastNameController.text,
              'street' : streetController.text,
              'house_nr' : homeController.text,
              'apartment_nr': apartmentController.text,
              'postal_code': codeController.text,
              'city' : cityController.text,
              'phone_nr' : phoneController.text
            };
            print(credentials);
            BlocProvider.of<RegisterBloc>(context).add(Register(credentials));
          }else{
            Map<String, String> credentials = {
              'email': email,
              'password' : password,
              'name':nameController.text,
              'lastname' : lastNameController.text,
              'street' : streetController.text,
              'house_nr' : homeController.text,
              'postal_code': codeController.text,
              'city' : cityController.text,
              'phone_nr' : phoneController.text
            };
            print(credentials);
            BlocProvider.of<RegisterBloc>(context).add(Register(credentials));
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

  Widget buildSpinner(){
    return BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state){
          if(state is RegisterLoading){
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


  Future<dynamic> tempRegister(Map<String, String> user) async{
    String url = "https://s402639.labagh.pl/register_full.php";
    print(user);
    if(user.containsKey('apartment_nr')){
      final response = await http.post(Uri.parse(url), body:{
        "email" : user['email'],
        "password" : user['password'],
        "name": user['name'],
        "lastname": user['lastname'],
        "street" : user['street'] ,
        "house_nr" : user['house_nr'],
        "apartment_nr": user['apartment_nr'],
        "postal_code": user['postal_code'],
        "city": user['city'],
        "phone_nr":  user['phone_nr']
      });
      print(response.body);
      if(response.statusCode == 200){
        return jsonEncode(response.body);
      }else{
        return null;
      }
    }else{
      final response = await http.post(Uri.parse(url), body:{
        "email" : user['email'],
        "password" : user['password'],
        "name": user['name'],
        "lastname": user['lastname'],
        "street" : user['street'] ,
        "house_nr" : user['house_nr'],
        "postal_code": user['postal_code'],
        "city": user['city'],
        "phone_nr":  user['phone_nr']
      });
      if(response.statusCode == 200){
        return jsonEncode(response.body);
      }else{
        return null;
      }
    }
  }


  static Route<dynamic> _createAnimatedRegisterRouteLeft(User user) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => RegisterSuccessView(user: user),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1, 0);
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


}
