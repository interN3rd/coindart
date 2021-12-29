import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";

class Contact extends StatelessWidget {

  /// the _formKey allows to view, modify and process form data and its state
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  _signOut() async {
    await _firebaseAuth.signOut();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build( BuildContext context ) {

    User? firebaseUser = FirebaseAuth.instance.currentUser;

    return Scaffold(

      appBar: AppBar(

          title: const Text( "CoinDart - Contact")
      ),

      body: Container(
        padding: const EdgeInsets.all(30),
          child: Column(
              children: <Widget> [
                FormBuilder(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: <Widget>[
                      FormBuilderTextField(
                        name: "name",
                        decoration:
                        const InputDecoration(
                          labelText:"Please enter your name.",
                          labelStyle: TextStyle( color: Colors.grey),
                        ),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                /// tapping the button "Reset form" does two things:
                                _formKey.currentState!.reset();
                                /// deletes all input
                                FocusScope.of( context ).unfocus();
                                /// makes the user's keyboard disappear
                              },
                              child: const Text( "Reset form"),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>( Colors.deepPurple ),
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              )
                          ),
                          const SizedBox( width: 50),
                          ElevatedButton(
                              onPressed: () {},
                              child: const Text( "Submit"),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>( Colors.deepPurple ),
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
      ]
    )
    ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Home'),
              tileColor: Colors.deepPurpleAccent,
              onTap: () {
                Navigator.pushNamed( context, "/" );
              },
            ),
            const Divider(),
            ListTile(
              title: ( firebaseUser == null ? const Text('Login') : const Text('Logout') ),
              tileColor: Colors.deepPurpleAccent,
              onTap: () async {
                firebaseUser == null ? Navigator.pushNamed( context, "/login" ) : await _signOut();
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Imprint'),
              tileColor: Colors.deepPurpleAccent,
              onTap: () {
                Navigator.pushNamed( context, "/imprint" );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Status'),
              tileColor: Colors.deepPurpleAccent,
              onTap: () {
                Navigator.pushNamed( context, "/status" );
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('close menu'),
              tileColor: Colors.deepPurple,
              onTap: () {
                Navigator.pop( context );
              },
            ),
          ],
        ),
      ),
    );
  }
}