import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage _secureStorage;
  static const String _authTokenKey = 'AUTH_TOKEN_KEY';

  AuthLocalDataSourceImpl(this._secureStorage);

  @override
  Future<void> saveToken(String token) async {
    try {
      await _secureStorage.write(key: _authTokenKey, value: token);
    } catch (e) {
      throw CacheException('Gagal menyimpan token ke local storage');
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return await _secureStorage.read(key: _authTokenKey);
    } catch (e) {
      throw CacheException('Gagal membaca token dari local storage');
    }
  }

  @override
  Future<void> clearToken() async {
    try {
      await _secureStorage.delete(key: _authTokenKey);
    } catch (e) {
      throw CacheException('Gagal menghapus token dari local storage');
    }
  }
}
