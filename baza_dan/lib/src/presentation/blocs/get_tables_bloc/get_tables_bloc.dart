import 'package:baza_dan/src/domain/usecases/get_tables_usecase.dart';
import 'package:baza_dan/src/presentation/blocs/get_tables_bloc/get_tables_event.dart';
import 'package:baza_dan/src/presentation/blocs/get_tables_bloc/get_tables_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetTablesBloc extends Bloc<GetTablesEvent, GetTablesState>{
  final GetTablesUseCase _getTablesUseCase;
  GetTablesBloc(this._getTablesUseCase) : super(GetTablesInitial()){
    on<GetTablesEvent>((event, emit) async {
      await _tablesHandler(emit, event.datetime!);
    });
  }

  Future<void> _tablesHandler(Emitter<GetTablesState> emit, String date) async {
    emit(const GetTablesLoading());
    print(date);
    final result = await _getTablesUseCase(params: date);
    if(result != null){
      if(result == false){
        emit(const GetTablesWrongHour());
      }else{
        emit(GetTablesDone(result));
      }
    }else{
      emit(const GetTablesError());
    }
  }

}