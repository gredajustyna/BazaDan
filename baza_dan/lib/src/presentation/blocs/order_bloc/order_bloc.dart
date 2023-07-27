import 'package:baza_dan/src/domain/usecases/order_usecase.dart';
import 'package:baza_dan/src/presentation/blocs/order_bloc/order_event.dart';
import 'package:baza_dan/src/presentation/blocs/order_bloc/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState>{
  final OrderUseCase _orderUseCase;
  OrderBloc(this._orderUseCase) : super(OrderInitial()) {
    on<OrderEvent>((event, emit) async {
      await _orderHandler(emit, event.order!);
    });

  }

  Future<void> _orderHandler(Emitter<OrderState> emit, Map<String, String> order) async {
    emit(const OrderLoading());
    final result = await _orderUseCase(params: order);
    if(result == true){
      emit(const OrderDone());
    }else{
      emit(const OrderError());
    }
  }

}