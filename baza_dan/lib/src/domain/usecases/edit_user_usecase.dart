import 'package:baza_dan/src/core/usecases/future_usecase.dart';
import 'package:baza_dan/src/domain/repositories/food_repository.dart';
import 'dart:convert';

class EditUserUseCase implements FutureUseCase<bool, Map<String, String>>{
  final FoodRepository _foodRepository;
  EditUserUseCase(this._foodRepository);

  @override
  Future<bool> call({required Map<String, String> params}) async{
    var info = await _foodRepository.updateData(params);
    if(info != null && info.toString().isNotEmpty && info!= '""'){
      var result = json.decode(info);
      if(result == 'true'){
        return true;
      }else {
        return false;
      }
    }else{
      return false;
    }
  }


}