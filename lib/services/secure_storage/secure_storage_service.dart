import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login/services/secure_storage/secure_storage_item.dart';

class SecureStorageService {
  static final SecureStorageService instance = SecureStorageService();
  final _secureStorage = const FlutterSecureStorage();

  Future writeData(StorageItem item) async {
    await _secureStorage.write(key: item.key, value: item.value, aOptions: _getAndroidOptions());
  }

  Future<String?> readData(String key) async {
    String? readData = await _secureStorage.read(key: key, aOptions: _getAndroidOptions());
    return readData;
  }

  Future deleteData(String key) async {
    await _secureStorage.delete(key: key, aOptions: _getAndroidOptions());
  }

  AndroidOptions _getAndroidOptions() {
    return const AndroidOptions(encryptedSharedPreferences: true);
  }
}