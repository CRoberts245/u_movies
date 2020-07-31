import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:u_movies/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

import 'package:u_movies/user_movies.dart';

class editMovie extends StatefulWidget{
  final String mystring;
  editMovie({this.mystring});
  @override
  _editMovieState createState() => _editMovieState(mystring: mystring);
}
class _editMovieState extends State<editMovie>{
  final String mystring;
  _editMovieState({this.mystring});

  var ratingController = TextEditingController();
  var reviewController = TextEditingController();
  var imageController = TextEditingController();
  final maxLines = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SingleChildScrollView(

        child:Column(
          children: <Widget>[
            AppBar(
              title:  Text(
                "Edit Movie",
                style:
                TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 35,
                  foreground: Paint()
                    ..style = PaintingStyle.fill
                    ..strokeWidth = 3
                    ..color = Colors.black,
                ),
                textAlign: TextAlign.center,
              ),

            ),
            Container(

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end:  Alignment(1, 0.0),
                  colors: [Colors.red, Colors.white,Colors.white,Colors.red],
                  tileMode: TileMode.repeated,
                ),
                border: Border.all(
                  color: Colors.black,
                  width: 6,
                ),

              ),
              child: Text("    "+mystring+"       ",
                textAlign: TextAlign.center,
                style:
                TextStyle(
                  fontSize: 35,
                  color: Colors.black,
                ),
              ),
            ),
            TextField(
              controller: ratingController,
              obscureText: false,
              decoration: InputDecoration(border: OutlineInputBorder(),
                labelText: 'Rating(1-5)',
              ),
            ),
            TextField(
              controller: imageController,
              obscureText: false,
              decoration: InputDecoration(border: OutlineInputBorder(),
                labelText: 'Image-URL',
              ),
            ),
            Container(
              height: maxLines * 15.0,
              child: TextField(
                controller: reviewController,
                obscureText: false,
                maxLines: maxLines,
                decoration: InputDecoration(
                  hintText: "Personal Review",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  child: Text('Add'),
                  onPressed:()async {
                    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
                    FirebaseDatabase.instance.reference().child("Users/Names/"+user.uid+"/"+mystring).set(
                        {
                          "rating" : ratingController.text,
                          "review" : reviewController.text,
                          "image" : imageController.text,
                          "name" : mystring,

                        }
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder:(context) => userMovies()),);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}