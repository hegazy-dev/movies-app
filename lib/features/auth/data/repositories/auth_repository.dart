import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/features/auth/data/data_sources/auth_data_source.dart';

class AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepository({required AuthDataSource authDataSource})
    : _authDataSource = authDataSource;

  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    return await _authDataSource.register(email: email, password: password);
  }
}
