import 'package:baza_dan/src/core/usecases/future_usecase.dart';
import 'package:baza_dan/src/domain/entities/user.dart';
import 'package:baza_dan/src/domain/repositories/food_repository.dart';
import 'package:http/http.dart';
import 'dart:convert';

class LoginUseCase implements FutureUseCase<dynamic, Map<String, String>>{
  final FoodRepository _foodRepository;
  LoginUseCase(this._foodRepository);

  @override
  Future<dynamic> call({required Map<String, String> params}) async{
    var info = await _foodRepository.logIn(params['email']!, params['password']!);
    if(info != null && info.toString().isNotEmpty && info!= '""'){
      print(info);
      //info.toString().replaceAll('\\', '');
      //Map<String, dynamic> userMap = jsonDecode(info);
      //String rawJson = '{"name":"Mary","age":30}';
      String myString = info.toString().replaceAll('\\n', '');
      myString = myString.replaceAll('\\', '');
      //print(info);
      //print(jsonDecode(myString.substring(1,myString.length-2)));
      print(myString);
      myString = myString.substring(1,myString.length-1);
      //print(rawJson);
      //print(jsonDecode(rawJson));
      //Map<String, dynamic> rawMap = jsonDecode(rawJson);
     //print(rawMap);
      Map<String, dynamic> userMap = jsonDecode(myString);
      print(userMap);
      User user = User.fromJson(userMap);
      return user;
    }else{
      return null;
    }
  }
}