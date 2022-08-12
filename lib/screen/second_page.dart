import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserLocalPage(),
    );
  }
}

class UserLocalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: FutureBuilder(
          future: rootBundle.loadString('data_repo/users.json'),
          builder: (context, snapshot) {
            // Decode the JSON
            var users = json.decode(snapshot.data.toString());

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(child: Text('Some error occurred!'));
                } else {
                  return buildUsers(users);
                }
            }
          },
        ),
      );

  Widget buildUsers(users) => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: users == null ? 0 : users.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          UserDetailPage(user: users[index]))),
              title: Text(users[index]['username']),
              subtitle: Text(users[index]['email']),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(users[index]['urlAvatar']),
              ),
            ),
          );
        },
      );
}

class UserDetailPage extends StatelessWidget {
  final user;
  UserDetailPage({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user['urlAvatar']),
              ),
              Text(user['username']),
              Text(user['email']),
            ],
          ),
        ),
      );
}

void main(List<String> args) {
  runApp(MyApp());
}
