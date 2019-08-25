class Country {
  final String name;

  Country.fromJSON(Map<String, dynamic> jsonMap)
      : name = jsonMap["name"] as String;
}
