import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          // Use future builder and DefaultAssetBundle to load the local JSON file
          child: FutureBuilder(
              future: rootBundle.loadString('data_repo/starwars_data.json'),
              builder: (context, snapshot) {
                // Decode the JSON
                var new_data = json.decode(snapshot.data.toString());

                return ListView.builder(
                  // Build the ListView
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("Name: " + new_data[index]['name']),
                          Text("Height: " + new_data[index]['height']),
                          Text("Mass: " + new_data[index]['mass']),
                          Text("Hair Color: " + new_data[index]['hair_color']),
                          Text("Skin Color: " + new_data[index]['skin_color']),
                          Text("Eye Color: " + new_data[index]['eye_color']),
                          Text("Birth Year: " + new_data[index]['birth_year']),
                          Text("Gender: " + new_data[index]['gender'])
                        ],
                      ),
                    );
                  },
                  itemCount: new_data == null ? 0 : new_data.length,
                );
              }),
        ),
      ),
    );
  }
}
