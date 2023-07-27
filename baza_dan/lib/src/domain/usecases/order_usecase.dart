import 'package:baza_dan/src/core/usecases/future_usecase.dart';
import 'package:baza_dan/src/domain/repositories/food_repository.dart';
import 'dart:convert';

class OrderUseCase implements FutureUseCase<bool, Map<String, String>>{
  final FoodRepository _foodRepository;
  OrderUseCase(this._foodRepository);

  @override
  Future<bool> call({required Map<String, String> params}) async{
    var info = await _foodRepository.order(params);
    if(info == null){
      return false;
    }
    var result = jsonDecode(info);
    print(result);
    if(result == "true"){
      return true;
    }else{
      return false;
    }
  }


}