import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:u_movies/add_movie.dart';

import 'package:u_movies/display_movie.dart';

import 'package:u_movies/login_page.dart';
import 'package:flutter/cupertino.dart';


class userMovies extends StatefulWidget{
  @override
  _userMoviesState createState() => _userMoviesState();
}
class _userMoviesState extends State<userMovies> {
  var moviesList = [];

  _userMoviesState() {
    //constructor
    FirebaseAuth.instance.currentUser().then((user) {
      FirebaseDatabase.instance.reference()
          .child("Users/Names/" + user.uid)
          .once()
          .then((datasnapshot) {
        var moviesTmpList = [];
        datasnapshot.value.forEach((k, v) {
          moviesTmpList.add(v);
        });
        moviesList = moviesTmpList;
        setState(() {

        });
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Movies",
          style:
          TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 35,
            foreground: Paint()
              ..style = PaintingStyle.fill
              ..strokeWidth = 3
              ..color = Colors.black,
          ),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => loginpage()),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add new movie entry',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => addMovie()),);
            },
          ),
        ],
      ),
      body:
      ListView.builder(
          itemCount: moviesList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => displayMovie(
                          mystring: '${moviesList[index]["name"]}')));
                },
                title: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 4.0, color: Colors.black),
                      ),
                    ),
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    child:
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                '${moviesList[index]['image']}'),
                            radius: 50,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Text(
                            '${moviesList[index]["name"]}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    )
                )
            );
          }
      ),
    );
  }
}