import 'package:shared_preferences/shared_preferences.dart';

class TokenDatasource {
  //add datasource to save token to using shared preferences
  Future<void> saveToken(String token) async {
    //save token to shared preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  //add datasource to get token from shared preferences
  Future<String?> getToken() async {
    //get token from shared preferences
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  //add datasource to remove token from shared preferences
  Future<void> removeToken() async {
    //remove token from shared preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
}
