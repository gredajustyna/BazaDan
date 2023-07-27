abstract class ReserveEvent{
  final Map<String, String>? orderMap;
  const ReserveEvent({this.orderMap});
}

class ReserveTable extends ReserveEvent{
  const ReserveTable(Map<String, String> orderMap) :super(orderMap: orderMap);
}