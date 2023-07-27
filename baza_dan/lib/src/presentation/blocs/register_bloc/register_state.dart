import 'package:baza_dan/src/domain/entities/user.dart';

abstract class RegisterState{
  final User? user;
  final String? message;
  const RegisterState({this.user, this.message});
}

class RegisterInitial extends RegisterState{
  const RegisterInitial();
}

class RegisterDone extends RegisterState{
  const RegisterDone(User user): super(user: user);
}

class RegisterError extends RegisterState{
  const RegisterError(String errorMesage) : super(message: errorMesage);
}

class RegisterLoading extends RegisterState{
  const RegisterLoading();
}

