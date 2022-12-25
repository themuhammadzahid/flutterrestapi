import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetPhotos extends StatefulWidget {
  const GetPhotos({Key? key}) : super(key: key);

  @override
  State<GetPhotos> createState() => _GetPhotosState();
}

class _GetPhotosState extends State<GetPhotos> {
  List<Photos> photosList = [];
  Future<List<Photos>> getPhotos() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        photosList.add(Photos(i['title'], i['url'],i['id']));
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("REST API"), ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotos(),
                builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                  if (!snapshot.hasData) {
                    return Text("loading...");
                  } else {
                    return ListView.builder(
                        itemCount: photosList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(snapshot.data![index].url.toString()),
                            ),
                            subtitle: Text(snapshot.data![index].id.toString()),
                            title: Text(snapshot.data![index].title.toString()),
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class Photos {
  late String title, url;
  int id;
  Photos(this.title, this.url,this.id);
}
