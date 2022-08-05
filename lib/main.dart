import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String quote = '';
  String author = '';
  bool loading = false;

  void getQuote() async {
    setState(() {
      loading = true;
    });
    try {
      Uri url = Uri.http('animechan.vercel.app', '/api/random');
      Response result = await get(url);
      Map res = jsonDecode(result.body);
      setState(() {
        quote = res['quote'];
        author = res['character'];
      });
    } catch (e) {
      setState(() {
        quote = "Could not connect to server";
        author = "";
      });
    }
    ;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        title: Text("Anime Quotes"),
      ),
      body: loading
          ? SpinKitFadingCube(
              color: Colors.white,
              size: 50.0,
            )
          : Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      quote,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 24.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "-$author",
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton.icon(
                        style:
                            ElevatedButton.styleFrom(primary: Colors.grey[800]),
                        onPressed: () {
                          getQuote();
                        },
                        icon: Icon(Icons.refresh),
                        label: Text("Change")),
                  ],
                ),
              ),
            ),
    );
  }
}
