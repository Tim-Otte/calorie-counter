import 'package:device_info_plus/device_info_plus.dart';

extension AndroidDeviceInfoExtension on AndroidDeviceInfo {
  int getMajorVersion() {
    return int.tryParse(version.release.split('.').first) ?? 0;
  }
}
