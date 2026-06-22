import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/dto/entities/cache_entity.dart';
import '../../domain/providers/cache_provider.dart';

class MemoryCacheProvider extends CacheProvider {
  factory MemoryCacheProvider() => _instance ??= MemoryCacheProvider._();

  MemoryCacheProvider._();

  static MemoryCacheProvider? _instance;

  final Map<String, CacheEntity> cacheMap = {};

  @override
  Future<CacheEntity?> get(String key) async {
    return cacheMap[key];
  }

  @override
  Future<void> put(CacheEntity data) async {
    cacheMap[data.id] = data;
  }
}
