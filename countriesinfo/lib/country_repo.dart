import 'dart:convert';

import 'package:http/http.dart' as http;
import 'country.dart';

var url = 'https://restcountries.eu/rest/v2/all';
var data;

Future<Stream<Country>> fetchData() async {
  final client = new http.Client();
  var requestData = await client.send(http.Request('get', Uri.parse(url)));
  print(requestData);
  data = requestData.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Country.fromJSON(data));
  return data;
}
