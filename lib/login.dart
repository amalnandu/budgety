import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth.dart';
import 'components/constants.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final auth = Auth();
  var textcon1 = TextEditingController();
  var textcon2 = TextEditingController();
 late var name="";
 late var balance;


/////
  void _saveBalance(int newBalance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('balance', newBalance);
  }

  void _saveName(String newname) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', newname);
  }

  ////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Login"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              height: 200,
              color: Colors.blue,
            ),
            TextField(
              controller: textcon1,
              decoration: const InputDecoration(hintText: 'Enter the name'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: textcon2,
              decoration: const InputDecoration(hintText: 'Enter the amount'),
            ),
            const Text('click to login'),
            ElevatedButton(
              onPressed: () {
                _saveName(textcon1.text);
                _saveBalance(int.parse(textcon2.text.toString()));
                // if(textcon1.text!=null && textcon2.text!=null){
                //
                // }
              },
              child: const Text("Sign in "),
            ),
          ],
        ),
      ),
    );
  }
}
