import 'package:baza_dan/src/config/themes/colors.dart';
import 'package:baza_dan/src/data/repositories/food_repository_impl.dart';
import 'package:baza_dan/src/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:baza_dan/src/presentation/blocs/login_bloc/login_event.dart';
import 'package:baza_dan/src/presentation/blocs/login_bloc/login_state.dart';
import 'package:baza_dan/src/presentation/views/main_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordObscured = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: buildBody(),
    );
  }


  Widget buildBody(){
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state){
        if(state is LoginDone){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MainView(user: state.user!)));
        }else if(state is LoginError){
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Błędne dane logowania!'), backgroundColor: mainRed, duration: Duration(milliseconds: 400),));
        }
      },
      child: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
              child: Text('Zaloguj się, aby skorzystać z przepysznych promocji!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: mainOrange,
                  fontSize: 20,
                ),
              ),
            ),
            buildRegistrationForm(),
            buildRegistrationText(),
            buildLoginButton(),
            buildSpinner(),
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
        'Logowanie',
        style: TextStyle(
          color: mainWhite,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildRegistrationForm(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
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
            )
          ],
        ),
      ),
    );
  }

  Widget buildLoginButton(){
    return RawMaterialButton(
      onPressed: (){
        Map<String, String> credentials = {'email': loginController.text, 'password' : passwordController.text };
        BlocProvider.of<LoginBloc>(context).add(LogIn(credentials));
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)),
      child: Text('Zaloguj'),
      textStyle: const TextStyle(
        color: Colors.white,
        fontFamily: 'Montserrat',
        fontSize: 17,
      ),
      elevation: 0,
      fillColor: mainOrange,
    );
  }

  Widget buildRegistrationText(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Nie masz konta?',
          style: TextStyle(
            color: mainGrey,
            fontSize: 15,
          ),
        ),
        TextButton(
          onPressed: (){
            Navigator.pushReplacementNamed( context, '/register');
            //getOrderDetails("33");
            //tempRandom();
            //getTables("2022-01-10 15:00:00");
            //createReservation();
            //tempGetResv();
          },
          child: const Text(
            'Zarejestruj się!',
            style: TextStyle(
              color: mainOrange,
              fontSize: 15,
              decoration: TextDecoration.underline
            ),
          ),

        ),
      ],
    );
  }

  Widget buildSpinner(){
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state){
          if(state is LoginLoading){
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

  Future<dynamic> templogIn(String email, String password) async{
    String url = "https://s402639.labagh.pl/login.php";
    final response = await http.post(Uri.parse(url), body:{
      "email" : email,
      "password" : password
    });
    if(response.statusCode == 200){
      print(json.decode(response.body));
    }
  }

  Future<void> tempConnect()async {
    String url = "https://s402639.labagh.pl";
    final response = await http.get(Uri.parse(url));
    print(response.body);
  }

  Future getFoodList(String category) async{
    String url = "https://s402639.labagh.pl/get_food.php";
    final response = await http.post(Uri.parse(url), body:{
      "category" : category
    });
    if(response.statusCode == 200){
      var foodMap = json.decode(response.body);
      int len = foodMap.length;
      print(len);
      for(int i=0; i<len; i++){
        //print(foodMap[i][0]);
        Map<String, dynamic> data1 = new Map<String, dynamic>.from(json.decode(response.body)[i][0]);
        //Map<String, dynamic> data = new Map<String, dynamic>.from(jsonDecode(foodMap[i][0]));
        print(data1);
        print(data1['name']);
      }
      return jsonEncode(response.body);
    }else{
      return null;
    }
  }

  Future tempOrder() async{
    String url = "https://s402639.labagh.pl/create_order.php";
    final response = await http.post(Uri.parse(url), body:{
      "user_id" : "22",
      "nr_of_products" : '2',
      "food_id_1" : '15',
      "food_amount_1" : '2',
      "food_id_2" : '2',
      "food_amount_2" : '3',
      "comments" : 'daj mi jeść'
    });
    if(response.statusCode == 200){
      print(response.body);
      return jsonEncode(response.body);
    }else{
      return null;
    }
  }

  Future tempRandom() async{
    String url = "https://s402639.labagh.pl/get_random_food.php";
    final response = await http.post(Uri.parse(url), body:{
    });
    if(response.statusCode == 200){
      var foodMap = json.decode(response.body);
      List<Map<String, dynamic>> foodList = [];
      print(foodMap);
      int len = foodMap.length;
      print(len);
      for(int i=0; i<len; i++){
        Map<String, dynamic> data1 = new Map<String, dynamic>.from(json.decode(response.body)[i]);
        //Map<String, dynamic> data = new Map<String, dynamic>.from(jsonDecode(foodMap[i][0]));
        data1.addAll({
          'food_img': 'kotek',
        });
        print(data1);
        print(data1['name']);
        foodList.add(data1);
      }
      print(foodList);
      return jsonEncode(response.body);
    }else{
      return null;
    }
  }

  Future tempGetOrder() async{
    String url = "https://s402639.labagh.pl/get_orders.php";
    final response = await http.post(Uri.parse(url), body:{
      "user_id" : "22",
    });
    if(response.statusCode == 200){
      print(json.decode(response.body)[0]);
      return jsonEncode(response.body);
    }else{
      return null;
    }
  }

  Future getOrderDetails(String orderId) async{
    String url = "https://s402639.labagh.pl/get_orders_details.php";
    final response = await http.post(Uri.parse(url), body:{
      "order_id" : "37",
    });
    if(response.statusCode == 200){
      print(json.decode(response.body));
      return response.body;
    }else{
      return null;
    }
  }


  Future getTables(String date) async{
    String url = "https://s402639.labagh.pl/get_table_status.php";
    final response = await http.post(Uri.parse(url), body:{
      "datetime" : "2022-01-10 15:00:00",
    });
    if(response.statusCode == 200){
      print(json.decode(response.body));
      Map<String, dynamic> data1 = Map<String, dynamic>.from(json.decode(response.body));
      print(data1['12']);
      return response.body;
    }else{
      print(response.statusCode);
      return null;
    }
  }


  Future createReservation() async{
    String url = "https://s402639.labagh.pl/create_reservation.php";
    final response = await http.post(Uri.parse(url), body:{
      "user_id" : "22",
      "wanted_time" : "2022-01-10 15:00:00",
      "table_id" : "12"
    });
    if(response.statusCode == 200){
      print(json.decode(response.body));
      return response.body;
    }else{
      print(response.statusCode);
      return null;
    }
  }

  Future tempGetResv() async{
    String url = "https://s402639.labagh.pl/get_reservations.php";
    final response = await http.post(Uri.parse(url), body:{
      "user_id" : "22",
    });
    print(response.statusCode);
    if(response.statusCode == 200){
      print(response.body);
      print(json.decode(response.body)[0]);
      return jsonEncode(response.body);
    }else{
      return null;
    }
  }


}
