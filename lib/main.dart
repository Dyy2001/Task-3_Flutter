import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String data = '';
  late Map mapres;
  late List listres = [];
  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode == 200) {
      setState(() {
        mapres = jsonDecode(response.body);
        listres = mapres['data'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Data '),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.network(listres[index]['avatar'])),
                    Text(listres[index]['id'].toString()),
                    Column(
                      children: [
                        Text(listres[index]['first_name'].toString()),
                        Text(listres[index]['last_name'].toString()),
                        Text(listres[index]['email'].toString()),
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        },
        itemCount: listres.length,
      ),
      floatingActionButton: ElevatedButton(
        onPressed: apicall,
        child: const Text("Dapatkan Data"),
      ),
    );
  }
}
