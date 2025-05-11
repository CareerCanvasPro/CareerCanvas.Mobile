import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenInfo {
  static late String token;
  static late String username;
  static late String type;
  static late DateTime expiresAt;
  static late SharedPreferences prefs;
  static late FlutterSecureStorage secureStorage;
  static late bool careerTutorialViewDone;

  static final TokenInfo _instance = TokenInfo._internal();
  TokenInfo._internal();

  factory TokenInfo() {
    return _instance;
  }
  static TokenInfo get instance => _instance;

  static Future init() async {
    secureStorage = FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      ),
    );
    prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    int expiry = prefs.getInt('expiresAt') ?? 0;
    expiresAt = DateTime.fromMillisecondsSinceEpoch(expiry);
    username = prefs.getString('username') ?? '';
    type = prefs.getString('type') ?? '';
    careerTutorialViewDone = prefs.getBool('careerTutorialViewDone') ?? false;
  }

  static Future setToken(
    String token,
    String username,
    String type,
    DateTime expiresAt,
  ) async {
    TokenInfo.token = token;
    TokenInfo.username = username;
    TokenInfo.type = type;
    TokenInfo.expiresAt = expiresAt;
    await prefs.setString('token', token);
    await prefs.setString('username', username);
    await prefs.setString('type', type);
    await prefs.setInt('expiresAt', expiresAt.millisecondsSinceEpoch);
  }

  static void careerTutorialViewDoneNow() {
    careerTutorialViewDone = true;
    prefs.setBool('careerTutorialViewDone', true);
  }

  static Future<void> clear() async {
    TokenInfo.token = '';
    TokenInfo.username = '';
    TokenInfo.type = '';
    TokenInfo.expiresAt = DateTime.now();
    TokenInfo.careerTutorialViewDone = false;
    await prefs.clear();
  }

  static bool isloggedInUser() {
    return token.isNotEmpty && expiresAt.isAfter(DateTime.now());
  }
}
