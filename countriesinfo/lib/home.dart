import 'package:countriesinfo/country.dart';
import 'package:flutter/material.dart';
import 'country_repo.dart';
import 'country.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Country> _country = <Country>[];
  @override
  void initState() {
    super.initState();
    listenForCountry();
  }

  void listenForCountry() async {
    final Stream<Country> stream = await fetchData();
    stream.listen((Country country) {
      setState(() {
        _country.add(country);
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('CountryInfo'),
        ),
        body: ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, i) {
              return ListTile(
                title: Text(_country[i].name),
              );
            }),
      );
}
