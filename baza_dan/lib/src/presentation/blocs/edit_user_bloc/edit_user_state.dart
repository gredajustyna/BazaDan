abstract class EditUserState{
  const EditUserState();
}

class EditUserInitial extends EditUserState{
  const EditUserInitial();
}

class EditUserLoading extends EditUserState{
  const EditUserLoading();
}

class EditUserDone extends EditUserState{
  const EditUserDone();
}

class EditUserError extends EditUserState{
  const EditUserError();
}