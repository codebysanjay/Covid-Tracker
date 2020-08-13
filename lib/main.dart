import 'dart:convert';

import 'package:covid_19/detailpage.dart';
import 'package:covid_19/state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String activeCaseIndia;
  String confirmedCases;
  String recoveredCases;
  String deathCases;
  bool isLoaded = false;

  var url1 = "https://covid-19india-api.herokuapp.com/v2.0/country_data";
  var url2 = "https://covid-india-cases.herokuapp.com/states/";
  getDataInida() async {
    var response1 = await http.get(url1);
    if (response1.statusCode == 200) {
      setState(() {
        var inidaData = jsonDecode(response1.body);
        activeCaseIndia = inidaData[1]["active_cases"].toString();
        confirmedCases = inidaData[1]["confirmed_cases"].toString();
        recoveredCases = inidaData[1]["recovered_cases"].toString();
        deathCases = inidaData[1]["death_cases"].toString();
        isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    getDataInida();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Center(
          child: Text(
            "Covid-19 India".toUpperCase(),
          ),
        ),
      ),
      body: isLoaded
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Card1(
                          Colors.deepOrange,
                          "Total Case",
                          confirmedCases,
                        ),
                        Card1(
                          Colors.green,
                          "Recovered",
                          recoveredCases,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Card1(
                          Colors.blue,
                          "Active",
                          activeCaseIndia,
                        ),
                        Card1(
                          Colors.red,
                          "Death Case",
                          deathCases,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Listing(),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(15)),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => StatePage()));
                    },
                    child: Text(
                      "Get statewise report".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ubuntu(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class Card1 extends StatelessWidget {
  final Color color;
  final String status;
  final String numberOfCase;

  const Card1(this.color, this.status, this.numberOfCase);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: new Offset(2.0, 0),
            blurRadius: 10.0,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            numberOfCase,
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            status.toUpperCase(),
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class Listing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: new Offset(2.0, 0),
              blurRadius: 10.0,
            )
          ],
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Stop Corona\nVirus",
                style: GoogleFonts.ubuntu(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Detail()));
                },
                padding: EdgeInsets.all(0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "KNOW MORE",
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
              )
            ],
          ),
          Image(
            height: 100,
            image: AssetImage("assets/knowmore.png"),
          ),
        ],
      ),
    );
  }
}
