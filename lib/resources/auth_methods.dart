import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:crypt/crypt.dart';

import 'storage_methods.dart';
import '../models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    return model.User.fromSnapshot(snapshot);
  }

  //Sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List profilePicture,
  }) async {
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          profilePicture != null) {
        // String salt = const Uuid().v4();
        // final hash =
        //     Crypt.sha256(password, rounds: 10000, salt: salt).toString();

        // Register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: /*hash*/ password,
        );

        String profilePictureUrl = await StorageMethods().uploadImageToStorage(
          'profilePictures',
          profilePicture,
          false,
        );

        model.User user = model.User(
          email: email,
          username: username,
          uid: cred.user!.uid,
          bio: bio,
          photoUrl: profilePictureUrl,
          followers: [],
          following: [],
        );

        // Add user to db
        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );

        return 'User added successfully';
      }
    } catch (e) {
      return e.toString();
    }

    return 'Something went wrong';
  }

  // Login username
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return 'Please enter your email and password';
    }

    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Login successful';
    } catch (e) {
      return e.toString();
    }
  }
}
