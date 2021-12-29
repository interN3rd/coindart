import 'package:coindart/constants/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<bool> healthCheck()  async {
  // healthCheck to provide unauthenticated user information about
  // operational status of coinmarketcap api
  const url = 'https:www.google.com';
  final response = await http.get(Uri.parse(url));
  if( response.statusCode == 200 ) {
    return true;
  }
  return false;
}

class Status extends StatelessWidget {

  Status({Key? key}) : super(key: key);

  _signOut() async {

    await _firebaseAuth.signOut();

  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    // check if a user is authenticated
    String authStatus;
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if( firebaseUser != null ) {
      authStatus = AppConstants.loggedIn;
    } else {
      authStatus = AppConstants.loggedOut;
    }

    Future<bool>? apiStatus = healthCheck();

    return Scaffold(

      appBar: AppBar(
        title: const Text( "Status" )
      ),

      body: Container(

        padding: const EdgeInsets.all( 30 ),

        child: Column(

            children:  <Widget> [

            const Text(
                "Here you will find technical information regarding the status of the app, e.g. if you are an authenticated user or the API is functional.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17
                )
            ),
              const Divider(),
              const Text(
                  "Your login status",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17
                  )
              ),
              Text(
                  authStatus,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: ( firebaseUser == null ? Colors.redAccent : Colors.greenAccent ),
                      fontSize: 17
                  )
              ),
              const Divider(),
              const Text(
                  "Operational status of coinmarketcap API",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17
                  )
              ),
              Text(
                  ( apiStatus == true  ? "operational" : "unavailable"),
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: ( apiStatus == true ? Colors.greenAccent : Colors.redAccent ),
                      fontSize: 17
                  )
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
              title: const Text('Imprint'),
              tileColor: Colors.deepPurpleAccent,
              onTap: () {
                Navigator.pushNamed( context, "/imprint" );
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