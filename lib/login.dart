import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  @override
  initState() {
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 5) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:Container(
      child: Center(
        child:SingleChildScrollView(
          child: Form(
            key: _loginFormKey,
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                      child:Text('LOGIN',style: TextStyle(color: Colors.black45,fontSize: 20,fontWeight: FontWeight.bold),)
                  ),
                ),
                Container(
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    margin: EdgeInsets.fromLTRB(20, 0, 20,0),
                    child: Container(
                      color: Colors.grey[100],
                      padding: EdgeInsets.all(5),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "E-mail ID",
                              hintStyle: TextStyle(color: Colors.grey[450])
                          ),
                          controller: emailInputController,
                          keyboardType: TextInputType.emailAddress,
                          validator: emailValidator,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0,0),
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    margin: EdgeInsets.fromLTRB(20, 10, 20,0),
                    child: Container(
                      color: Colors.grey[100],
                      padding: EdgeInsets.all(5),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey[450])
                          ),
                          controller: pwdInputController,
                          obscureText: true,
                          validator: pwdValidator,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 30,20, 0),
                  child: SizedBox(
                    height: 60,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)
                      ),
                      color: Colors.lightBlue,
                      onPressed: () {
                        if (_loginFormKey.currentState.validate()) {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                              email: emailInputController.text,
                              password: pwdInputController.text)
                              .then((currentUser) => Firestore.instance
                              .collection("vendor")
                              .document(currentUser.user.uid)
                              .get()
                              .then((DocumentSnapshot result) =>
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home(
                                        // uid: currentUser.user.uid,
                                      ))))
                              .catchError((err) => print(err)))
                              .catchError((err) => print(err));
                        }
                      },
                      child: Center(child:Text('Login',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0,0, 0, 5),
                        child: Center(child: Text("Don't  have an account?",
                            style:TextStyle(color: Colors.black,fontSize: 15)
                        )
                        ),
                      ),
                      GestureDetector(
                          onTap: (){
                          },
                          child: Text("Create Account",
                            style: TextStyle(fontWeight: FontWeight.bold,
                                color: Colors.lightBlue,
                              fontSize: 15,
                              decoration: TextDecoration.underline,),
                          )
                      )

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
     )
    );
  }
}
