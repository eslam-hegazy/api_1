import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  List data = await getdata();

  runApp(
    MaterialApp(
      title: "My App",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("List View"),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              if (index.isEven) {
                return Divider();
              }
              return ListTile(
                title: Text(
                  "${data[index]["title"]}",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                subtitle: Text("${data[index]["body"]}"),
                leading: CircleAvatar(
                  child: Text("${data[index]["id"]}"),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("${data[index]["id"]}"),
                              Divider(),
                              Text(
                                "${data[index]["title"]}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text("${data[index]["body"]}"),
                              RaisedButton(
                                color: Colors.red,
                                  child: Text(
                                    "Close",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  })
                            ],
                          ),
                        );
                      });
                },
              );
            },
          ),
        ),
      ),
    ),
  );
}

Future<List> getdata() async {
  String url = "https://jsonplaceholder.typicode.com/posts";
  http.Response response = await http.get(url);
  return json.decode(response.body);
}
