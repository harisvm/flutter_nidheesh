import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());
var rest;
class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<List<Videos>> post;
  List<Topsongs> itemes=[];
  List<Videos> _list;
  @override
  void initState() {
    super.initState();
    post = fetchPost();
    fetchPost().then((users) {
      setState(() {
        _list = users;
      });
    });
  }
  Future<List<Videos>> fetchPost() async {
    http.Response response = await http.get('https://raw.githubusercontent.com/Vantageboxllp/boyapi/master/videos');
    List<Topsongs> itemes=[];
    //List<Tutorials> list;

    Videos videos;
    if (response.statusCode == 200) {
      // If the call to the server was successful (returns OK), parse the JSON.
      final data = jsonDecode(response.body);

      videos = Videos.fromJson(data);
      print(response.body.toString());

//v//ar rb=response.body;
//var list=jsonDecode(rb)as List;
      //List<Topsongs> result = data.map((x) =>Topsongs.fromJson(x)).toList();
      //List<Fluttertutorials> result1 = data.map((x) =>Fluttertutorials.fromJson(x)).toList();

      // print("JJKKKKKfghhgf$result".length);
      // print("JJKKKKKresggg$result1".length);


      //for(Map i in data)
      // itemes.add(data);
      for(int i=0;i<response.body.length-1;i++) {
        setState(() {

            rest = data["videos"]['Topsongs'][i];

        });
        print("JJKKKKK$rest");
      };

      return rest;
    }

    else {
      // If that call was not successful (response was unexpected), it throw an error.
      throw Exception('Failed to load post');
    }
    // return Tutorial.fromJson(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter REST API Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter REST API Example'),
        ),
        body: Center(

          child: FutureBuilder<List<Videos>>(

            future: post,


            builder: (context, AsyncSnapshot snapshot) {

              if(rest==null)
                {
                  return Container(
                   child: Center(
                     child: Text(
                       "Loading........"
                     )
                   ),
                  );
                }
              else{
                return ListView.builder(
                    itemCount: rest.length,
                    itemBuilder:(BuildContext context,int index){
                      //if(index >= snapshot?.data?.length ?? 0) return null;
                      //final nDataList = itemes[index];
                      return ListTile(
                        title: Text("$rest{[index]}"),
                      );

                    }
                );
              }

              //if (snapshot.hasData) {
                //return Text(abc.data.name);
              //} else if (abc.hasError) {
                //return Text("${abc.error}");
              //}

              // By default, it show a loading spinner.
              return CircularProgressIndicator();
            },
          ),

        ),
      ),
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),

    );
  }
}



class Tutorials {
  Videos videos;

  Tutorials({this.videos});

  Tutorials.fromJson(Map<String, dynamic> json) {
    videos =
    json['videos'] != null ? new Videos.fromJson(json['videos']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.videos != null) {
      data['videos'] = this.videos.toJson();
    }
    return data;
  }
}

class Videos {
  List<Topsongs> topsongs;
  List<Fluttertutorials> fluttertutorials;

  Videos({this.topsongs, this.fluttertutorials});

  Videos.fromJson(Map<String, dynamic> json) {
    if (json['Topsongs'] != null) {
      topsongs = new List<Topsongs>();
      json['Topsongs'].forEach((v) {
        topsongs.add(new Topsongs.fromJson(v));
      });
    }
    if (json['Fluttertutorials'] != null) {
      fluttertutorials = new List<Fluttertutorials>();
      json['Fluttertutorials'].forEach((v) {
        fluttertutorials.add(new Fluttertutorials.fromJson(v));
        print("$fluttertutorials");
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topsongs != null) {
      data['Topsongs'] = this.topsongs.map((v) => v.toJson()).toList();
    }
    if (this.fluttertutorials != null) {
      data['Fluttertutorials'] =
          this.fluttertutorials.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topsongs {
  String name;
  String url;

  Topsongs({this.name, this.url});

  Topsongs.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
class Fluttertutorials {
  String name;
  String url;

  Fluttertutorials({this.name, this.url});

  Fluttertutorials.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}