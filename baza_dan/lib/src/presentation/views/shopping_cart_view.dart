import 'package:baza_dan/src/config/themes/colors.dart';
import 'package:baza_dan/src/domain/entities/food.dart';
import 'package:baza_dan/src/domain/entities/user.dart';
import 'package:baza_dan/src/presentation/views/order_summary_view.dart';
import 'package:baza_dan/src/presentation/widgets/cart_food_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:baza_dan/src/data/my_globals.dart' as globals;

import 'package:collection/collection.dart';



class ShoppingCartView extends StatefulWidget {
  final User user;
  const ShoppingCartView({Key? key, required this.user}) : super(key: key);

  @override
  _ShoppingCartViewState createState() => _ShoppingCartViewState();
}

class _ShoppingCartViewState extends State<ShoppingCartView> {
  double sum = 0;

  @override
  void initState() {
    for(int i=0; i<globals.cart.length; i++){
      sum+= globals.cart[i].price*globals.cartAmounts[i];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: buildAppbar(),
      body: _buildBody(),
      bottomNavigationBar: buildBottomContainer(),
    );
  }

  PreferredSizeWidget buildAppbar(){
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: mainOrange,
      title: const Text(
        'Koszyk',
        style: TextStyle(
          color: mainWhite,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBody(){
    if(globals.cart.isNotEmpty){
      return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: globals.cart.length,
          itemBuilder: (context, index){
            return Dismissible(
                direction: DismissDirection.endToStart,
                key: UniqueKey(),
                background: Container(
                  color: mainRed,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('Przesuń, aby usunąć',
                        style: TextStyle(
                          color: mainWhite,
                        ),
                      ),
                    ),
                  ),
                ),
                onDismissed: (direction){
                  setState(() {
                    globals.cartAmounts.removeAt(index);
                    globals.cart.removeAt(index);
                    sum = sum;
                  });
                },
              child: CartFoodWidget(food: globals.cart[index], amount: globals.cartAmounts[index], notifyParent: refresh,));
          }
      );
    }else{
      return Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
          child: Column(
            children: const [
              Icon(
                Icons.remove_shopping_cart_outlined,
                size: 70,
                color: mainOrange,
              ),
              Text(
                'Twój koszyk jest pusty! Może skusisz się na małe co nieco?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: mainOrange,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      );
    }
  }



  Widget buildBottomContainer(){
    if(globals.cart.isNotEmpty){
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Suma: '+ sum.toStringAsFixed(2),
                  style: TextStyle(
                      color: mainGrey,
                      fontSize: 15
                  ),
                ),
                buildBuyButton()
              ],
            ),
          ),
        ),
      );
    }else{
      return BottomAppBar(
        child: Container(
          height: 1.0,
          width: double.maxFinite,
        ),
      );
    }

  }

  Widget buildBuyButton(){
    return RawMaterialButton(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OrderSummaryView(user: widget.user)));
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Text('Podsumowanie'),
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


  void updateSum(){
    sum =0;
    for(int i=0; i<globals.cart.length; i++){
      sum+= globals.cart[i].price*globals.cartAmounts[i];
    }
  }

  void refresh() {
    updateSum();
    print('suma: ${globals.cartAmounts.sum}');
    setState(() {});
  }
}
