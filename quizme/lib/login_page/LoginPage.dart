import 'dart:html';

import 'package:flutter/material.dart';
import 'package:quizme/login_page/login_body.dart';




class LoginPage extends StatefulWidget{


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width /8
          ),
          children:[
            Body(),
          ]
      ),
    );
  }
}




