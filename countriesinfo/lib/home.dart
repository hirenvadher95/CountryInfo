import 'dart:async';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'detail_page.dart';
import 'package:countriesinfo/const.dart';
import 'package:countriesinfo/privacy.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:connectivity/connectivity.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

List<String> countryName = List<String>();
List<String> flag = List<String>();
List<String> callingCodes = List<String>();
List<String> capital = List<String>();
List<String> region = List<String>();
List<String> population = List<String>();

List<String> nativeName = List<String>();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var url = 'https://restcountries.eu/rest/v2/all';
  var _connectionStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    connectivity = Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectionStatus = result.toString();
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        getData();
      } else if (result == ConnectivityResult.none) {
        Alert(
                context: context,
                title: "Error",
                desc: "Check Your Internet Connection!.")
            .show();
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Future getData() async {
    var res = await http.get(url);
    var decodedData = jsonDecode(res.body);

    setState(() {
      for (int i = 0; i < 250; i++) {
        // some of svg flag wont render in flutter so skip it
        if (i != 4 &&
            i != 10 &&
            i != 19 &&
            i != 31 &&
            i != 32 &&
            i != 39 &&
            i != 44 &&
            i != 64 &&
            i != 73 &&
            i != 89 &&
            i != 97 &&
            i != 99 &&
            i != 156 &&
            i != 167 &&
            i != 168 &&
            i != 199 &&
            i != 206 &&
            i != 208 &&
            i != 209 &&
            i != 213 &&
            i != 221 &&
            i != 234 &&
            i != 249) {
          countryName.add(decodedData[i]['name'].toString());
          flag.add(decodedData[i]['flag'].toString());
          callingCodes.add(decodedData[i]['callingCodes'].toString());
          capital.add(decodedData[i]['capital'].toString());
          region.add(decodedData[i]['region'].toString());
          population.add(decodedData[i]['population'].toString());
          nativeName.add(decodedData[i]['nativeName'].toString());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Image.asset(
                  'assets/images/logoc.png',
                  fit: BoxFit.contain,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  gradient: SIGNUP_CARD_BACKGROUND,
                ),
              ),
              ListTile(
                title: Text('Privacy Policy'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                },
              ),
              ListTile(
                title: Text(''),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        appBar: GradientAppBar(
          title: Text('CountryInfo'),
          backgroundColorStart: Colors.cyan,
          backgroundColorEnd: Colors.indigo,
        ),
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (countryName.isNotEmpty) {
                return GridView.builder(
                  itemCount: countryName.isEmpty ? 0 : 227,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Center(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPage()));
                              sendIndex(index);
                              print(index);

                            },
                            disabledColor: Theme.of(context).backgroundColor,
                            color: Theme.of(context).backgroundColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Hero(
                                    tag: 'logo$index',
                                    child: SvgPicture.network(
                                      flag[index],
                                      height: 100,
                                      width: 100,
                                      allowDrawingOutsideViewBox: false,
                                      fit: BoxFit.fill,
                                      alignment: Alignment.center,
                                      placeholderBuilder:
                                          (BuildContext context) =>
                                              new Container(
                                                  padding: const EdgeInsets.all(
                                                      30.0),
                                                  child: SpinKitDoubleBounce(
                                                    color: Colors.blue,
                                                    size: 50,
                                                  )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
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
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: SpinKitWave(
                    color: Colors.redAccent,
                    size: 75.0,
                  ),
                );
              }
            }),
      );
}
