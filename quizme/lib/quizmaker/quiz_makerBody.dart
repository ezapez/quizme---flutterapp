import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizme/login_page/LoginPage.dart';
import 'package:quizme/utils/fire_Auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class quiz_makerBody extends StatefulWidget {
  @override
  _quiz_makerBodyState createState() => _quiz_makerBodyState();
}

class _quiz_makerBodyState extends State<quiz_makerBody> {
  // this for the true and false buttons
  bool true_Value = false;
  bool fill_Value = false;
  final TextEditingController Quiz1 = new TextEditingController();
  final TextEditingController answer =  new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();










  @override
  Widget build(BuildContext context) {


    return Row(
      key: _scaffoldKey,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
          Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height /6),
            child:Container(
              width: 300,
              child: _quizbody(context),
            ),
          ),
        ],
    );
  }


  Widget _quizbody(BuildContext context) {
    CollectionReference test1 =
      FirebaseFirestore.instance.collection('test1');


    return StreamBuilder<Object>(
      stream: test1.snapshots(),
      // stream: FirebaseFirestore.instance
      // .collection is making the a data set in the cloud

          // .collection('testq')
          // .snapshots(),

      builder: (context, snapshot) {
        return Column(children: [
          Container(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome!',
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold,),
                ),

                SizedBox(height: 100,),

                // this where the form button will go
                /// for now the quiz maker will just save true or false as the set answer
                TextFormField(

                    decoration: InputDecoration(hintText: 'Enter Quiz Question #1',
                    fillColor: Colors.blueGrey[50],
                    filled: true,
                    labelStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.only(left: 30),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade50
                      ),
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade50),
                      borderRadius: BorderRadius.circular(100),),
                  ),

                  // setting string value to  be  send to the database
                  controller: Quiz1,


                ),

                SizedBox(height: 50,),


              /// teachers will choose the type of  question
               Container(
                 child: CheckboxListTile(
                   title: Text("True or false question"),
                   value: true_Value,
                   onChanged:
                       (value) {
                     setState((){
                       fill_Value= false;
                       true_Value= true;
                     });
                   },
                 ),
               ),

                SizedBox(height: 25,),

                Container(
                  child: CheckboxListTile(
                    title: Text("Fill in the bank question"),
                    value: fill_Value,
                    onChanged: (value) {
                      setState((){
                        fill_Value= true;
                        true_Value=false;
                      });
                  },
                  ),
                ),

            /// end of buttons

                SizedBox(height: 50,),

                // TextFormField(
                //   decoration: InputDecoration(hintText: 'Enter answer',
                //     fillColor: Colors.blueGrey[50],
                //     filled: true,
                //     labelStyle: TextStyle(fontSize: 12),
                //     contentPadding: EdgeInsets.only(left: 30),
                //     enabledBorder: OutlineInputBorder(
                //       borderSide: BorderSide(color: Colors.blueGrey.shade50
                //       ),
                //       borderRadius: BorderRadius.circular(1000),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: BorderSide(color: Colors.blueGrey.shade50),
                //       borderRadius: BorderRadius.circular(100),),
                //   ),
                //
                //   // setting string value to  be  send to the database
                //   controller: answer,
                //
                // ),


                SizedBox(height: 50,),


                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.shade100,
                        spreadRadius: 10,
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    child: Container(
                      width: double.infinity,
                      height:50,
                      child: Center(
                        child: Text("Submit"),),
                    ),
                    // button function
                    onPressed: () async{

                      //  this to send data to firebase
                      test1.add({
                        'test':Quiz1.text,
                      });

                    Quiz1.clear();

                    },

                  ),
                ),






                SizedBox(height: 60,),






                SizedBox(height: 100,),
                IconButton(
                   icon: Icon(Icons.exit_to_app),
                  onPressed: () async{
                    AuthClass().signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                            (route) => false);
                  },

                ),

              ],
            ),
              width: 300,
            ),
          ],
        );
      }
    );
  }
}

