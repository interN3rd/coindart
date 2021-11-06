import 'package:coindart/constants/app_constants.dart';
import "package:flutter/material.dart";
import '../config/routes/routes.dart';

class Coindart extends StatelessWidget {

  const Coindart( { Key? key } ) : super( key: key );

  @override
  Widget build( BuildContext context ) {

    return MaterialApp(

        title: "Coindart",
        routes: routes,
        theme: ThemeData(

          primaryColor: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.white12,

          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              centerTitle: true
          ),

          textTheme: const TextTheme(
            subtitle1: TextStyle( color: Colors.white ),
            subtitle2: TextStyle( color: Colors.white ),
            bodyText1: TextStyle( color: Colors.white ),
            bodyText2: TextStyle( color: Colors.white ),
          ),
        ),

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
                                    child: const Text( "Login" ),
                                    onPressed:  () {
                                      Navigator.pushNamed( context, "/login" );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                    )
                                ),
                                const SizedBox( width: 50),
                                ElevatedButton(
                                    child: const Text( "Register" ),
                                    onPressed:  () {
                                      Navigator.pushNamed( context, "/register" );
                                    },
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>( Colors.deepPurple ),
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
                                            color: Colors.deepPurple
                                        )
                                    )
                                ),
                                const SizedBox( width: 50),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed( context, "/imprint" );
                                    },
                                    child: const Text(
                                        "Imprint",
                                        style: TextStyle(
                                            color: Colors.deepPurple
                                        )
                                    )
                                )
                              ]
                          )
                        ]
                    )
                )
            )
        )
    );
  }
}