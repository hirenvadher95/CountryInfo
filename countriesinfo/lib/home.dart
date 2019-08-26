import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gradient_app_bar/gradient_app_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var url = 'https://restcountries.eu/rest/v2/all';
  List<String> countryName = List<String>();
  List<String> flag = List<String>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    var res = await http.get(url);
    var decodedData = jsonDecode(res.body);

    setState(() {
      for (int i = 0; i < 250; i++) {
        countryName.add(decodedData[i]['name'].toString());
        flag.add(decodedData[i]['flag'].toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: GradientAppBar(
        title: Text('CountryInfo'),
        backgroundColorStart: Colors.cyan,
        backgroundColorEnd: Colors.indigo,
      ),
      body: GridView.builder(
        itemCount: countryName.isEmpty ? 0 : 250,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Center(
            child: Card(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SvgPicture.network(
                        flag[index],
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                        placeholderBuilder: (BuildContext context) =>
                            new Container(
                                padding: const EdgeInsets.all(30.0),
                                child: const CircularProgressIndicator()),
                      ),
                    ),
                  ),
                  Text(
                    countryName[index],
                    textAlign: TextAlign.end,
                    softWrap: true,
                    textDirection: TextDirection.ltr,
                  )
                ],
              ),
            ),
          );
        },
      ));
}
