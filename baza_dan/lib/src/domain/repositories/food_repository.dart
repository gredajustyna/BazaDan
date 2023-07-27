import 'package:baza_dan/src/domain/entities/user.dart';

abstract class FoodRepository{

  Future<dynamic> logIn(String email, String password);

  Future<dynamic> register(Map<String, String> user);

  Future<dynamic> checkEmail(String email);

  Future<dynamic> getFoodList(String category);

  Future<dynamic> order(Map<String, String> order);

  Future<dynamic> updateData(Map<String, String> user);

  Future<dynamic> getRandomFood();

  Future<dynamic> getOrders(String userId);

  Future<dynamic> getOrderDetails(String orderId);

  Future<dynamic> getTables(String datetime);

  Future<dynamic> reserve(Map<String, String> orderMap);

  Future<dynamic> getReservations(String userId);
}