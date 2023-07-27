import 'package:baza_dan/src/domain/usecases/reserve_table_usecase.dart';
import 'package:baza_dan/src/presentation/blocs/reserve_bloc/reserve_event.dart';
import 'package:baza_dan/src/presentation/blocs/reserve_bloc/reserve_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReserveBloc extends Bloc<ReserveEvent, ReserveState>{
  final ReserveTableUseCase _reserveTableUseCase;

  ReserveBloc(this._reserveTableUseCase) : super(ReserveInitial()){
    on<ReserveEvent>((event, emit) async {
      await _reservationHandler(emit, event.orderMap!);
    });
  }

  Future<void> _reservationHandler(Emitter<ReserveState> emit, Map<String, String> params) async {
    emit(ReserveLoading());
    final result = await _reserveTableUseCase(params: params);
    if(result == true){
      emit(ReserveDone());
    }else{
      emit(ReserveError());
    }
  }

}