import 'package:flutter/material.dart';

class Status extends StatelessWidget {

  const Status({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text( "Status" )
      ),

      body: Container(

        padding: const EdgeInsets.all( 30 ),

        child: Column(

            children: const <Widget> [

            Text(
                "Here you will find technical information regarding the status of the app, e.g. if you are an authenticated user or the API is functional.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17
                )
            )
            ]
        )
      )
    );
  }
}