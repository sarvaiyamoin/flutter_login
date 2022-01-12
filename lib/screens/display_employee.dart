import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login/model/employee.dart';
import 'package:flutter_login/model/user.dart';
import 'package:http/http.dart' as http;

class DisplayEmployee extends StatelessWidget {
  DisplayEmployee({Key? key}) : super(key: key);
  List<Employee> employeeData = [];
  Future<List<Employee>> getemployeeData() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var userMap in data) {
        employeeData.add(Employee.fromJson(userMap));
      }
      return employeeData;
    } else {
      return employeeData;
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
              child: FutureBuilder<List<Employee>>(
                  future: getemployeeData(),
                  builder: (context, snapshot) {
                    print(snapshot.error);
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: employeeData.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                child:
                                    Text(snapshot.data![index].id.toString()),
                              ),
                              title: Text(snapshot
                                  .data![index].address!.geo!.lat
                                  .toString()),
                              subtitle: Text(snapshot
                                  .data![index].address!.geo!.lng
                                  .toString()),
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
