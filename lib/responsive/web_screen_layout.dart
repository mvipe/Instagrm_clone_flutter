import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:provider/provider.dart';

import 'package:instagram_clone/models/user.dart' as model;

import '../utils/colors.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  @override
  Widget build(BuildContext context) {
   int  _page=0;

    
   
    return Scaffold(
      body:Center(
        child: Text("user.username"),
      ),
      bottomNavigationBar: CupertinoTabBar(
        
            items:[
              BottomNavigationBarItem(icon: Icon(Icons.home
              ,color: _page==0?primaryColor:secondaryColor,),
              label: '',backgroundColor: primaryColor),

              BottomNavigationBarItem(icon: Icon(Icons.search,color: _page==1?primaryColor:secondaryColor),
              label: '',backgroundColor: primaryColor),

               BottomNavigationBarItem(icon: Icon(Icons.add_circle,color: _page==2?primaryColor:secondaryColor),
              label: '',backgroundColor: primaryColor),

               BottomNavigationBarItem(icon: Icon(Icons.favorite,color: _page==3?primaryColor:secondaryColor),
              label: '',backgroundColor: primaryColor)

              , BottomNavigationBarItem(icon: Icon(Icons.person,color: _page==4?primaryColor:secondaryColor),
              label: '',backgroundColor: primaryColor)
            ]
         ),

      
    );
  }
}