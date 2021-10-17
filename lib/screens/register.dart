import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coindart/constants/app_constants.dart';

class Register extends StatefulWidget {

  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _auth = FirebaseAuth.instance;
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text( "Register"),
      ),

      body: Container(

          padding: const EdgeInsets.all( 30 ),

        child: Column(

          children: <Widget> [

            const Text(
                AppConstants.registerPrompt,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17
                )
            ),

            const SizedBox(height: 20),

            TextFormField(
              keyboardType: TextInputType.text,
              onChanged: ( value ) {
                username = value.toString().trim();
              },
              decoration: const InputDecoration(
                hintText: "Please enter a username",
                hintStyle: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
                prefixIcon: Icon(
                  Icons.emoji_people,
                  color: Colors.white,
                )
              ),
              validator: (value) {
                if( value == null || value.isEmpty) {
                  return "Please enter your username.";
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            TextFormField(
              obscureText: true,
              keyboardType: TextInputType.text,
              onChanged: ( value ) {
                password = value;
              },
              decoration: const InputDecoration(
                  hintText: "Please enter a password",
                  hintStyle: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
                  prefixIcon: Icon(
                    Icons.vpn_key,
                    color: Colors.white,
                  )
              ),
              validator: (value) {
                if( value == null || value.isEmpty) {
                  return "Please enter a password.";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}