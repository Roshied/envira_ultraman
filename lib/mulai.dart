import 'package:flutter/material.dart';
import 'package:envira_ultraman/login.dart';
import 'package:envira_ultraman/register.dart';

class mulai extends StatefulWidget {
  const mulai({super.key});

  @override
  State<mulai> createState() => _mulaiState();
}

class _mulaiState extends State<mulai> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Buat Akun'),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return register();
                }));
              },),
            ElevatedButton(
              child: const Text('Masuk'),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return login();
                }));
              },),
          ],
        )
      ),
    );
  }
}
