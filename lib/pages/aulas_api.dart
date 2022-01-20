import 'dart:convert';

import 'package:agenda_digital/pages/aulas.dart';
import 'package:agenda_digital/pages/turmas.dart';
import 'package:agenda_digital/pages/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AulasApi {
  AulasApi(aulas);

  static Future<List<Aula>> getAulas(String? classId) async {
    var url = Uri.parse(
        "https://painelapi.alfaebetosolucoes.org.br/api/v1/DigitalCalendar/GetClassNumber");

    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('token') ?? "");

    print('token tela Aulas API $token');

    var header = {
      "Content-Type": "application/json",
      "Connection": "keep-alive",
      "Authorization": "Bearer $token"
    };

    var b = int.parse(classId!);

    Map params = {"classId": b};

    var _body = json.encode(params);
    var response = await http.post(url, headers: header, body: _body);

    List<Aula> aulas;
    if (response.statusCode == 200) {
      //List listaResponse = json.decode(response.body);

      Iterable resultado = jsonDecode(response.body)["registers"];

      aulas = List<Aula>.from(resultado.map((model) => Aula.fromJson(model)));
    } else {
      throw Exception;
    }
    return aulas;
  }
}
