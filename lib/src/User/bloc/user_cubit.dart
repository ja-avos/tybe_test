import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyba_test/src/User/models/user_model.dart';
import 'package:tyba_test/src/User/repository/user_repository.dart';
import 'package:tyba_test/src/utils/request_status.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;

  UserCubit(this.userRepository) : super(const UserState()) {
    userRepository.onAuthStateChanged.listen((User? user) {
      if (user != null) {
        emit(UserState.authenticated(user));
      } else {
        emit(UserState.unauthenticated());
      }
    });
  }

  Future<void> checkSession() async {
    emit(UserState.loading());
    try {
      final user = userRepository.getCurrentUser();
      if (user != null) {
        emit(UserState.authenticated(user));
      } else {
        emit(UserState.unauthenticated());
      }
    } catch (e) {
      emit(UserState.error(e.toString()));
    }
  }

  void register(User user, String password) async {
    emit(state.copyWith(status: RequestStatus.inProgress));
    try {
      final userAuth = await userRepository.register(user, password);
      if (userAuth != null) {
        emit(UserState.authenticated(user));
      } else {
        throw Exception('No se logró registrar el usuario');
      }
    } catch (e) {
      emit(UserState.error(e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: RequestStatus.inProgress));
    try {
      final userAuth = await userRepository.login(email, password);
      if (userAuth != null) {
        emit(UserState.authenticated(userAuth));
      } else {
        throw Exception('No se logró iniciar sesión');
      }
    } catch (e) {
      emit(UserState.error(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(status: RequestStatus.inProgress));
    try {
      await userRepository.logout();
      emit(UserState.unauthenticated(message: "Sesión cerrada"));
    } catch (e) {
      emit(UserState.error(e.toString()));
    }
  }
}
