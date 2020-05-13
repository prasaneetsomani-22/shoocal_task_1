import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp>
{

  List details = [];

  @override
  void initState(){
    super.initState();
    getdata().then((results){
      setState(() {
        details = results;
      });
    });
  }

  Future<List> getdata()async{
    List UserDetails = [];
    Response response = await get("https://api.github.com/repositories/19438/issues");
    var data = jsonDecode(response.body);
    for (var details in data){
      UserDetails.add(details);
    }
    return UserDetails;
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: details.length == 0?Scaffold(
        backgroundColor: Colors.pink,
        body: Center(child: Text("Shoocal",style: TextStyle(color: Colors.white,fontSize: 40.0,fontWeight: FontWeight.bold),),),
      ):Scaffold(
        appBar: AppBar(
          title: Text("Shoocal"),
          centerTitle: true,
          backgroundColor: Colors.pinkAccent,
        ),
        body: ListView(
          children: buildList(),
        ),

      ),
    );
  }
  buildList(){
    List<Widget> items = [];
    details.forEach((element){
      items.add(Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(

          elevation: 10.0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Login: ${element["user"]["login"]}",style: TextStyle(fontSize: 20.0,color: Colors.black,fontWeight: FontWeight.bold),),
                SizedBox(height: 10.0,),
                Text("Id: ${element["user"]["id"]}",style: TextStyle(fontSize: 20.0,color: Colors.black,fontWeight: FontWeight.bold),),
                SizedBox(height: 10.0,),
                Text("Repository URL: ${element["repository_url"]}",style: TextStyle(fontSize: 20.0,color: Colors.black,fontWeight: FontWeight.bold),),
                SizedBox(height: 10.0,),
                Row(
                  children: <Widget>[
                    Text("State",style: TextStyle(fontSize: 20.0,color: Colors.black,fontWeight: FontWeight.bold)),
                    SizedBox(width: 20.0,),
                    Checkbox(
                      activeColor: Colors.blue,
                      value: element["state"] == "open"?true:false,)
                  ],

                )
              ],
            ),
          ),

          ),
      ),
      );
    });
    return items;
  }

}

class userdetails{
  final String login;
  final int id;
  final String repository_url;
  final String state;

  userdetails(this.login,this.id,this.repository_url,this.state);



}