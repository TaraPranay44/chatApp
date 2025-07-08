// core/storage/secure_storage.dart
import 'package:chatapp/core/constants/db_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;

  const SecureStorageService(this._storage);

  Future<void> storeToken(String token) async {
    await _storage.write(key: DbConstants.tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: DbConstants.tokenKey);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: DbConstants.tokenKey);
  }

  Future<void> storeUserData(String userData) async {
    await _storage.write(key: DbConstants.userDataKey, value: userData);
  }

  Future<String?> getUserData() async {
    return await _storage.read(key: DbConstants.userDataKey);
  }

  Future<void> deleteUserData() async {
    await _storage.delete(key: DbConstants.userDataKey);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}

final secureStorageProvider = Provider<SecureStorageService>((ref) {
  const storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    // iOptions: IOSOptions(
    //   accessibility: IOSAccessibility.first_unlock_this_device,
    // ),
  );
  return const SecureStorageService(storage);
});
