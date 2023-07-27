abstract class GetOrdersEvent{
  final String? userId;
  final String? orderId;
  const GetOrdersEvent({this.userId, this.orderId});
}

class GetAllOrders extends GetOrdersEvent{
  const GetAllOrders(String userId) : super(userId: userId);
}

abstract class GetDetailsEvent{
  final String? orderId;
  const GetDetailsEvent({this.orderId});
}


class GetAllDetails extends GetDetailsEvent{
  const GetAllDetails(String orderId) : super(orderId: orderId);
}