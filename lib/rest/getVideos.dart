import 'package:flutter_app_rest_api/model/result.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Response> fetchVideos() async {
 http.Response response = await http.get(
      'https://raw.githubusercontent.com/Vantageboxllp/boyapi/master/videos');
  //List<Tutorials> list;

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    print("responseJson : $responseJson");

    return Response.fromMap(responseJson);
  } else {
    // If that call was not successful (response was unexpected), it throw an error.
    throw Exception('Failed to load post');
  }
  // return Tutorial.fromJson(json.decode(response.body));
}
