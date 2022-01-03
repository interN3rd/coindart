import 'dart:async';
import 'dart:convert';
import 'package:coindart/components/drawer_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

User? user = FirebaseAuth.instance.currentUser;

Future<Coin> fetchCoinData(final String coinId) async {

  // API-URL and API-Key
  String url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/info?id=' + coinId;

  final Map<String, String> tokenData = {
    "X-CMC_PRO_API_KEY": "8836be1d-8855-43d4-8689-3e9f9f0911c7",
  };

  // API-Call
  final response = await http.get(Uri.parse(url), headers: tokenData);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response then parse the JSON.
    return Coin.fromJson(jsonDecode(response.body)['data'][coinId]);
  } else {
    // If the server did not return a 200 OK response then throw an exception.
    throw Exception('Failed to load Coin Data');
  }
}

class Coin {
  final num id;
  final String name;
  final String description;

  Coin({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Coin.fromJson(dynamic json) {
    return Coin(
      id: json['id'],
      name: json['name'],
      description: json['description']
    );
  }

}

class Details extends StatefulWidget {
  const Details({Key? key, required this.coinId, required this.coinName}) : super(key: key);
  final String coinId;
  final String coinName;

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Future<Coin>? futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchCoinData(widget.coinId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coinName),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: FutureBuilder<Coin>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Flex(
                direction: Axis.vertical,
                children: [
                  Text(snapshot.data!.description)
                ]
              );
            } else if (snapshot.hasError) {
              print("Snapshot.hasError");
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      drawer: const DrawerMenu(),
    );
  }
}