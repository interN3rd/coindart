import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class Imprint extends StatelessWidget {

  Imprint( { Key? key } ) : super( key: key );

  _signOut() async {
    await _firebaseAuth.signOut();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build( BuildContext context ) {

    User? firebaseUser = FirebaseAuth.instance.currentUser;

    return Scaffold(

      appBar: AppBar(

        title: const Text( "Imprint"),
      ),

      body: Container(

        padding: const EdgeInsets.all( 30 ),

        child: Column(

          children: const <Widget> [

            Text(
              "This software project was carefully crafted by Fachhochschule Kiel students Alexander Neumann and Pascal Groß. For legal inquiries please send a letter to",
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17
              ),
            ),

            Divider(),

            Text("CoinDart AG GmbH MfG" "\n"
                "CoinDart Ave No. 1" "\n"
                "12345 CoinDartropolis" "\n"
                "United Darts of Coins" "\n"
                "\n"
                "Our legal team will surely and truthfully shred all received documents.",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17
              ),
            ),
          ],
        ),
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
              title: const Text('Contact'),
              tileColor: Colors.deepPurpleAccent,
              onTap: () {
                Navigator.pushNamed( context, "/contact" );
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