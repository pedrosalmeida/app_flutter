import 'dart:convert';

import 'package:agenda_digital/pages/aluno.dart';
import 'package:agenda_digital/pages/turmas.dart';
import 'package:agenda_digital/pages/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AlunosApi {
  AlunosApi(alunos);

  static Future<List<Aluno>> getAlunos(
      String? _selectedTurmaValue, String? _selectedAulaValue) async {
    var url = Uri.parse(
        "https://painelapi.alfaebetosolucoes.org.br/api/v1/DigitalCalendar/GetFrequencySimplifiedByClassId");

    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('token') ?? "");

    print('token tela Alunos API $token');

    var header = {
      "Content-Type": "application/json",
      "Connection": "keep-alive",
      "Authorization": "Bearer $token"
    };

    var b = int.parse(_selectedTurmaValue!);

    var c = int.parse(_selectedAulaValue!);

    Map params = {"classId": b, "classNumber": c, "programId": 0};

    var _body = json.encode(params);
    var response = await http.post(url, headers: header, body: _body);

    List<Aluno> alunos;

    if (response.statusCode == 200) {
      //List listaResponse = json.decode(response.body);

      Iterable resultado = jsonDecode(response.body)["registers"];

      alunos =
          List<Aluno>.from(resultado.map((model) => Aluno.fromJson(model)));
    } else {
      throw Exception;
    }

    return alunos;
  }
}
