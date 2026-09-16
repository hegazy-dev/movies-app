import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/features/auth/data/data_sources/auth_data_source.dart';
import 'package:movies/features/auth/data/repositories/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository _authRepository;

  RegisterCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(RegisterInitial());

  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());

    try {
      await _authRepository.register(email: email, password: password);

      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      emit(RegisterError(message: e.message ?? "Registration failed"));
    } catch (e) {
      emit(RegisterError(message: e.toString()));
    }
  }
}
