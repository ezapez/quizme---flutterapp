
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizme/quizmaker/quizMaker.dart';
import 'package:quizme/utils/fire_Auth.dart';



class Body extends StatefulWidget{
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();
  final _emailTextController  =  TextEditingController();
  final _passwordTextController  =  TextEditingController();

  void dispose(){
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context){
    CollectionReference user = FirebaseFirestore.instance.collection('user');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height/6),
          child:Container(
            width: 300,
            child: _formLogin(context),
          ),
        ),
      ],
    );
  }

  Widget _formLogin(BuildContext context){
    return Form(

        key: _formkey,

      child: Column(

        children: [
        Container(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome to ',
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold,),
              ),
              SizedBox(height: 10,),
              Text(
                'Teacher Portal',
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
            ],
          ),
          width: 300,
        ),

        SizedBox(height: 75,),
        // user enter email or username


        TextFormField(
          decoration: InputDecoration(hintText: 'Enter email',
            fillColor: Colors.blueGrey[50],
            filled: true,
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50
              ),
              borderRadius: BorderRadius.circular(15),
            ),

            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),),

          ),


          validator: (val) => val!.isNotEmpty ? null: "Please enter a Email address",
          controller: _emailTextController,
        ),
        SizedBox(height: 30,
        ),
        // user enters password



        TextFormField(
          obscureText: true,
          decoration: InputDecoration(hintText: 'Password',
            // this is where user will be redreacted to make new password
            // counterText: 'Forgot password?',
            suffixIcon: Icon(Icons.visibility_off_outlined, color:Colors.grey ,),
            fillColor: Colors.blueGrey[50],
            filled: true,
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50
              ),
              borderRadius: BorderRadius.circular(15),
            ),

            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey.shade50),
              borderRadius: BorderRadius.circular(15),),),

            validator: (val) => val!.length < 6 ? "Password needs to be more than 6 characters": null,
            controller: _passwordTextController,







        ),
        SizedBox(height: 40,),
        Container(
          decoration:BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.shade100,
                spreadRadius: 10,
                blurRadius: 20,

              )
            ],
          ),
          child: ElevatedButton(
            // sign in button
            child: Container(
              width: double.infinity,
              height: 50,
              child:Center(child: Text("Sign In")),
            ),
            // login button needs to have s function to send user
            // who have signup to be redracted to another page

            onPressed: () async{
              setState(() {
                isLoading = true;
              });
              AuthClass()
                  .signIN(
                  email: _emailTextController.text.trim(),
                  password: _passwordTextController.text.trim())
                  .then((value) {
                if (value == "Welcome") {
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => quiz_maker()),
                          (route) => false);
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(value!)));
                }
              });


              },
            style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
            ),
          ),
        ),
        SizedBox(height: 40,),
        Container(
          decoration:BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.shade100,
                spreadRadius: 10,
                blurRadius: 20,

              )
            ],
          ),
















          // DO NOT MISS WITH THIS CODE ITS FINSHED
          // sign up button
          child: ElevatedButton(
            child: Container(
              width: double.infinity,
              height: 50,
              child:Center(child: Text("Sign up")),
            ),
            onPressed: (){
             //  when clicked on push user to the signup page
             //  use this for the sign in page to redract user to the quizmaker page
             Navigator.of(context).pushNamed("/signupPage");
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
            ),
          ),
        ),

      ],

      ),
    );
  }
}
