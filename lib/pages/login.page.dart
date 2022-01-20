import 'package:agenda_digital/pages/login_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'alerta.dart';
import 'home.page.dart';

class LoginPage extends StatelessWidget {
  final _ctrlLogin = TextEditingController();
  final _ctrlSenha = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 128,
              height: 128,
              child: Image.asset("assets/imagens/abs.png"),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  alert(context, "Login Inválido");
                }
                return null;
                ;
              },
              controller: _ctrlLogin,
              onChanged: (text) {
                username = text;
              },
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Usuário",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  alert(context, "Login Inválido");
                }
                return null;
                ;
              },
              controller: _ctrlSenha,
              onChanged: (text) {
                password = text;
              },
              autofocus: true,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              height: 40,
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text(
                  "Esqueceu a senha?",
                  textAlign: TextAlign.right,
                ),
                onPressed: () {},
              ),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.login),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.teal, width: 2.0),
                ),
              )),
              label: Text(
                'Entrar',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () async {
                var usuario = await LoginApi.login(username, password);

                if (usuario != null) {
                  print('correto');

                  Navigator.of(context).pushReplacementNamed('/home');
                } else {
                  alert(context, "Login Inválido");
                  print('imprimindo usuario else $usuario');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
