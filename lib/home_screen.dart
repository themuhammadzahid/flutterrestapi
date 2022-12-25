import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/posts_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> postsList = [];
  Future<List<PostModel>> getUserList() async {
    postsList.clear();
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        postsList.add(PostModel.fromJson(i));
      }
      print(data.toString());
      return postsList;
    } else {

      return postsList;
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
                        itemCount: postsList.length,
                        itemBuilder: (context, index) {
                          return Text(postsList[index].body.toString());
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
