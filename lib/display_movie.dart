import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:u_movies/add_movie.dart';
import 'package:u_movies/display_movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:u_movies/edit_movie.dart';
import 'package:u_movies/login_page.dart';

class displayMovie extends StatefulWidget {
  final String mystring;
  displayMovie({this.mystring});
  @override
  _displayMovieState createState() => _displayMovieState(mystring: mystring);
}
class _displayMovieState extends State<displayMovie>{

  final String mystring;
  var name;
  String rating;
  var review;
  String image;

  var reptileStats= [];

  _displayMovieState({this.mystring}){
    FirebaseAuth.instance.currentUser().then((user){
      FirebaseDatabase.instance.reference().child("Users/Names/"+user.uid+"/"+mystring).once().then((datasnapshot){

        setState((){
          image =  datasnapshot.value["image"];
          name =  datasnapshot.value["name"];
          rating = datasnapshot.value["rating"];
          review = datasnapshot.value["review"];
        });
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        ListView(
          children: <Widget>[
            Container(

              child:Image(
                image: NetworkImage(image),
                fit: BoxFit.cover,

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
              child: Text("    "+mystring+"   ",
                textAlign: TextAlign.center,
                style:
                TextStyle(
                  fontSize: 35,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              height: 45,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 4.0, color: Colors.black),),),
              margin: EdgeInsets.only(top: 5,bottom:5),
              child: Text("Rating: "+rating,
                style: TextStyle(fontSize: 24),),
            ),
            Container(
              height: 100,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 4.0, color: Colors.black),),),
              margin: EdgeInsets.only(top: 5,bottom:5),
              child: Flexible(
                    child:Text(review,
                          style: TextStyle(fontSize: 24),),
                          ),
              ),
            RaisedButton(
              child: Text('Edit'),
              onPressed:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder:(context) => editMovie(mystring: name)),
                );
              },
            ),




          ],


        )
    );
  }
}