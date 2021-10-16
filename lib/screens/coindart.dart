import "package:flutter/material.dart";

import '../main.dart';
import '../routes.dart';

class Coindart extends StatelessWidget {

  const Coindart( { Key? key } ) : super( key: key );

  @override
  Widget build( BuildContext context ) {

    const appTitle = "CoinDart - Your Next Bull's Eye Trade";
    // used in AppBar

    const welcomeMessage = "Welcome to CoinDart! We provide you every extra bit of information that helps you hitting Bull's Eye with your next trade.";
    // used on our front page

    const loginPrompt = "Please login to your account or register a new one to access the latest crypto charts and your portfolio.";
    // used on our front page

    return MaterialApp(

        title: "Coindart",
        /// routing reference: https://flutter.dev/docs/cookbook/navigation/named-routes
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
            bodyText1: TextStyle( color: Colors.white ),
            subtitle1: TextStyle( color: Colors.white ),
          ),
        ),

        home: Builder(
            builder: (context) => Scaffold(

                appBar: AppBar(

                    title: const Text( appTitle )

                ),

                body: Container(

                    padding: const EdgeInsets.all( 30 ),

                    child: Column(

                        children:  <Widget> [

                          const Text(
                              welcomeMessage,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17
                              ) ),
                          const Divider(),
                          const Text(
                              loginPrompt,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17
                              ) ),
                          const Divider(),

                          Row(

                              mainAxisAlignment: MainAxisAlignment.center,

                              children: <Widget> [

                                const AddUser("Gunner"),

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
                                        ))
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
                                        ))
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