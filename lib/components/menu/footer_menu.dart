import 'package:flutter/material.dart';

class FooterMenu extends StatelessWidget {

  const FooterMenu({Key? key}) : super(key: key);

  @override
  Widget build( BuildContext context ) {

    return Row(
      key: const ValueKey("footer menu"),
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
    );
  }
}