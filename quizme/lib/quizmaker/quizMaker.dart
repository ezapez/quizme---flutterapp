
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizme/quizmaker/quiz_makerBody.dart';


class quiz_maker extends StatefulWidget {
  @override
  _quiz_makerState createState() => _quiz_makerState();
}

class _quiz_makerState extends State<quiz_maker> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:Colors.white,
      body: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width /8
          ),
          children:[
            quiz_makerBody(),
          ]
      ),
    );
  }
}

