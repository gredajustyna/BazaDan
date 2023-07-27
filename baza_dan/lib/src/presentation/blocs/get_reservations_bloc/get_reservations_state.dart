abstract class GetReservationsState{
  final List<Map<String, dynamic>>? reservations;
  const GetReservationsState({this.reservations});
}

class GetReservationsInitial extends GetReservationsState{
  const GetReservationsInitial();
}

class GetReservationsLoading extends GetReservationsState{
  const GetReservationsLoading();
}

class GetReservationsError extends GetReservationsState{
  const GetReservationsError();
}

class GetReservationsDone extends GetReservationsState{
  const GetReservationsDone(List<Map<String, dynamic>> reservations): super(reservations: reservations);
}