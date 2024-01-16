import 'package:envira_ultraman/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  void dispose() {

    super.dispose();
  }

  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _phonenumbercontroller = TextEditingController();


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
                controller: _usernamecontroller,
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
                  hintText: 'ex: Joko',
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
                  hintText: 'ex: Susanto',
                  labelText: 'Nama Belakang',
                ),
                onChanged: (String value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              TextField(
                controller: _phonenumbercontroller,
                decoration: const InputDecoration(
                  hintText: 'ex: 0812345678987',
                  labelText: 'Nomor Telepon',
                ),
                onChanged: (String value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              TextField(
                controller: _emailcontroller,
                decoration: const InputDecoration(
                  hintText: 'ex: wololoyoman123@gmail.com',
                  labelText: 'E-mail',
                ),
                onChanged: (String value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              TextField(
                controller: _passwordcontroller,
                decoration: const InputDecoration(
                  hintText: 'ex: 12345678',
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
                child: const Text('Buat Akun'),
                onPressed: (){
                 FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailcontroller.text, password: _passwordcontroller.text).then((value){
                   Navigator.push(context, MaterialPageRoute(builder: (context){
                     return mulai();
                 }));

                  });
                },),
            ],
          )
      ),
    );
  }

    

  }
