import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/PostModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> postModel = [];
  Future<List<PostModel>> getUserList() async {
    postModel.clear();
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        postModel.add(PostModel.fromJson(i));
      }
      print(data.toString());
      return postModel;
    } else {

      return postModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REST API"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUserList(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("loading...");
                  } else {
                    return ListView.builder(
                        itemCount: postModel.length,
                        itemBuilder: (context, index) {
                          return Text(postModel[index].body.toString());
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
