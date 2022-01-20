import 'dart:convert';

import 'package:agenda_digital/pages/turmas.dart';
import 'package:agenda_digital/pages/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TurmasApi {
  TurmasApi(turmas);

  static Future<List<Turma>> getTurmas() async {
    var url = Uri.parse(
        "https://painelapi.alfaebetosolucoes.org.br/api/v1/Class/SearchForClassRoomByParamList");

    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('token') ?? "");

    print('token login API $token');

    var header = {
      "Content-Type": "application/json",
      "Connection": "keep-alive",
      "Authorization": "Bearer $token"
    };

    Map params = {};

    var _body = json.encode(params);
    var response = await http.post(url, headers: header, body: _body);

    List<Turma> turmas;
    if (response.statusCode == 200) {
      //List listaResponse = json.decode(response.body);

      Iterable resultado = jsonDecode(response.body)["registers"];

      turmas =
          List<Turma>.from(resultado.map((model) => Turma.fromJson(model)));
    } else {
      throw Exception;
    }
    return turmas;
  }
}
