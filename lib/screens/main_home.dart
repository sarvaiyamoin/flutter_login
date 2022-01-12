import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login/model/user.dart';
import 'package:http/http.dart' as http;

class MainHome extends StatelessWidget {
  MainHome({Key? key}) : super(key: key);
  List<User> userData = [];
  Future<List<User>> getUserData() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/todos"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var userMap in data) {
        userData.add(User.fromJson(userMap));
      }
      return userData;
    } else {
      return userData;
    }
    // throw Exception("ffk");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Home"),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<User>>(
                  future: getUserData(),
                  builder: (context, snapshot) {
                    print(snapshot.error);
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: userData.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                child:
                                    Text(snapshot.data![index].id.toString()),
                              ),
                              title:
                                  Text(snapshot.data![index].title.toString()),
                              subtitle: Text(
                                  snapshot.data![index].completed.toString()),
                            );
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
