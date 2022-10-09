import 'package:flutter/material.dart';
import 'package:quizme/quizmaker/quizMaker.dart';
import 'package:quizme/utils/fire_Auth.dart';

import '../login_page/LoginPage.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 6),
          child: Form(
            child: Container(
              width: 300,
              child: _formLogin(context),
            ),
          ),
        ),
      ],
    );
  }

  // buttons for the login into teacher portal
  Widget _formLogin(BuildContext context) {
    // end of this code
    return Form(
      key: _formkey,
      child: Column(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            width: 300,
          ),

          SizedBox(
            height: 75,
          ),

          /// this code needs to work with sign up button
          ///
          // user register email
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter email',
              fillColor: Colors.blueGrey[50],
              filled: true,
              labelStyle: TextStyle(fontSize: 12),
              contentPadding: EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey.shade50),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey.shade50),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            validator: (val) =>
                val!.isNotEmpty ? null : "Please enter a Email address",
            controller: email,
          ),

          SizedBox(
            height: 30,
          ),

          // user register password
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'New Password',
              suffixIcon: Icon(
                Icons.visibility_off_outlined,
                color: Colors.grey,
              ),
              fillColor: Colors.blueGrey[50],
              filled: true,
              labelStyle: TextStyle(fontSize: 12),
              contentPadding: EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey.shade50),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey.shade50),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            validator: (val) => val!.length < 6
                ? "Password needs to be more than 6 characters"
                : null,
            controller: password,
          ),

          /// end of this code

          SizedBox(
            height: 40,
          ),

          /// this  is the sign up button
          Container(
            decoration: BoxDecoration(
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
              // sign up button
              child: Container(
                width: double.infinity,
                height: 50,
                child: Center(child: Text("Sign Up")),
              ),

              // this to submit the info to firebase database
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                AuthClass()
                    .createAccount(
                        email: email.text.trim(),
                        password: password.text.trim())
                    .then((value) {
                  if (value == "Account created") {
                    setState(() {
                      isLoading = false;
                    });
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => quiz_maker()),
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

              // this is the styling of the button
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),

          SizedBox(
            height: 40,
          ),
          Container(
            decoration: BoxDecoration(
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

            /// do not mess with this code its finished

            //  Returns user back to the sign in page
            child: ElevatedButton(
              child: Container(
                width: double.infinity,
                height: 50,
                child: Center(child: Text("Sign In")),
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
