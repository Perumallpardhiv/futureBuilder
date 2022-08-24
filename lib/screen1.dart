import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class screen1 extends StatefulWidget {
  const screen1({Key? key}) : super(key: key);

  @override
  State<screen1> createState() => _screen1State();
}

class _screen1State extends State<screen1> {
  var url = "https://api.publicapis.org/entries";

  getdata() async {
    var res = await http.get(Uri.parse(url));
    var data = json.decode(res.body);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Future Builder Usage")),
      ),
      body: FutureBuilder(
        future: getdata(),
        builder: (context, dynamic snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data['entries'].length,
              itemBuilder: (context, index) {
                return Column(children: [
                  Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text("${snapshot.data['entries'][index]['API']}"),
                      subtitle: Text(
                          "${snapshot.data['entries'][index]['Description']}"),
                    ),
                  ),
                  const Divider(),
                ]);
              },
            );
          } else {
            return const Center(
              child: SpinKitSpinningLines(color: Colors.blue),
            );
          }
        },
      ),
    );
  }
}
