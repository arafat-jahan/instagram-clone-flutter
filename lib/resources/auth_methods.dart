import 'dart:typed_data'; // এই লাইন যোগ করো
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  // signup user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
   // required Uint8List file,
  })async {
    String res = "Some error occure";
    try{
      if(email.isNotEmpty  ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ){
       //register the user
       UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
       print(cred.user!.uid);
       await _firestore.collection('collectionPath').doc(cred.user!.uid).set({
        'username' : username,
         'uid':cred.user!.uid,
         'email' : email,
         'bio': bio,
         'followers' :[],
         'following' : []
       });
       res = "success";
       // add user to our database
      }

    }catch(err){
      res = err.toString();

    }
    // function body এখান থেকে শুরু হবে
    return res;
  }

}
