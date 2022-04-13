import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:crypt/crypt.dart';

import 'storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List profilePicture,
  }) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          profilePicture != null) {
        String salt = const Uuid().v4();

        final hash =
            Crypt.sha256(password, rounds: 10000, salt: salt).toString();

        // Register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: hash);

        String profilePictureUrl = await StorageMethods()
            .uploadImageToStorage('profilePictures', profilePicture, false);

        // Add user to db
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'salt': salt,
          'bio': bio,
          'followers': [],
          'following': [],
          'profilePictureUrl': profilePictureUrl,
        });

        res = 'Success';
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
