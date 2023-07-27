abstract class RegisterEvent{
  final Map<String, String>? params;
  final String? email;
  const RegisterEvent({this.params, this.email});
}

class Register extends RegisterEvent{
  const Register(Map<String, String> params) : super(params: params);
}

