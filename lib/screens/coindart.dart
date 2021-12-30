import 'package:coindart/components/drawer_menu.dart';
import 'package:coindart/config/themes/coindart_theme.dart';
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:coindart/constants/app_constants.dart';
import '../config/routes/routes.dart';

class Coindart extends StatefulWidget {

  const Coindart({Key? key}) : super(key: key);

  @override
  _CoindartState createState() => _CoindartState();
}

class _CoindartState extends State<Coindart> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  _signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Widget build( BuildContext context ) {

    return MaterialApp(

        title: "Coindart",
        routes: routes,
        theme: CoindartTheme.defaultScheme,

        home: Builder(
            builder: (context) => Scaffold(
                appBar: AppBar(
                    title: const Text( AppConstants.appTitle )
                ),
                body: Container(
                    padding: const EdgeInsets.all( 30 ),
                    child: Column(
                        children:  <Widget> [
                          const Text(
                              AppConstants.welcomeMessage,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17
                              )
                          ),
                          const Divider(),
                          const Text(
                              AppConstants.loginPrompt,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17
                              )
                          ),
                          const Divider(),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget> [
                                ElevatedButton(
                                    child: const Text( "Register" ),
                                    onPressed:  () {
                                      Navigator.pushNamed( context, "/register" );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                    )
                                ),
                                const SizedBox( width: 50),
                                ElevatedButton(
                                    child: const Text( "Login" ),
                                    onPressed:  () {
                                      Navigator.pushNamed( context, "/login" );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>( Colors.deepPurple ),
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                    )
                                ),
                                const SizedBox( width: 50 ),
                                ElevatedButton(
                                  child: const Text( "Logout" ),
                                  onPressed: () async {
                                    await _signOut();
                                    if( _firebaseAuth.currentUser == null ) {
                                      Navigator.pushNamed( context, "/login" );
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                  )
                                )
                              ]
                          ),
                          const Spacer(),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget> [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed( context, "/contact" );
                                    },
                                    child: const Text(
                                        "Contact",
                                        style: TextStyle(
                                            color: Colors.deepPurpleAccent
                                        )
                                    )
                                ),
                                const SizedBox( width: 30 ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed( context, "/imprint" );
                                    },
                                    child: const Text(
                                        "Imprint",
                                        style: TextStyle(
                                            color: Colors.deepPurpleAccent
                                        )
                                    )
                                ),
                                const SizedBox( width: 30 ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed( context, "/status" );
                                  },
                                  child: const Text(
                                    "Status",
                                    style: TextStyle(
                                      color: Colors.grey
                                    ),
                                  ),
                                ),
                              ],
                          ),
                        ],
                    ),
                ),
              drawer: DrawerMenu(),
            ),
        ),
    );
  }
}