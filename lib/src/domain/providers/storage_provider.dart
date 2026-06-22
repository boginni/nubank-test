enum StorageEnum { shortenUrl }

abstract interface class StorageProvider {
  const StorageProvider();

  Future<void> save({
    required StorageEnum key,
    required Object? data,
  });

  Future<Object?> get(StorageEnum key);

  Future<void> clear(StorageEnum key);

  Future<void> clearAll();

  Future<Object?> getDynamicKey(String key);

  Future<void> saveDynamicKey({
    required Object data,
    required String key,
  });
}
