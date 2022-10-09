

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quizme/signup_page/signup_body.dart';


class signupPage extends StatefulWidget{
  @override
  _signupPageState createState() => _signupPageState();
}

class _signupPageState extends State<signupPage> {

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
        ],
      ),
    );
  }

}






