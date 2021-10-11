import 'package:flutter/material.dart';

void main() => runApp( Coindart() );

class Coindart extends StatelessWidget {

  @override
  Widget build( BuildContext context ) {
    return MaterialApp(
      title: "Coindart",
      home: Scaffold(
        appBar: AppBar(
          title: const Text( "Coindart - Your Next Bull's Eye Trade" )
        ),
        body: const Center(
          child: Text( "Welcome to Coindart" ),
        ),
      ),
    );
  }

}
