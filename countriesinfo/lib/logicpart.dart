import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'country.dart';
import 'networklayer.dart';
import 'list.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var url = 'https://restcountries.eu/rest/v2/all';

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<String> getData() async {
    var response = await http.get(url);
    var decodedData = jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Countries'),
            backgroundColor: Colors.cyan), //*! Constant ma nakhvano color */
        drawer: Drawer(), //* Code of Drowe
        body: FutureBuilder<List<Country>>(
          future: fetchCountry(new http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? new CountyList(country: snapshot.data)
                : new Center(child: new CircularProgressIndicator());
          },
        ));
  }
}
