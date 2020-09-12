// To parse this JSON data, do
//
//     final response = responseFromMap(jsonString);

import 'dart:convert';

Response responseFromMap(String str) => Response.fromMap(json.decode(str));

String responseToMap(Response data) => json.encode(data.toMap());

class Response {
  Response({
    this.videos,
  });

  Videos videos;

  factory Response.fromMap(Map<String, dynamic> json) => Response(
    videos: Videos.fromMap(json["videos"]),
  );

  Map<String, dynamic> toMap() => {
    "videos": videos.toMap(),
  };
}

class Videos {
  Videos({
    this.topsongs,
    this.fluttertutorials,
  });

  List<Fluttertutorial> topsongs;
  List<Fluttertutorial> fluttertutorials;

  factory Videos.fromMap(Map<String, dynamic> json) => Videos(
    topsongs: List<Fluttertutorial>.from(json["Topsongs"].map((x) => Fluttertutorial.fromMap(x))),
    fluttertutorials: List<Fluttertutorial>.from(json["Fluttertutorials"].map((x) => Fluttertutorial.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "Topsongs": List<dynamic>.from(topsongs.map((x) => x.toMap())),
    "Fluttertutorials": List<dynamic>.from(fluttertutorials.map((x) => x.toMap())),
  };
}

class Fluttertutorial {
  Fluttertutorial({
    this.name,
    this.url,
  });

  String name;
  String url;

  factory Fluttertutorial.fromMap(Map<String, dynamic> json) => Fluttertutorial(
    name: json["Name"],
    url: json["url"],
  );

  Map<String, dynamic> toMap() => {
    "Name": name,
    "url": url,
  };
}