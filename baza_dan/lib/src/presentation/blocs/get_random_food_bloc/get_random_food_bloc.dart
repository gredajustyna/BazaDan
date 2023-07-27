import 'package:baza_dan/src/domain/usecases/get_random_food_usecase.dart';
import 'package:baza_dan/src/presentation/blocs/get_random_food_bloc/get_random_food_event.dart';
import 'package:baza_dan/src/presentation/blocs/get_random_food_bloc/get_random_food_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetRandomFoodBloc extends Bloc<GetRandomFoodEvent, GetRandomFoodState>{
  final GetRandomFoodUseCase _getRandomFoodUseCase;

  GetRandomFoodBloc(this._getRandomFoodUseCase) : super(GetRandomFoodLoading()){
    on<GetRandomFoodEvent>((event, emit) async {
      await _foodHandler(emit);
    });
  }

  Future<void> _foodHandler(Emitter<GetRandomFoodState> emit) async {
    emit(const GetRandomFoodLoading());
    final result = await _getRandomFoodUseCase();
    if(result != null){
      emit(GetRandomFoodDone(result));
    }else{
      emit(const GetRandomFoodError());
    }
  }

}