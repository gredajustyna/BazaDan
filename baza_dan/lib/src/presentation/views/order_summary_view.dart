import 'package:baza_dan/src/config/themes/colors.dart';
import 'package:baza_dan/src/domain/entities/user.dart';
import 'package:baza_dan/src/presentation/blocs/order_bloc/order_bloc.dart';
import 'package:baza_dan/src/presentation/blocs/order_bloc/order_event.dart';
import 'package:baza_dan/src/presentation/blocs/order_bloc/order_state.dart';
import 'package:baza_dan/src/presentation/views/splash_screens/order_success_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:baza_dan/src/data/my_globals.dart' as globals;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loader_overlay/loader_overlay.dart';


class OrderSummaryView extends StatefulWidget {
  final User user;
  const OrderSummaryView({Key? key, required this.user}) : super(key: key);

  @override
  _OrderSummaryViewState createState() => _OrderSummaryViewState();
}

class _OrderSummaryViewState extends State<OrderSummaryView> {
  TextEditingController cardController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  List<String> bankList = ["Wybierz bank", "ING", 'Pekao', 'BGŻ', 'Alior Bank'];
  String selectedBank = "Wybierz bank";
  late User user;
  late double sum;
  bool _value = false;
  int val = -1;

  @override
  void initState() {
    user = widget.user;
    sum = countSum();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(),
      body: buildBody(),
      bottomNavigationBar: buildBottomContainer(),
    );
  }


  PreferredSizeWidget buildAppbar(){
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: mainOrange,
      title: const Text(
        'Podsumowanie',
        style: TextStyle(
          color: mainWhite,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildBody(){
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state){
        if(state is OrderError){
          if(context.loaderOverlay.visible){
            context.loaderOverlay.hide();
          }
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Ups! coś poszło nie tak!'), backgroundColor: mainRed, duration: Duration(milliseconds: 400),));
        }else if(state is OrderDone){
          if(context.loaderOverlay.visible){
            context.loaderOverlay.hide();
          }
          globals.cart = [];
          globals.cartAmounts = [];
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => OrderSuccessView(user: user)), (route) => false);
        }else if(state is OrderLoading){
          context.loaderOverlay.show();
        }
      },
      child: LoaderOverlay(
        overlayOpacity: 0.8,
        overlayColor: lightOrange,
        useDefaultLoading: false,
        overlayWidget: const Center(
          child: SpinKitCircle(
            color: mainOrange,
            size: 50.0,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Szczegóły zamówienia:",
                    style: TextStyle(
                      color: mainOrange,
                      fontSize: 20
                    ),
                  ),
                ),
                buildOrderDetails(),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Adres wysyłki:",
                    style: TextStyle(
                        color: mainOrange,
                        fontSize: 20
                    ),
                  ),
                ),
                buildAddressDetails(),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Metody płatności:",
                    style: TextStyle(
                        color: mainOrange,
                        fontSize: 20
                    ),
                  ),
                ),
                buildPaymentDetails(),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Uwagi do zamówienia:",
                    style: TextStyle(
                        color: mainOrange,
                        fontSize: 20
                    ),
                  ),
                ),
                buildComments(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOrderDetails(){
    return Card(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: globals.cart.length,
              itemBuilder: (context, index){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      globals.cartAmounts[index].toString()+' x '+globals.cart[index].name.toString(),
                      style: TextStyle(
                        color: mainGrey
                      ),
                    ),
                    Text(
                      (globals.cartAmounts[index]*globals.cart[index].price).toStringAsFixed(2),
                      style: TextStyle(
                          color: mainGrey
                      ),
                    ),
                  ],
                );
              }
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Suma:",
                  style: TextStyle(
                    color: mainOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                ),
                Text(
                  sum.toStringAsFixed(2),
                  style: TextStyle(
                      color: mainOrange,
                      fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildAddressDetails(){
    return Card(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            Row(
              children: [
                Icon(LineIcons.userAlt,
                  color: mainGrey,
                ),
                Text(
                  user.name+' '+user.lastname,
                  style: TextStyle(
                      color: mainGrey
                  ),
                )
              ],
            ),
            Row(
              children: [
                Icon(LineIcons.map,
                  color: mainGrey,
                ),
                Text(
                  user.street+' ',
                  style: TextStyle(
                      color: mainGrey
                  ),
                ),
                Icon(LineIcons.home,
                  color: mainGrey,
                ),
                Text(
                  user.houseNr + "/" + (user.apartmentNr ?? "") ,
                  style: TextStyle(
                      color: mainGrey
                  ),
                )
              ],
            ),
            Row(
              children: [
                Icon(LineIcons.mapMarker,
                  color: mainGrey,
                ),
                Text(
                  user.postalCode +', '+ user.city,
                  style: TextStyle(
                      color: mainGrey
                  ),
                )
              ],
            ),
            Row(
              children: [
                Icon(LineIcons.phone,
                  color: mainGrey,
                ),
                Text(
                  user.phoneNumber.substring(0,3)+'-'+user.phoneNumber.substring(3,6)+'-'+user.phoneNumber.substring(6,9),
                  style: TextStyle(
                      color: mainGrey
                  ),
                )
              ],
            ),
            Row(
              children: [
                Icon(LineIcons.at,
                  color: mainGrey,
                ),
                Text(
                  user.email,
                  style: TextStyle(
                      color: mainGrey
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentDetails(){
    return Card(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            RadioListTile(
              selectedTileColor: mainOrange,
              value: 1,
              groupValue: val,
              onChanged: (value) {
                setState(() {
                  val = value as int;
                });
              },
              title: Text("Karta płatnicza"),
              secondary: Icon(LineIcons.creditCard),
              controlAffinity: ListTileControlAffinity.trailing,
            ),
            RadioListTile(
              selectedTileColor: mainOrange,
              value: 2,
              groupValue: val,
              onChanged: (value) {
                setState(() {
                  val = value as int;
                });
              },
              title: Text("Przelew"),
              secondary: Icon(LineIcons.alternateExchange),
              controlAffinity: ListTileControlAffinity.trailing,
            ),
            val == 1 ?
            Column(
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
                            labelText: "Numer karty",
                            prefixIcon: const Icon(LineIcons.creditCard, size: 24),
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
                          controller: cardController,
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
                                  width: MediaQuery.of(context).size.width - 300,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      floatingLabelStyle: const TextStyle(
                                        color: mainOrange,
                                      ),
                                      labelText: "MM/YYYY",
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
                                    controller: dateController,
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
                                      labelText: "CVV",
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
                                    controller: cvvController,
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
                )
              ],
            )
                : val == 2 ?
            DropdownButton<String>(
              hint:  Text("Wybierz bank",
                style: TextStyle(
                  color: mainGrey
                ),
              ),
              value: selectedBank,
              onChanged: (String? value) {
                setState(() {
                  selectedBank = value!;
                });
              },
              items: bankList.map((String bank) {
                return  DropdownMenuItem<String>(
                  value: bank,
                  child: Text(
                    bank,
                    style:  TextStyle(
                      color: mainGrey
                    ),
                  ),
                );
              }).toList(),
            )
          :
            Center()
          ],
        ),
      ),
    );
  }

  Widget buildBottomContainer(){
    return BottomAppBar(
      child: Container(
        height: 60.0,
        width: double.maxFinite,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: mainGrey, width: 1.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildBuyButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildComments(){
    return Card(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Chcesz nam coś przekazać? To idealny moment!",
                style: TextStyle(
                  color: mainGrey
                ),
              ),
            ),
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
                    labelText: "Dodaj uwagi do zamówienia",
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
                  controller: commentController,
                  maxLines: 10,
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
    );
  }

  Widget buildBuyButton(){
    return RawMaterialButton(
      onPressed: (){
        Map<String, String> foodMap = {};
        for (var f in globals.cart) {
          foodMap['food_id_${globals.cart.indexOf(f)+1}'] = f.id.toString();
        }
        int index = 1;
        for (var f in globals.cartAmounts) {
         foodMap['food_amount_${index.toString()}'] = f.toString();
         index++;
        }
        foodMap.addAll({
          'user_id': user.id.toString(),
          'nr_of_products' : globals.cart.length.toString()
        });
        if(commentController.text.isNotEmpty){
          foodMap.addAll({
            'comments': commentController.text,
          });
        }
        print(foodMap);
        if(val==1){
          if(cardController.text.isNotEmpty && dateController.text.isNotEmpty && cvvController.text.isNotEmpty){
            BlocProvider.of<OrderBloc>(context).add(OrderFood(foodMap));
          }else{
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Uzupełnij dane karty płatniczej!'), backgroundColor: mainRed, duration: Duration(milliseconds: 400),));
          }
        }else if(val==2){
          if(selectedBank == bankList[0]){
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Wybierz bank z listy!'), backgroundColor: mainRed, duration: Duration(milliseconds: 400),));
          }else{
            BlocProvider.of<OrderBloc>(context).add(OrderFood(foodMap));
          }
        }else{
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Wybierz metodę płatności!'), backgroundColor: mainRed, duration: Duration(milliseconds: 400),));
        }

      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Text('Zapłać'),
      ),
      textStyle: const TextStyle(
        color: Colors.white,
        fontFamily: 'Montserrat',
        fontSize: 17,
      ),
      elevation: 0,
      fillColor: mainOrange,
    );
  }


  double countSum(){
    double sum =0;
    for(int i=0; i<globals.cart.length; i++){
      sum+= globals.cart[i].price*globals.cartAmounts[i];
    }
    return sum;
  }

}
