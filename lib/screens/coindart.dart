import 'package:coindart/components/greeting_text.dart';
import 'package:coindart/components/invisible_widget.dart';
import 'package:coindart/components/logged_in_text.dart';
import 'package:coindart/components/login_button.dart';
import 'package:coindart/components/register_button.dart';
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

  @override
  void initState() {
    super.initState();
  }

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
                          firebaseUser == null ? const GreetingText() : const LoggedInText(),
                          const Divider(),
                          firebaseUser == null ? const LoginButton() : const InvisibleWidget(),
                          const Divider(),
                          firebaseUser == null ? const RegisterButton() : const InvisibleWidget(),
                          const Spacer(),
                          const FooterMenu(),
                        ],
                    ),
                ),
              drawer: const DrawerMenu(),
            ),
        ),
    );
  }
}