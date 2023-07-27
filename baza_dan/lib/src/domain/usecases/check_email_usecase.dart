import 'dart:convert';

import 'package:baza_dan/src/core/usecases/future_usecase.dart';
import 'package:baza_dan/src/domain/repositories/food_repository.dart';

class CheckEmailUseCase extends FutureUseCase<dynamic, String>{
  final FoodRepository _foodRepository;
  CheckEmailUseCase(this._foodRepository);

  @override
  Future<dynamic> call({required String params}) async{
    var info = await _foodRepository.checkEmail(params);
    print(info);
    var result = jsonDecode(info).toString().replaceAll("\"", "");
    print(result);
    if(result == "true"){
      return true;
    }else if(result == "7"){
      return 7;
    }else if(result == "8"){
      return 8;
    }else{
      return false;
    }
  }

}