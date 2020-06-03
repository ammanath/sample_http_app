import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  final String url = 'https://swapi.dev/api/people';
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData()async {
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept":"application/json"}
      );
      //print(response.body);
      setState(() {
        var converDataToJson = jsonDecode(response.body);
        data = converDataToJson['results'];
      });
    return "Success"; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieve from http'),
      ),
      body: ListView.builder(
        itemCount: data==null?0:data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Container(
                    child: Text(data[index]['name']),
                    padding: EdgeInsets.all(30),
                  ),
                )
              ],
            ),
          ));
        },
      ),
    );
  }
}
