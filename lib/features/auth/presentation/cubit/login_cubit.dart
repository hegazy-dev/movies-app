import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/features/auth/data/repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    try {
      await _authRepository.login(email: email, password: password);

      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(LoginError(message: e.message ?? "Login failed"));
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(LoginLoading());

    try {
      await _authRepository.loginWithGoogle();

      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(LoginError(message: e.message ?? "Google login failed"));
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }
}
