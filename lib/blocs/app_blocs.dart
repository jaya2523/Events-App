import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tif_assg/repos/repositories.dart';

import 'app_events.dart';
import 'app_states.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      print("You emitted the first state");
      try{
        final users = await _userRepository.getUsers();
        emit(UserLoadedState(users));
      }catch(e){
        emit(UserErrorState(e.toString()));
      }
      
    });
  }
}
