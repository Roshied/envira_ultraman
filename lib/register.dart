import 'package:flutter/material.dart';
import 'package:envira_ultraman/mulai.dart';

String _name = '';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
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
                  "BUAT AKUN",
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
                  labelText: 'Nama depan',
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
                  labelText: 'Nama Belakang',
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
                  labelText: 'Nomor Telepon',
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
                  labelText: 'E-mail',
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
                  labelText: 'Buat Kata Sandi',
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
                    return mulai();
                  }));
                },),
            ],
          )
      ),
    );
  }
}