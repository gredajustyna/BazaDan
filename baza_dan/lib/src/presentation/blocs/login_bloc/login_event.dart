abstract class LoginEvent {
  final Map<String, String>? params;
  const LoginEvent({this.params});
}
class LogIn extends LoginEvent{
  const LogIn(Map<String, String>? params) : super(params: params);
}