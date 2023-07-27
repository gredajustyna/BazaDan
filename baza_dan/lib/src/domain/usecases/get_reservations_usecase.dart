import 'dart:convert';

import 'package:baza_dan/src/core/usecases/future_usecase.dart';
import 'package:baza_dan/src/domain/repositories/food_repository.dart';

class GetReservationsUseCase implements FutureUseCase<dynamic, String>{
  final FoodRepository _foodRepository;
  const GetReservationsUseCase(this._foodRepository);

  @override
  Future call({required String params}) async{
    var info = await _foodRepository.getReservations(params);
    if(info != null && info.toString().isNotEmpty && info!= '""'){
      List<Map<String, dynamic>> reservationList= [];
      var ordersMap = json.decode(info);
      int len = ordersMap.length;
      print(len);
      for(int i=0; i<len; i++){
        Map<String, dynamic> data1 = Map<String, dynamic>.from(json.decode(info)[i]);
        reservationList.add(data1);
      }
      return reservationList;
    }else{
      return null;
    }
  }

}