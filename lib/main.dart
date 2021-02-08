import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String url = 'http://batikita.herokuapp.com/index.php/batik/all';
  List data;

  Future<String> getData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {'accept': 'application/json'});
    setState(() {
      var content = json.decode(res.body);
      data = content['hasil'];
      print(data);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Batik Indonesia",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Batik Indonesia"),
        ),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                     Image.network(data[index]['link_batik']),
                      ListTile(
                        title: Text(data[index]['nama_batik']),
                        subtitle: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text("Daerah : "+data[index]['daerah_batik']),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text("Price : " + data[index]['harga_rendah'].toString() + " - " + data[index]['harga_tinggi'].toString()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
