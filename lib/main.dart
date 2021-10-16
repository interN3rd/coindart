import 'package:coindart/screens/coindart.dart';
import "package:flutter/material.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {

  // Google reference: https://firebase.flutter.dev/docs/overview#initializing-flutterfire
  // actually working reference: https://github.com/FirebaseExtended/flutterfire/issues/3384
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( Coindart() );

}

class AddUser extends StatelessWidget {
  final String name;

  const AddUser(this.name);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('user');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
        'name': name
      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return TextButton(
      onPressed: addUser,
      child: Text(
        "Add User",
      ),
    );
  }
}
