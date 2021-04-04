import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String displayName;
  final String phoneNumber;

  User({
    this.email,
    this.displayName,
    this.phoneNumber
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      email: doc['email'],
      displayName: doc['displayName'],
      phoneNumber: doc['phoneNumber'],
    );
  }
}