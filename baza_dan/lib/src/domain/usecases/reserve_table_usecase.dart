import 'dart:convert';

import 'package:baza_dan/src/core/usecases/future_usecase.dart';
import 'package:baza_dan/src/domain/repositories/food_repository.dart';

class ReserveTableUseCase implements FutureUseCase<bool, Map<String, String>>{
  final FoodRepository _foodRepository;
  ReserveTableUseCase(this._foodRepository);

  @override
  Future<bool> call({required Map<String, String> params}) async{
    var info = await _foodRepository.reserve(params);
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