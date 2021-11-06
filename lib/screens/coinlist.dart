import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<List<Coin>> fetchCoin() async {
  const url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=12';
  final Map<String, String> tokenData = {
    "X-CMC_PRO_API_KEY": "8836be1d-8855-43d4-8689-3e9f9f0911c7",
  };
  final response = await http.get(Uri.parse(url), headers: tokenData);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Coin> ergebnis = [];
    for( var i = 0 ; i <= 11; i++ ) {
      ergebnis.add(Coin.fromJson(jsonDecode(response.body)['data'][i]));
    }
    return ergebnis;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.statusCode);
    throw Exception('Failed to load Coins');
  }
}

class Coin {
  final String name;
  final num price;
  final num change;

  Coin({
    required this.name,
    required this.price,
    required this.change
  });

  factory Coin.fromJson(dynamic json) {
    return Coin(
      name: json['name'],
      price: json['quote']['USD']['price'],
      change: json['quote']['USD']['percent_change_24h']
    );
  }
}

class Coinlist extends StatefulWidget {
  const Coinlist({Key? key}) : super(key: key);

  @override
  _CoinlistState createState() => _CoinlistState();
}

class _CoinlistState extends State<Coinlist> {
  Future<List<Coin>>? futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchCoin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Coins'),
      ),
      body: Center(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(child: Text( "Name" )),
                  Text( "Price" ),
                  SizedBox(child: Text( "24h", textAlign: TextAlign.right, ), width: 80),
                ]
              )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 45),
              child: FutureBuilder<List<Coin>>(
                future: futureData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print("Snapshot.hasData");
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: ( context, index ) {
                        return ListTile(
                            title:
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child: Text( snapshot.data!.elementAt(index).name )) ,
                                Text( "\$" + snapshot.data!.elementAt(index).price.toStringAsFixed(4) ),
                                SizedBox(child: Text( snapshot.data!.elementAt(index).change.toStringAsFixed(2) + "%", textAlign: TextAlign.right, ), width: 80),
                              ],
                            )
                        );
                      },
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
          ],
        ),
      ),
    );
  }
}