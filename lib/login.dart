import 'package:flutter/material.dart';
import 'package:envira_ultraman/map.dart';

String _name = '';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
              ),
              Container(
                margin: const EdgeInsets.only(top:16.0),
                child: const Text(
                  "MASUK",
                      textAlign: TextAlign.center,
                ),
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'ex: Joko Susanto',
                  labelText: 'Nama Pengguna',
                ),
                onChanged: (String value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'ex: Joko Susanto',
                  labelText: 'Kata Sandi',
                ),
                onChanged: (String value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              Container(
                margin: const EdgeInsets.only(top:16.0),
                child: const Text(
                  "Lupa Kata Sandi",
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                  child: const Text('Masuk'),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return Map();
                    }));
                  },),
            ],
          )
      ),
    );
  }
}
