import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:u_movies/login_page.dart';
import 'dart:async';

import 'package:u_movies/user_movies.dart';

class signupPage extends StatefulWidget {
  @override
  _signupPageState createState()=>_signupPageState();
}
class _signupPageState extends State<signupPage>{
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool visibility1 = false;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child:Column(

          children:[



            Image(
              image: NetworkImage('https://townsquare.media/site/721/files/2013/12/Siblings-enjoying-movie-in-theater-Credit-Fuse-78723283.jpg?w=980&q=75'),
              fit: BoxFit.cover,
            ),


            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end:  Alignment(1, 0.0),
                  colors: [Colors.red, Colors.white,Colors.white,Colors.red],
                  tileMode: TileMode.repeated,
                ),
              ),

              child: Column(

                children: [

                  Container(

                    margin: EdgeInsets.only(top:0),
                    decoration: BoxDecoration(

                      border: Border.all(
                        color: Colors.black,
                        width: 20,


                      ),

                    ),
                    child: Text('       Sign Up?          ' ,

                      style:
                      TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 50,
                        foreground: Paint()
                          ..style = PaintingStyle.fill
                          ..strokeWidth = 3
                          ..color = Colors.black,
                      ),
                    ),
                  ),

                ],
              ),
            ),







            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left:35,right:35,top:10,bottom:10),
                  child: TextField(
                    controller: emailController,
                    obscureText: false,
                    decoration: InputDecoration(border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),

                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left:35,right:35,top:10,bottom:10),
                  child: TextField(
                    controller: passwordController,
                    obscureText: false,
                    decoration: InputDecoration(border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Visibility(
                  child: Text('Error, try again'),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: visibility1,
                ),
              ],

            ),


            Container(
              margin: EdgeInsets.only(left:35,right:35,top:20,bottom:5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end:  Alignment(1, 0.0),
                  colors: [Colors.white, Colors.red,Colors.redAccent,Colors.white],
                  tileMode: TileMode.repeated,
                ),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: Text('Back'),
                    onPressed:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder:(context) => loginpage()),
                      );

                    },
                  ),
                  Text('             '),
                  RaisedButton(
                    child: Text('Sign Up!'),
                    onPressed:(){
                      Future<AuthResult> result = FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                      result.then((value){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder:(context) => userMovies()),);
                       });
                      result.catchError((error){
                        setState(() {
                          visibility1 = true;
                        });
                      });
                    },
                  ),

                ],
              ),
            ),
          ],//1st child of Main Login Column
        ),
      ),
    );


  }
}



