import 'package:baza_dan/src/domain/usecases/check_email_usecase.dart';
import 'package:baza_dan/src/presentation/blocs/check_email_bloc/check_email_event.dart';
import 'package:baza_dan/src/presentation/blocs/check_email_bloc/check_email_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckEmailBloc extends Bloc<CheckEmailEvent, CheckEmailState>{
  final CheckEmailUseCase _checkEmailUseCase;
  CheckEmailBloc(this._checkEmailUseCase): super(const CheckEmailInitial()) {
    on<CheckEmailEvent>((event, emit) async {
      await _registerHandler(emit, event.email!);
    });
  }

  Future<void> _registerHandler(Emitter<CheckEmailState> emit, String email) async {
    emit(const CheckEmailInProgress());
    final result = await _checkEmailUseCase(params: email);
    if(result == true){
      emit(const CheckEmailDone());
    }else if(result == 7){
      emit(const CheckEmailError("Podany adres email znajduje się już w naszej bazie!"));
    }else if(result == 8){
      emit(const CheckEmailError("Podaj poprawny format adresu email!"));
    }else{
      emit(const CheckEmailError("Ups! coś poszło nie tak! Spróbuj jeszcze raz!"));
    }
  }
}