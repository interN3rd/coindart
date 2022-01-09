import 'package:coindart/components/menu/drawer_menu.dart';
import "package:flutter/material.dart";

class Imprint extends StatelessWidget {

  const Imprint( { Key? key } ) : super( key: key );

  @override
  Widget build( BuildContext context ) {

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
      drawer: const DrawerMenu(),
    );
  }
}