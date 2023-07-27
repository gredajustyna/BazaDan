import 'package:baza_dan/src/domain/entities/user.dart';
import 'package:baza_dan/src/domain/repositories/food_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FoodRepositoryImpl implements FoodRepository{
  @override
  Future<dynamic> logIn(String email, String password) async{
    String url = "https://s402639.labagh.pl/login.php";
    final response = await http.post(Uri.parse(url), body:{
      "email" : email,
      "password" : password
    });
    if(response.statusCode == 200){
      return jsonEncode(response.body);
    }else{
      return null;
    }
  }

  @override
  Future<dynamic> register(Map<String, String> user) async{
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

  @override
  Future<dynamic> checkEmail(String email) async {
    String url = "https://s402639.labagh.pl/register_init.php";
    final response = await http.post(Uri.parse(url), body:{
      "email" : email
    });
    if(response.statusCode == 200){
      return jsonEncode(response.body);
    }else{
      return null;
    }
  }

  @override
  Future getFoodList(String category) async{
    String url = "https://s402639.labagh.pl/get_food.php";
    final response = await http.post(Uri.parse(url), body:{
      "category" : category
    });
    if(response.statusCode == 200){
      return response.body;
    }else{
      return null;
    }
  }

  @override
  Future order(Map<String, String> order) async{
    String url = "https://s402639.labagh.pl/create_order.php";
    if(order.containsKey('comments')){
      final response = await http.post(Uri.parse(url), body:order);
      if(response.statusCode == 200){
        print(response.body);
        return response.body;
      }else{
        return null;
      }
    }else{
      final response = await http.post(Uri.parse(url), body:order);
      if(response.statusCode == 200){
        print(response.body);
        return response.body;
      }else{
        return null;
      }
    }
  }

  @override
  Future updateData(Map<String, String> user) async {
    String url = "https://s402639.labagh.pl/update_user.php";
    print(user);
    if(user.containsKey('apartment_nr')){
      final response = await http.post(Uri.parse(url), body:{
        'user_id' : user['user_id'],
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
        return response.body;
      }else{
        return null;
      }
    }else{
      final response = await http.post(Uri.parse(url), body:{
        'user_id' : user['user_id'],
        "name": user['name'],
        "lastname": user['lastname'],
        "street" : user['street'] ,
        "house_nr" : user['house_nr'],
        "postal_code": user['postal_code'],
        "city": user['city'],
        "phone_nr":  user['phone_nr']
      });
      if(response.statusCode == 200){
        return response.body;
      }else{
        return null;
      }
    }
  }

  @override
  Future getRandomFood() async{
    String url = "https://s402639.labagh.pl/get_random_food.php";
    final response = await http.post(Uri.parse(url), body:{
    });
    if(response.statusCode == 200){
      return response.body;
    }else{
      return null;
    }
  }

  @override
  Future getOrders(String userId) async{
    String url = "https://s402639.labagh.pl/get_orders.php";
    final response = await http.post(Uri.parse(url), body:{
      "user_id" : userId,
    });
    if(response.statusCode == 200){
      return response.body;
    }else{
      return null;
    }
  }

  @override
  Future getOrderDetails(String orderId) async{
    String url = "https://s402639.labagh.pl/get_orders_details.php";
    final response = await http.post(Uri.parse(url), body:{
      "order_id" : orderId,
    });
    if(response.statusCode == 200){
      return response.body;
    }else{
      return null;
    }
  }

  @override
  Future getTables(String datetime) async {
    String url = "https://s402639.labagh.pl/get_table_status.php";
    final response = await http.post(Uri.parse(url), body:{
      "datetime" : datetime,
    });
    if(response.statusCode == 200){
      return response.body;
    }else{
      return null;
    }
  }

  @override
  Future reserve(Map<String, String> orderMap) async{
    String url = "https://s402639.labagh.pl/create_reservation.php";
    if(orderMap.containsKey('comments')){
      final response = await http.post(Uri.parse(url), body:{
        "user_id" : orderMap['user_id'],
        "wanted_time" : orderMap['wanted_time'],
        "table_id" : orderMap['table_id'],
        "comments" : orderMap['comments']
      });
      if(response.statusCode == 200){
        return response.body;
      }else{
        return null;
      }
    }else{
      final response = await http.post(Uri.parse(url), body:{
        "user_id" : orderMap['user_id'],
        "wanted_time" : orderMap['wanted_time'],
        "table_id" : orderMap['table_id'],
      });
      if(response.statusCode == 200){
        return response.body;
      }else{
        return null;
      }
    }
  }

  @override
  Future getReservations(String userId) async{
    String url = "https://s402639.labagh.pl/get_reservations.php";
    final response = await http.post(Uri.parse(url), body:{
      "user_id" : userId,
    });
    if(response.statusCode == 200){
      return response.body;
    }else{
      return null;
    }
  }
}