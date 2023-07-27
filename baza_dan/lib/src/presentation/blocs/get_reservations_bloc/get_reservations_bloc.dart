import 'package:baza_dan/src/domain/usecases/get_reservations_usecase.dart';
import 'package:baza_dan/src/presentation/blocs/get_reservations_bloc/get_reservations_event.dart';
import 'package:baza_dan/src/presentation/blocs/get_reservations_bloc/get_reservations_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetReservationsBloc extends Bloc<GetReservationsEvent, GetReservationsState>{
  final GetReservationsUseCase _getReservationsUseCase;

  GetReservationsBloc(this._getReservationsUseCase) : super(GetReservationsInitial()){
    on<GetReservationsEvent>((event, emit) async {
      await _reservationHandler(emit, event.userId!);
    });
  }

  Future<void> _reservationHandler(Emitter<GetReservationsState> emit, String userId) async {
    emit(const GetReservationsLoading());
    final result = await _getReservationsUseCase(params: userId);
    if(result != null){
      emit(GetReservationsDone(result));
    }else{
      emit(const GetReservationsError());
    }
  }

}