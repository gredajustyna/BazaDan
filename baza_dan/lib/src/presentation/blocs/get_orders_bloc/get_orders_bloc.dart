import 'package:baza_dan/src/domain/usecases/get_order_details_usecase.dart';
import 'package:baza_dan/src/domain/usecases/get_orders_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'get_orders_event.dart';
import 'get_orders_state.dart';

class GetOrdersBloc extends Bloc<GetOrdersEvent, GetOrdersState>{
  final GetOrdersUseCase _getOrdersUseCase;
  GetOrdersBloc(this._getOrdersUseCase) : super(GetOrdersInitial()){
    on<GetOrdersEvent>((event, emit) async {
      await _orderHandler(emit, event.userId!);
    });
  }

  Future<void> _orderHandler(Emitter<GetOrdersState> emit, String userId) async {
    emit(const GetOrdersLoading());
    final result = await _getOrdersUseCase(params: userId);
    if(result == 0){
      emit(const GetOrdersEmpty());
    }else if(result == null){
      emit(const GetOrdersError());
    }else{
      emit(GetOrdersDone(result));
    }
  }

}

class GetDetailsBloc extends Bloc<GetDetailsEvent, GetDetailsState>{
  final GetOrderDetailsUseCase _getOrderDetailsUseCase;
  GetDetailsBloc(this._getOrderDetailsUseCase) : super(GetDetailsInitial()){
    on<GetDetailsEvent>((event, emit) async {
      await _orderHandler(emit, event.orderId!);
    });
  }

  Future<void> _orderHandler(Emitter<GetDetailsState> emit, String orderId) async {
    emit(const GetDetailsLoading());
    final result = await _getOrderDetailsUseCase(params: orderId);
    if(result != null){
      emit(GetDetailsDone(result));
    }else{
      emit(const GetDetailsError());
    }
  }

}