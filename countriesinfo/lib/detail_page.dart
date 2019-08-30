import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'home.dart';
import 'gradient.dart';

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
        decoration: BoxDecoration(gradient: SIGNUP_BACKGROUND),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[],
        ),
      ),
    );
  }
}
