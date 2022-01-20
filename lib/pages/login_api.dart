import 'dart:convert';
import 'package:agenda_digital/pages/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginApi {
  static Future<Usuario> login(String username, String password) async {
    var url = Uri.parse(
        'https://painelapi.alfaebetosolucoes.org.br/api/v1/Autentication/authenticate');

    var header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    Map params = {
      "username": username,
      "password": password,
    };

    var usuario;

    var prefs = await SharedPreferences.getInstance();

    var _body = json.encode(params);

    print("json enviado : $_body");

    var response = await http.post(url, headers: header, body: _body);

    Map mapResponse = json.decode(response.body)["registers"];

    var token = mapResponse['token'];

    if (response.statusCode == 200) {
      usuario = Usuario.fromJson(json.decode(response.body));
      prefs.setString('token', token);
    } else {
      usuario = null;
    }
    return usuario;
  }
}
