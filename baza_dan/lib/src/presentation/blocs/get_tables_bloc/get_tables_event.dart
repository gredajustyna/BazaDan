abstract class GetTablesEvent{
  final String? datetime;
  const GetTablesEvent({this.datetime});
}

class GetTables extends GetTablesEvent{
  const GetTables(String datetime) : super(datetime: datetime);
}