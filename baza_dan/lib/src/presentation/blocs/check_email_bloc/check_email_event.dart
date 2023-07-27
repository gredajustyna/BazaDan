abstract class CheckEmailEvent{
  final String? email;
  const CheckEmailEvent({this.email});
}

class CheckEmail extends CheckEmailEvent{
  const CheckEmail(String email):super(email: email);
}