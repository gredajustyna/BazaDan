import 'package:baza_dan/src/config/themes/colors.dart';
import 'package:baza_dan/src/presentation/blocs/food_bloc/food_bloc.dart';
import 'package:baza_dan/src/presentation/views/food_view.dart';
import 'package:baza_dan/src/presentation/views/main_view.dart';
import 'package:baza_dan/src/presentation/widgets/rounded_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baza_dan/src/domain/entities/food.dart';
import 'package:baza_dan/src/data/my_globals.dart' as globals;



import '../../../injector.dart';

class FoodWidget extends StatefulWidget {
  final Food food;
  FoodWidget({Key? key, required this.food}) : super(key: key);

  @override
  _FoodWidgetState createState() => _FoodWidgetState();
}

class _FoodWidgetState extends State<FoodWidget> {
  late final Food food;
  int amount = 0;
  @override
  void initState() {
    food = widget.food;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => FoodView(food: food)));
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Hero(
                      child: Image.asset(food.image),
                      tag: food.id,
                    ),
                  ),
                ),
                //A BIT OF SPACE
                SizedBox(width: 10),
                //NAME AND CODE
                Expanded(
                  flex:5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //ORGANIZATION NAME
                      Align(
                        alignment: Alignment.center,
                        child: Text(food.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: mainOrange,
                            fontSize: 18,
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(food.price.toStringAsFixed(2),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: mainOrange,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              RawMaterialButton(
                                constraints: BoxConstraints.tightFor(width: 15, height: 15),
                                elevation: 0,
                                onPressed: (){
                                  setState(() {
                                    if(amount>0){
                                      amount-=1;
                                    }
                                  });
                                },
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15*0.2)),
                                fillColor: mainOrange,
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 15 * 0.8,
                                ),
                              ),
                              Container(
                                width: 15,
                                child: Text(
                                  amount.toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: mainGrey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              RawMaterialButton(
                                constraints: BoxConstraints.tightFor(width: 15, height: 15),
                                elevation: 0,
                                onPressed: (){
                                  setState(() {
                                    if(amount<20){
                                      amount+=1;
                                    }
                                  });
                                },
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15*0.2)),
                                fillColor: mainOrange,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 15 * 0.8,
                                ),
                              ),
                              SizedBox(width: 5,),
                              IconButton(
                                onPressed: (){
                                  setState(() {
                                    if(amount>0){
                                      if(!globals.cart.contains(food)){
                                        globals.cart.add(food);
                                        globals.cartAmounts.add(amount);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(content: Text('Dodano do koszyka!'), backgroundColor: mainOrange, duration: Duration(milliseconds: 400),));
                                      }else{
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(content: Text('Ten przedmiot znajduje się już w koszyku!'), backgroundColor: mainRed, duration: Duration(milliseconds: 400),));
                                      }
                                    }
                                  });
                                },
                                icon: Icon(Icons.add_shopping_cart,
                                  color: mainOrange,
                                  size: 20,
                                ))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                //MORE SPACE
                Spacer(),
                //BUTTON TO EDIT THE ENTRY

              ],
            ),
            //SOME SPACE
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
