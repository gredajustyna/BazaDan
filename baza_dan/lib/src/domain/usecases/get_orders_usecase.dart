import 'dart:convert';

import 'package:baza_dan/src/core/usecases/future_usecase.dart';
import 'package:baza_dan/src/domain/repositories/food_repository.dart';

class GetOrdersUseCase implements FutureUseCase<dynamic, String>{
  final FoodRepository _foodRepository;
  const GetOrdersUseCase(this._foodRepository);

  @override
  Future call({required String params}) async{
    var info = await _foodRepository.getOrders(params);
    if(info != null && info.toString().isNotEmpty && info!= '""'){
      List<Map<String, dynamic>> ordersList= [];
      var ordersMap = json.decode(info);
      if(ordersMap.toString() == "null"){
        return 0;
      }
      int len = ordersMap.length;
      print(len);
      for(int i=0; i<len; i++){
        Map<String, dynamic> data1 = Map<String, dynamic>.from(json.decode(info)[i]);
        print(data1);
        ordersList.add(data1);
      }
      return ordersList;
    }else{
      return null;
    }
  }

}