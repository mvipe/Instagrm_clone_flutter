import 'dart:js';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'dart:typed_data';

import 'package:instagram_clone/utils/utils.dart';

import 'package:instagram_clone/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser(
      {required String email,
      required String userName,
      required String password,
      required String bio,
      required Uint8List file
      }) async {
    String res = "Some Error occured";
    try {
      if (email.isNotEmpty ||
          userName.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty
           ||file != null
      ) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        //upload profile image in storage
        String photoUrl=await StorageMethods().uploadImageToFirestore('profilePics', file, false);

        //add user to our firestore database
        model.User user=model.User(
          username: userName,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          followers: [],
          followings: [],
          photoUrl:photoUrl
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());

        print(cred.user!.uid);
        res = "success";
      }}
    // } on FirebaseAuthException catch(err){
    //   if(err.code=='invalid-email'){
    //     res='The Email is invalid formatted';
    //   }else if(err.code=='weak-password'){
    //
    //   }
    // }
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser(
      {required String email,
      required String password,
      }) async {
String res = "Some Error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty
      ) {
       await  _auth.signInWithEmailAndPassword(email: email, password: password);
       res="success";
      }else {
        res="Please enter all the fields";
      }
      }catch(err){
          res=err.toString();
      }

      return res;

}}
