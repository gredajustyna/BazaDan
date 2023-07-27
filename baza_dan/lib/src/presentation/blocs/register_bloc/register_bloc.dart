import 'package:baza_dan/src/domain/entities/user.dart';
import 'package:baza_dan/src/domain/usecases/login_usecase.dart';
import 'package:baza_dan/src/domain/usecases/register_usecase.dart';
import 'package:baza_dan/src/presentation/blocs/register_bloc/register_event.dart';
import 'package:baza_dan/src/presentation/blocs/register_bloc/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{
  final RegisterUseCase _registerUseCase;
  final LoginUseCase _loginUseCase;
  RegisterBloc(this._registerUseCase, this._loginUseCase): super(const RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      await _registerHandler(emit, event.params!);
    });
  }

  Future<void> _registerHandler(Emitter<RegisterState> emit, Map<String, String> params) async {
    emit(const RegisterLoading());
    final result = await _registerUseCase(params: params);
    if(result == 0){
      User user = await _loginUseCase(params: params);
      emit(RegisterDone(user));
      // if(params.containsKey('apartment_nr')){
      //   User user = User(name: params['name']!, lastname: params['lastname']!, email: params['email']!, street: params['street']!, houseNr: params['house_nr']!, postalCode: params['postal_code']!, city: params['city']!, phoneNumber: params['phone_nr']!, apartmentNr: params['apartment_nr']);
      //   print(user);
      //   emit(RegisterDone(user));
      // }else{
      //   User user = User(name: params['name']!, lastname: params['lastname']!, email: params['email']!, street: params['street']!, houseNr: params['house_nr']!, postalCode: params['postal_code']!, city: params['city']!, phoneNumber: params['phone_nr']!);
      //   print(user);
      //   emit(RegisterDone(user));
      // }
    }else if(result == 1){
      emit(const RegisterError("Podaj poprawny format imienia!"));
    }
    else if(result == 2){
      emit(const RegisterError("Podaj poprawny format nazwiska!"));
    }
    else if(result == 3){
      emit(const RegisterError("Podaj poprawny format nazwy ulicy!"));
    }
    else if(result == 4){
      emit(const RegisterError("Podaj poprawny format kodu pocztowego! (xx-xxx)"));
    }
    else if(result == 5){
      emit(const RegisterError("Podaj poprawny format nazwy miasta"));
    }
    else if(result == 6){
      emit(const RegisterError("Podaj poprawny format numeru telefonu (9 cyfr)"));
    }else{
      emit(const RegisterError("Ups! Coś poszło nie tak. Spróbuj jeszcze raz!"));
    }
  }
}
