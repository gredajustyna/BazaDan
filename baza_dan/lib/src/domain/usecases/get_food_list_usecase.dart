import 'dart:convert';

import 'package:baza_dan/src/core/usecases/future_usecase.dart';
import 'package:baza_dan/src/domain/entities/food.dart';
import 'package:baza_dan/src/domain/repositories/food_repository.dart';

class GetFoodListUseCase implements FutureUseCase<dynamic, String>{
  final FoodRepository _foodRepository;
  GetFoodListUseCase(this._foodRepository);

  @override
  Future call({required String params}) async{
    var info = await _foodRepository.getFoodList(params);
    if(info != null && info.toString().isNotEmpty && info!= '""'){
      List<Food> foodList= [];
      var foodMap = json.decode(info);
      int len = foodMap.length;
      print(len);
      for(int i=0; i<len; i++){
        Map<String, dynamic> data1 = Map<String, dynamic>.from(json.decode(info)[i][0]);
        Food food = Food.fromJson(data1);
        food.image = getFoodPhoto(food.id);
        foodList.add(food);
      }
      return foodList;
    }else{
      return null;
    }
  }

  String getFoodPhoto(int foodId){
    switch(foodId){
      case 1:
        return "assets/menu/strips.png";
      case 2:
        return "assets/menu/burrito.png";
      case 3:
        return "assets/menu/burger.png";
      case 4:
        return "assets/menu/chicken_burger.png";
      case 5:
        return "assets/menu/sandwich.png";
      case 6:
        return "assets/menu/chicken.png";
      case 7:
        return "assets/menu/fish.png";
      case 8:
        return "assets/menu/kebab_1.png";
      case 9:
        return "assets/menu/kebab_2.png";
      case 10:
        return "assets/menu/spaghetti.png";
      case 11:
        return "assets/menu/carbonara.png";
      case 12:
        return "assets/menu/chow_mein.png";
      case 13:
        return "assets/menu/pizza_pepperoni.png";
      case 14:
        return "assets/menu/pizza_hawajska.png";
      case 15:
        return "assets/menu/pizza_bogata.png";
      case 16:
        return "assets/menu/fries.png";
      case 17:
        return "assets/menu/rice.png";
      case 18:
        return "assets/menu/salad.png";
      case 19:
        return "assets/menu/cola.png";
      case 20:
        return "assets/menu/pepsi.png";
      case 21:
        return "assets/menu/sprite.png";
      case 22:
        return "assets/menu/water.png";
      case 23:
        return "assets/menu/juice.png";
      default:
        return "assets/menu/burger.png";
    }
  }

}