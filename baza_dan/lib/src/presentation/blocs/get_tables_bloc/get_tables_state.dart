abstract class GetTablesState{
  final Map<String, dynamic>? data;
  const GetTablesState({this.data});
}

class GetTablesInitial extends GetTablesState{
  const GetTablesInitial();
}

class GetTablesLoading extends GetTablesState{
  const GetTablesLoading();
}

class GetTablesDone extends GetTablesState{
  const GetTablesDone(Map<String, dynamic> data) : super(data: data);
}

class GetTablesError extends GetTablesState{
  const GetTablesError();
}

class GetTablesWrongHour extends GetTablesState{
  const GetTablesWrongHour();
}