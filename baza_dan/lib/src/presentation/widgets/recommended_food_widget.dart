import 'package:baza_dan/src/config/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecommendedFoodWidget extends StatelessWidget {
  final String foodName;
  final String foodImg;
  const RecommendedFoodWidget({Key? key, required this.foodName, required this.foodImg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        height: MediaQuery.of(context).size.height/5,
        width: MediaQuery.of(context).size.width/2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: lightOrange,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.height/(7.2),
                height: MediaQuery.of(context).size.height/(7.2),
                child: Image.asset(foodImg)
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  foodName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: mainOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                ),
              ),
            ]
          ),
        )
      )
    );
  }
}
