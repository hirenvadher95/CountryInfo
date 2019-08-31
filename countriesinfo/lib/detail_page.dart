import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'home.dart';
import 'const.dart';

int i;

void sendIndex(int index) {
  i = index;
}

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text('Information'),
        backgroundColorStart: Colors.cyan,
        backgroundColorEnd: Colors.indigo,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 64.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            CustomWidget(field: "Name : ", valueofFiled: countryName[i]),
            CustomWidget(field: "Capital : ", valueofFiled: capital[i]),
            CustomWidget(field: "Region : ", valueofFiled: region[i]),
            CustomWidget(field: "Population : ", valueofFiled: population[i]),

            CustomWidget(field: "Native Name : ", valueofFiled: nativeName[i]),
            CustomWidget(
                field: "Calling Codes : ", valueofFiled: callingCodes[i]),
          ],
        ),
      ),
    );
  }
}

class CustomWidget extends StatelessWidget {
  CustomWidget({this.field, this.valueofFiled});

  final field;
  final valueofFiled;

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      elevation: 5,
      color: Colors.yellowAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Text(
            field,
            style: ktextStyle,
          ),
          Text(
            valueofFiled,
            style: ktextStyle,

          ),
        ],
      ),
    );
  }
}
