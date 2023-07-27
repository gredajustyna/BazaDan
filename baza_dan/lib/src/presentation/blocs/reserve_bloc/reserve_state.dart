abstract class ReserveState{
  const ReserveState();
}

class ReserveInitial extends ReserveState{
  const ReserveInitial();
}

class ReserveLoading extends ReserveState{
  const ReserveLoading();
}

class ReserveDone extends ReserveState{
  const ReserveDone();
}

class ReserveError extends ReserveState{
  const ReserveError();
}