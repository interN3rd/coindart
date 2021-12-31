import 'package:coindart/components/login_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

import '../config/routes/routes.dart';
import 'package:coindart/config/themes/coindart_theme.dart';
import 'package:coindart/constants/app_constants.dart';
import 'package:coindart/components/drawer_menu.dart';
import 'package:coindart/components/footer_menu.dart';

class Coindart extends StatefulWidget {

  const Coindart({Key? key}) : super(key: key);

  @override
  _CoindartState createState() => _CoindartState();

}

class _CoindartState extends State<Coindart> {

  final formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isloading = false;

  @override
  Widget build( BuildContext context ) {

    User? firebaseUser = FirebaseAuth.instance.currentUser;

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
                          firebaseUser == null ? const LoginForm() : const Visibility(
                            child: Text("invisible"),
                            visible: false,
                          ),
                          const Spacer(),
                          const FooterMenu(),
                        ],
                    ),
                ),
              drawer: DrawerMenu(),
            ),
        ),
    );
  }
}