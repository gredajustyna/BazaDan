import 'package:baza_dan/src/domain/usecases/login_usecase.dart';
import 'package:baza_dan/src/presentation/blocs/login_bloc/login_event.dart';
import 'package:baza_dan/src/presentation/blocs/login_bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  final LoginUseCase _loginUseCase;

  LoginBloc(this._loginUseCase) : super(const LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      await _loginHandler(emit, event.params!);
    });
  }

  Future<void> _loginHandler(Emitter<LoginState> emit, Map<String, String> params) async {
    emit(LoginLoading());
    final result = await _loginUseCase(params: params);
    if(result != null){
      emit(LoginDone(result));
    }else{
      emit(LoginError());
    }
  }

}