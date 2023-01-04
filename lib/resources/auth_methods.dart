import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser(
      {required String email,
      required String userName,
      required String password,
      required String bio,
      //required Uint8List file
      }) async {
    String res = "Some Error occured";
    try {
      if (email.isNotEmpty ||
          userName.isNotEmpty ||
          password.isNotEmpty ||
          bio.isNotEmpty
          // ||file != null
      ) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        //add user to our firestore database
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': userName,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'followings': [],
        });

        print(cred.user!.uid);
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
