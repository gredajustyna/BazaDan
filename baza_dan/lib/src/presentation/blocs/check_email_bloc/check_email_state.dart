abstract class CheckEmailState{
  final String? message;
  const CheckEmailState({this.message});
}

class CheckEmailInitial extends CheckEmailState{
  const CheckEmailInitial();
}

class CheckEmailDone extends CheckEmailState{
  const CheckEmailDone();
}

class CheckEmailError extends CheckEmailState{
  const CheckEmailError(String errorMessage) : super(message: errorMessage);
}

class CheckEmailInProgress extends CheckEmailState{
  const CheckEmailInProgress();
}