import 'dart:convert';
import 'dart:ffi';

import 'package:agenda_digital/pages/aluno.dart';
import 'package:agenda_digital/pages/alunos_api.dart';
import 'package:agenda_digital/pages/aulas.dart';
import 'package:agenda_digital/pages/aulas_api.dart';
import 'package:agenda_digital/pages/turmas.dart';
import 'package:agenda_digital/pages/turmas_api.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TurmasSelect();
  }
}

class _TurmasSelect extends State<HomePage> {
  List<Aluno> selectedAlunos = [];

  var _selectedTurmaValue;

  _listTurmas() {
    Future<List<Turma>> turmas = TurmasApi.getTurmas();
    return FutureBuilder(
      future: turmas,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Text("Erro ao acessar os dados");
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        Object? turmas = snapshot.data;

        return snapshot.hasData
            ? Container(
                child: DropdownButton<String>(
                  hint: Text(_selectedTurmaValue ?? "Selecione"),
                  items: snapshot.data.map<DropdownMenuItem<String>>((item) {
                    return DropdownMenuItem<String>(
                      value: item.id.toString(),
                      child: Text(item.name.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedTurmaValue = value!;
                      print(value);
                    });
                  },
                ),
              )
            : Container(
                child: const Center(
                  child: const Text('Carregando...'),
                ),
              );
      },
    );
  }

  _listAulas() {
    Future<List<Aula>> aulas = AulasApi.getAulas(_selectedTurmaValue);
    return FutureBuilder(
      future: aulas,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Text("Erro ao acessar os dados");
        }
        if (!snapshot.hasData) {
          return const Center(child: const CircularProgressIndicator());
        }

        Object? aulas = snapshot.data;

        return snapshot.hasData
            ? Container(
                child: DropdownButton<String>(
                  hint: Text(_selectedAulaValue ?? "Selecione"),
                  items: snapshot.data.map<DropdownMenuItem<String>>((item) {
                    return DropdownMenuItem<String>(
                      value: item.id.toString(),
                      child: Text(item.description.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedAulaValue = value!;
                      print(value);
                    });
                  },
                ),
              )
            : Container(
                child: const Center(
                  child: const Text('Carregando...'),
                ),
              );
      },
    );
  }

  _listAlunos() {
    Future<List<Aluno>> alunosApi =
        AlunosApi.getAlunos(_selectedTurmaValue, _selectedAulaValue);

    return FutureBuilder(
      future: alunosApi,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Erro ao acessar dados"));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        List? alunosApi = snapshot.data;

        return _listView(alunosApi);
      },
    );
  }

  _listView(alunosApi) {
    return Expanded(
      child: Scrollbar(
        child: ListView.builder(
            itemCount: alunosApi.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  alunosApi[index].student,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
                trailing: alunosApi[index].studentPresent!
                    ? Icon(
                        Icons.check_circle,
                        color: Colors.green[700],
                      )
                    : const Icon(
                        Icons.check_circle_outline,
                        color: Colors.grey,
                      ),
                onTap: () {
                  setState(() {
                    alunosApi[index].studentPresent =
                        !alunosApi[index].studentPresent;
                    if (alunosApi[index].studentPresent == true) {
                      selectedAlunos.add(Aluno(
                          studentId: alunosApi[index].studentId!,
                          student: alunosApi[index].student!,
                          studentPresent: alunosApi[index].studentPresent!));
                    } else if (alunosApi[index].studentPresent == false) {
                      selectedAlunos.removeWhere((element) =>
                          element.studentPresent ==
                          alunosApi[index].studentPresent);
                    }
                  });
                },
              );
            }),
      ),
    );
  }

  Color _iconColor = Colors.black;

  var _selectedAulaValue;

  var _currentTurmaSelected = 'Turma 01';

  var _aulas = ["Aula 01", 'Aula 02'];
  var _currentAulaSelected = 'Aula 01';

  String formattedDateTime() {
    DateTime now = new DateTime.now();
    return now.day.toString() +
        " " +
        now.month.toString() +
        " " +
        now.year.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Lista de Presença - ${DateTime.now().toString().substring(0, 10)}'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                "Turma (*)",
                style: const TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),

              const SizedBox(
                height: 5,
              ),
              //Inicio Combo de turma
              _listTurmas(),

              const SizedBox(
                height: 5.0,
              ),
              //Inicio Combo de Aula
              const Text(
                "Aula (*)",
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5.0,
              ),
              //Inicio Combo de Aula

              _listAulas(),

              const SizedBox(
                height: 5.0,
              ),
              //inicio Apresentação

              const Center(
                child: Text('Marque os alunos presentes:',
                    style: TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center),
              ),

              const SizedBox(
                height: 5.0,
              ),

              //Inicio apresentação alunos
              _listAlunos(),
              selectedAlunos.length > 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          color: Colors.green[700],
                          child: Text(
                            "Salve (${selectedAlunos.length})",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () {
                            print("Alunos Presentes: ${selectedAlunos.length}");
                          },
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void _onDropDownTurmaSelected(String newTurmaSelected) {
    setState(() {
      this._currentTurmaSelected = newTurmaSelected;
    });
  }

  void _onDropDownAulaSelected(String newAulaSelected) {
    setState(() {
      this._currentAulaSelected = newAulaSelected;
    });
  }
}
