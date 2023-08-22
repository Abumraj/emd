import 'package:local_auth/local_auth.dart';
import 'package:uniapp/dbHelper/constant.dart';

class FingerprintManager {
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<bool> authenticate() async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      if (!isAvailable) {
        throw Exception(
            'Fingerprint authentication is not available on this device.');
      }

      final isFingerprintEnabled = await Constants.isFingerprintEnabled();
      if (!isFingerprintEnabled) {
        throw Exception('Fingerprint authentication is currently disabled.');
      }

      final didAuthenticate = await _localAuth.authenticate(
        localizedReason: 'Confirm yuor fingerprint',
        options: AuthenticationOptions(
            useErrorDialogs: true, stickyAuth: true, biometricOnly: true),
      );
      // if (didAuthenticate) {
      //   // Fingerprint authentication successful, proceed with app functionality
      //   // You can navigate to another screen or perform any action here
      //   print('Fingerprint authentication successful');
      // } else {
      //   // Fingerprint authentication failed or was canceled by the user
      //   return didAuthenticate;
      // }

      return didAuthenticate;
    } catch (e) {
      print('Fingerprint authentication error: $e');
      return false;
    }
  }
}
