import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'home.dart';
import 'const.dart';

import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


int i;

void sendIndex(int index) {
  i = index;
}

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var cName = countryName[i];

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
            Center(
              child: ColorizeAnimatedTextKit(
                  text: [
                    "$cName",
                  ],
                  textStyle: TextStyle(fontSize: 50.0, fontFamily: "Horizon"),
                  colors: [
                    Colors.purple,
                    Colors.blue,
                    Colors.yellow,
                    Colors.red,
                  ],
                  textAlign: TextAlign.center,
                  alignment:
                      AlignmentDirectional.topStart // or Alignment.topLeft
                  ),
            ),SizedBox(height: 40,),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GradientCard(
        margin: EdgeInsets.all(8),
        semanticContainer: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        gradient: Gradients.hotLinear,
        shadowColor: Gradients.tameer.colors.last.withOpacity(0.25),
        elevation: 8,
        
        child: Row(
          children: <Widget>[
            Text(
              field,
              style: ktextStyle,
            ),
            Expanded(
              child: Text(
                valueofFiled,
                style: ktextStyle,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
