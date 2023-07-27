import 'package:baza_dan/src/domain/entities/user.dart';

abstract class LoginState{
  final User? user;
  const LoginState({this.user});
}

class LoginInitial extends LoginState{
  const LoginInitial();
}

class LoginDone extends LoginState{
  const LoginDone(User user) : super(user: user);
}

class LoginError extends LoginState{
  const LoginError();
}

class LoginLoading extends LoginState{
  const LoginLoading();
}

