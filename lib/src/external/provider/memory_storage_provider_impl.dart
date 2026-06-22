import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/providers/storage_provider.dart';

final class MemoryStorageProviderImpl implements StorageProvider {
  factory MemoryStorageProviderImpl() => _instance;

  MemoryStorageProviderImpl._();

  static final MemoryStorageProviderImpl _instance =
      MemoryStorageProviderImpl._();

  @override
  Future<void> save({
    required StorageEnum key,
    required Object? data,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key.name, jsonEncode(data));
  }

  @override
  Future<Object?> get(StorageEnum key) async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(key.name);
    if (data != null) {
      return jsonDecode(data);
    }
    return null;
  }

  @override
  Future<void> clear(StorageEnum key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key.name);
  }

  @override
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    await Future.wait(keys.map(prefs.remove));
  }

  @override
  Future<Object?> getDynamicKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);
    if (data != null) {
      return jsonDecode(data);
    }
    return null;
  }

  @override
  Future<void> saveDynamicKey({
    required Object? data,
    required String key,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(data));
  }
}
