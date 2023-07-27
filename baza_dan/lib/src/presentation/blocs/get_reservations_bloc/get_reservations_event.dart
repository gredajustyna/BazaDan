abstract class GetReservationsEvent{
  final String? userId;
  const GetReservationsEvent({this.userId});
}

class GetAllReservations extends GetReservationsEvent{
  const GetAllReservations(String userId) : super(userId: userId);
}