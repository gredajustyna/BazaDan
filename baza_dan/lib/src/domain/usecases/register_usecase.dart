import 'package:baza_dan/src/core/usecases/future_usecase.dart';
import 'package:baza_dan/src/domain/repositories/food_repository.dart';
import 'dart:convert';

class RegisterUseCase implements FutureUseCase<int, Map<String, String>>{
  final FoodRepository _foodRepository;
  RegisterUseCase(this._foodRepository);
  @override
  Future<int> call({required Map<String, String> params}) async{
    print(params);
    var info = await _foodRepository.register(params);
    if(info != null && info.toString().isNotEmpty && info!= '""'){
      var result = jsonDecode(info).toString().replaceAll("\"", "");
      if(result == 'true'){
        return 0;
      }else if(result =='1') {
        return 1;
      }else if(result =='2'){
        return 2;
      }else if(result =='3') {
        return 3;
      }else if(result =='4') {
        return 4;
      } else if(result =='5') {
        return 5;
      } else if(result =='6') {
        return 6;
      }else{
        return -1;
      }
    }else{
      return -1;
    }
  }
}