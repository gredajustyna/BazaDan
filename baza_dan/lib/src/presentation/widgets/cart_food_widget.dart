import 'package:baza_dan/src/config/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:baza_dan/src/domain/entities/food.dart';
import 'package:baza_dan/src/data/my_globals.dart' as globals;



class CartFoodWidget extends StatefulWidget {
  final Function() notifyParent;
  final Food food;
  int amount;
  CartFoodWidget({Key? key,required this.food, required this.amount,required this.notifyParent}) : super(key: key);

  @override
  _CartFoodWidgetState createState() => _CartFoodWidgetState();
}

class _CartFoodWidgetState extends State<CartFoodWidget> {
  late int amount;
  late Food food;
  late Function notifyParent;

  @override
  void initState() {
    amount = widget.amount;
    food = widget.food;
    notifyParent = widget.notifyParent;
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
                Container(
                  width: 50,
                  height: 50,
                  child: Image.asset(food.image),
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
                          Text((food.price*amount).toStringAsFixed(2),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: mainGrey,
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
                                    if(amount>1){
                                      int index = globals.cart.indexOf(food);
                                      amount-=1;
                                      globals.cartAmounts[index] = amount;
                                      print(globals.cartAmounts[index]);
                                      notifyParent();
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
                                      int index = globals.cart.indexOf(food);
                                      amount+=1;
                                      globals.cartAmounts[index] = amount;
                                      notifyParent();
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
