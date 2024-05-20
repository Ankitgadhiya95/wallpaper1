import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skyscrapper/skymodal.dart';

Sky? jsonList;
List<Hit> histList = [];

class Skyapi {
  Future loadPostData(imgcategory) async {
histList.clear();
    var data = await http.get(Uri.parse(
        "https://pixabay.com/api/?key=41975983-7659577943b4c5cb3eaa6fd35&category=$imgcategory"));
    print(data.body);

    var response = jsonDecode(data.body)['hits'];
    print("abc $response");
    for (var r in response) {
      histList.add(Hit.fromJson(r));
    }
    print("xyz $jsonList");
  }
}
