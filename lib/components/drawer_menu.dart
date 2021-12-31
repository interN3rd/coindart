import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {

  DrawerMenu({Key? key}) : super(key: key);

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  _signOut() async {

    await _firebaseAuth.signOut();

  }

  @override
  Widget build( BuildContext context ) {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    return Drawer(

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
            leading: const Icon(
              Icons.home_filled,
              color: Colors.white,
            ),
            title: const Text('Home'),
            tileColor: Colors.deepPurpleAccent,
            onTap: () {
              Navigator.pushNamed( context, "/" );
              },
          ),
          firebaseUser == null ? const Visibility(
            child: Text("invisible"),
            visible: false,
          ) : ListTile(
            leading: const Icon(
              Icons.list_alt,
              color: Colors.white,
            ),
            title: const Text('List of coins'),
            tileColor: Colors.deepPurpleAccent,
            onTap: () async {
              Navigator.pushNamed( context, "/coinlist" );
            },
          ),
          ListTile(
            leading: Icon(
              ( firebaseUser == null ? Icons.login : Icons.logout),
              color: Colors.white,
            ),
            title: ( firebaseUser == null ? const Text('Login') : const Text('Logout') ),
            tileColor: Colors.deepPurpleAccent,
            onTap: () async {
              firebaseUser == null ? Navigator.pushNamed( context, "/login" ) : await _signOut();
              },
          ),
            ListTile(
              leading: const Icon(
                Icons.contact_mail,
                color: Colors.white,
              ),
              title: const Text('Contact'),
              tileColor: Colors.deepPurpleAccent,
              onTap: () {
                Navigator.pushNamed( context, "/contact" );
              },
            ),
          ListTile(
            leading: const Icon(
              Icons.business,
              color: Colors.white,
            ),
            title: const Text('Imprint'),
            tileColor: Colors.deepPurpleAccent,
            onTap: () {
              Navigator.pushNamed( context, "/imprint" );
              },
          ),
          ListTile(
            leading: const Icon(
              Icons.cloud_done,
              color: Colors.white,
            ),
            title: const Text('Status'),
            tileColor: Colors.deepPurpleAccent,
            onTap: () {
              Navigator.pushNamed( context, "/status" );
              },
          ),
          ListTile(
            leading: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            tileColor: Colors.deepPurple,
            onTap: () {
              Navigator.pop( context );
              },
          ),
        ],
      ),
    );
  }
}