import 'package:baza_dan/src/domain/usecases/edit_user_usecase.dart';
import 'package:baza_dan/src/presentation/blocs/edit_user_bloc/edit_user_event.dart';
import 'package:baza_dan/src/presentation/blocs/edit_user_bloc/edit_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditUserBloc extends Bloc<EditUserEvent, EditUserState>{
  final EditUserUseCase _editUserUseCase;
  EditUserBloc(this._editUserUseCase) : super(EditUserInitial()) {
    on<EditUserEvent>((event, emit) async {
      await _editUserHandler(emit, event.user!);
    });

  }

  Future<void> _editUserHandler(Emitter<EditUserState> emit, Map<String, String> params) async {
    emit(const EditUserLoading());
    final result = await _editUserUseCase(params: params);
    if(result == true){
      emit(EditUserDone());
    }else{
      emit(EditUserError());
    }
  }

}