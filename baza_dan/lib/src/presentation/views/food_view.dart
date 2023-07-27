import 'package:baza_dan/src/config/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:baza_dan/src/domain/entities/food.dart';
import 'package:line_icons/line_icon.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class FoodView extends StatefulWidget {
  final Food food;
  const FoodView({Key? key, required this.food}) : super(key: key);

  @override
  _FoodViewState createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  late Food food;
  late List<String> ingredients;

  @override
  void initState() {
    this.food = widget.food;
    ingredients = food.ingredients.split(',');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      appBar: _buildAppbar(),
    );
  }


  Widget _buildBody(){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height/2,
            child: Hero(
              tag: food.id,
              child: Image.asset(food.image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              food.name,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: mainOrange
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            child: Container(
              height: MediaQuery.of(context).size.height/5,
              child: Text(
                food.description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: mainGrey
                ),
              ),
            ),
          ),
          Text(
            'Składniki:',
            textAlign: TextAlign.right,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: mainOrange
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
            child: Container(
              height: MediaQuery.of(context).size.height/5,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: ingredients.length,
                itemBuilder: (context, index){
                  return _buildListItem(ingredients[index]);
                }
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppbar(){
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: mainOrange,
      title: const Text(
        'Podgląd',
        style: TextStyle(
          color: mainWhite,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Icon getFoodIcon(String ingredient){
    if(ingredient.contains('mięso') || ingredient.contains('jagnięcina')){
      return LineIcon.drumstickWithBiteTakenOut(
        color: Colors.brown,
      );
    }else if(ingredient.contains('ser') || ingredient.contains('parmezan')){
      return LineIcon.cheese(
        color: Colors.yellow,
      );
    }else if(ingredient.contains('stripsy') || ingredient.contains('kurczak')){
      return LineIcon.drumstickWithBiteTakenOut(
        color: Colors.brown,
      );
    }else if(ingredient.contains('jajko')){
      return LineIcon.egg(
        color: Colors.grey,
      );
    }else if(ingredient.contains('ryba')){
      return LineIcon.fish(
        color: Colors.blueGrey,
      );
    }else if(ingredient.contains('ziemniaki') || ingredient.contains('kapusta')){
      return LineIcon.seedling(
        color: Colors.green,
      );
    }else if(ingredient.contains('mieszanka')){
      return LineIcon.mortarPestle(
        color: Colors.orangeAccent,
      );
    }else if(ingredient.contains('boczek') || ingredient.contains('bekon') || ingredient.contains('szynka')){
      return LineIcon.bacon(
        color: Colors.pinkAccent,
      );
    }else if(ingredient.contains('tajemniczy')){
      return LineIcon.question(
        color: Colors.grey,
      );
    }else if(ingredient.contains('cebula') || ingredient.contains('sałata') || ingredient.contains('pomidor') || ingredient.contains('100%')){
      return LineIcon.leaf(
        color: Colors.green,
      );
    }else if(ingredient.contains('bułka')){
      return LineIcon.hamburger(
        color: Colors.brown,
      );
    }else if(ingredient.contains('marchew')){
      return LineIcon.carrot(
        color: Colors.orange,
      );
    }else if(ingredient.contains('ryż')){
      return const Icon(MdiIcons.rice,
        color: mainGrey,
      );
    }else if(ingredient.contains('pieczarki')){
      return const Icon(MdiIcons.mushroom,
        color: Colors.brown,
      );
    }else{
      return LineIcon.utensils(
        color: mainGrey,
      );
    }
  }

  Widget _buildListItem(String ingredient){
    return Row(
      children: [
        getFoodIcon(ingredient),
        SizedBox(width: 5,),
        Text(ingredient,
          style: TextStyle(
            color: mainGrey
          ),
        ),
      ],
    );
  }

}
