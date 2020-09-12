import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_rest_api/rest/getVideos.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model/result.dart';

void main() => runApp(MyApp());
var rest;

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Response response;

  @override
  void initState() {
    super.initState();
    fetchVideos().then((videos) {
      setState(() {
        response = videos;
      });
    });
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
          child: FutureBuilder(
            future: fetchVideos(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: response.videos.topsongs.length,
                    itemBuilder: (BuildContext context, int index) {
                      //if(index >= snapshot?.data?.length ?? 0) return null;
                      //final nDataList = itemes[index];
                      return ListTile(
                        title: Text(response.videos.topsongs[index].name),
                      );
                    });
              } else {
                return Container(
                  child: Center(child: Text("Loading........")),
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
