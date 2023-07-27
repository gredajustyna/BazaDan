abstract class GetOrdersState{
  final List<Map<String, dynamic>>? ordersList;
  const GetOrdersState({this.ordersList});
}

class GetOrdersInitial extends GetOrdersState{
  const GetOrdersInitial();
}

class GetOrdersLoading extends GetOrdersState{
  const GetOrdersLoading();
}

class GetOrdersError extends GetOrdersState{
  const GetOrdersError();
}

class GetOrdersDone extends GetOrdersState{
  const GetOrdersDone(List<Map<String, dynamic>>? ordersList): super(ordersList: ordersList);
}

class GetOrdersEmpty extends GetOrdersState{
  const GetOrdersEmpty();
}

abstract class GetDetailsState{
  final List<Map<String, dynamic>> ? details;
  const GetDetailsState({this.details});
}

class GetDetailsInitial extends GetDetailsState{
  const GetDetailsInitial();
}

class GetDetailsLoading extends GetDetailsState{
  const GetDetailsLoading();
}

class GetDetailsError extends GetDetailsState{
  const GetDetailsError();
}

class GetDetailsDone extends GetDetailsState{
  const GetDetailsDone( List<Map<String, dynamic>>  details) : super(details: details);
}

