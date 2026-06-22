abstract interface class DeviceRuntimeRepository {
  Future<void> copyToClipboard(String text);

  Future<String?> getClipboardData();

  bool isAndroid();

  bool isIOS();

  Future<int?> getAndroidSdkInt();

  Future<String> getDeviceUuid();
}
