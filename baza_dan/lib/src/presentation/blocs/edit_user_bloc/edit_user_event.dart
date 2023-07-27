abstract class EditUserEvent{
  final Map<String, String>? user;
  const EditUserEvent({this.user});
}

class EditUser extends EditUserEvent{
  const EditUser(Map<String, String> user) : super (user: user);
}