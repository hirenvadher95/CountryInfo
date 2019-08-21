import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  getData() async {
    var response = await http.get(url);
    var decodedData = jsonDecode(response.body);
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Countries'),
          backgroundColor: Colors.cyan), //*! Constant ma nakhvano color */
      drawer: Drawer(), //* Code of Drowe
    );
  }
}
