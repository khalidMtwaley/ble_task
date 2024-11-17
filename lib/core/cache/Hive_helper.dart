
// class HiveHelper {
//   static const String _cacheBox = 'cacheBox';
//   static const String _languageCodeKey = 'language_code';

//   static Future<Box> _getCacheBox() async {
//     return await Hive.openBox(_cacheBox);
//   }

//   // Save Language Code in Hive
//   static Future<void> saveLanguageCode(String languageCode) async {
//     final box = await _getCacheBox();
//     await box.put(_languageCodeKey, languageCode);
//   }

//   static Future<String?> getLanguageCode() async {
//     final box = await _getCacheBox();
//     return box.get(_languageCodeKey) ?? 'en'; // Default to 'en'
//   }

//   static Future<void> clearCache() async {
//     final box = await _getCacheBox();
//     await box.clear();
//   }
// }

// class TokenStorage {
//   static const String _bearerTokenKey = 'token';
//   static final _secureStorage = FlutterSecureStorage();

//   // Securely Save Token using flutter_secure_storage
//   static Future<void> saveBearerToken(String token) async {
//     await _secureStorage.write(key: _bearerTokenKey, value: token);
//   }

//   // Retrieve Token securely
//   static Future<String?> getBearerToken() async {
//     return await _secureStorage.read(key: _bearerTokenKey);
//   }

//   // Delete Token securely
//   static Future<void> deleteBearerToken() async {
//     await _secureStorage.delete(key: _bearerTokenKey);
//   }
// }
