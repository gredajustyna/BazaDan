import 'dart:convert';

import 'package:baza_dan/src/core/usecases/future_usecase.dart';
import 'package:baza_dan/src/domain/repositories/food_repository.dart';

class GetTablesUseCase implements FutureUseCase<dynamic, String>{
  final FoodRepository _foodRepository;
  const GetTablesUseCase(this._foodRepository);

  @override
  Future call({required String params}) async {
    var info = await _foodRepository.getTables(params);
    print(info);
    if(json.decode(info) == "false"){
      return false;
    }
    if(info != null && info.toString().isNotEmpty && info!= '""'){
      Map<String, dynamic> data = Map<String, dynamic>.from(json.decode(info));
      return data;
    }else{
      return null;
    }
  }

}