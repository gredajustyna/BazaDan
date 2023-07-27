abstract class OrderEvent{
  final Map<String, String>? order;
  const OrderEvent({this.order});
}

class OrderFood extends OrderEvent{
  OrderFood(Map<String, String> order) : super(order: order);
}