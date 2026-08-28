import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

/// Call `DeviceInfo.init()` once at app launch (in main(), before runApp).
/// After that, any file can just import this and read `DeviceInfo.deviceData`
/// — no regenerating, no async calls needed at the point of use.
class DeviceInfo {
  static const _deviceIdKey = 'device_id';
  static String? _cachedDeviceId;

  /// Generates a device id on first launch and stores it in
  /// SharedPreferences. On every launch after that, it just reads the
  /// stored value — same id forever on this device/install.
  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();

    String? id = prefs.getString(_deviceIdKey);

    if (id == null) {
      id = const Uuid().v4();
      await prefs.setString(_deviceIdKey, id);
    }

    _cachedDeviceId = id;
  }

  /// The cached device id. Throws if `init()` hasn't been called yet —
  /// call it once in main() before runApp() so this is always ready.
  static String get deviceId {
    if (_cachedDeviceId == null) {
      throw StateError(
        'DeviceInfo.init() must be called (in main(), before runApp) '
        'before accessing DeviceInfo.deviceId.',
      );
    }
    return _cachedDeviceId!;
  }

  static String get deviceType {
    if (kIsWeb) return 'WEB';
    if (Platform.isAndroid) return 'ANDROID';
    if (Platform.isIOS) return 'IOS';
    return 'WEB';
  }

  static String get deviceName {
    if (kIsWeb) return 'Chrome on Windows';
    if (Platform.isAndroid) return 'Android Device';
    if (Platform.isIOS) return 'iPhone';
    return 'Chrome on Windows';
  }

  /// Ready-to-use map for the "device" field in any API payload.
  static Map<String, dynamic> get deviceData => {
        "deviceId": deviceId,
        "deviceType": deviceType,
        "deviceName": deviceName,
      };
}