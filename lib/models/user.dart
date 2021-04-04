import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String email;
  final String displayName;
  final String phoneNumber;

  Users({
    this.email,
    this.displayName,
    this.phoneNumber
  });

  factory Users.fromDocument(DocumentSnapshot doc) {
    return Users(
      email: doc['email'],
      displayName: doc['displayName'],
      phoneNumber: doc['phoneNumber'],
    );
  }
}