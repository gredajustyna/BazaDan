import 'package:baza_dan/src/config/themes/colors.dart';
import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPress;
  final double iconSize;
  RoundedIconButton({required this.icon, required this.onPress, required this.iconSize});



  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tightFor(width: iconSize, height: iconSize),
      elevation: 0,
      onPressed: (){
        onPress;
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(iconSize*0.2)),
      fillColor: mainOrange,
      child: Icon(
        icon,
        color: Colors.white,
        size: iconSize * 0.8,
      ),
    );
  }
}