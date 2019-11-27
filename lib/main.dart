import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Users'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}





class _MyHomePageState extends State<MyHomePage>{

 Future<List<User>> _getUsers() async {

  var data = await http.get("https://api.myjson.com/bins/hyuty");
  
  var jsonData = json.decode(data.body);
  
  List<User> users = [];
  
  for(var u in jsonData){

    User user = User(u["index"], u["about"], u["name"], u["email"], u["picture"]);

    users.add(user);

  }

  print(users.length);

  return users;

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Json App"),
        ),
      body: Container(
        child: FutureBuilder(
          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot){

            if(snapshot.data == null){
              return Container(
                child: Center(
                  child: Text("Loading"),
                ),
              );

            } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          snapshot.data[index].picture
                        ),
                      ),
                      title: Text(snapshot.data[index].name),
                      subtitle: Text(snapshot.data[index].email),
                      onTap: () {
                        Navigator.push(context,
                          new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]))
                        );
                      },
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }

}






class DetailPage extends StatelessWidget{

  final User user;

  DetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Container(
        child: new Center(
          child: new Column(
            children: <Widget>[

              new Card(
                child: new Container(
                  padding: const EdgeInsets.all(10.0),
                  color: Colors.black38,
                  child: new CircleAvatar(
                    backgroundImage: NetworkImage(user.picture),
                    radius: 150.0,
                  ),
                ),
              ),

              new Card(
                child: new Container(
                  padding: const EdgeInsets.all(10.0),
                  child: new Text(user.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.0),),
                ),
              ),

              new Card(
                child: new Container(
                  padding: const EdgeInsets.all(10.0),
                  child: new Text(user.email),
                ),
              ),

              new Card(
                child: new Container(
                  padding: const EdgeInsets.all(10.0),
                  child: new Text(user.about),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  
}











class User {
  final int index;
  final String about;
  final String name;
  final String email;
  final String picture;

  User(this.index, this.about, this.name, this.email, this.picture);
}


































































































































//void main() => runApp(new MaterialApp(
//      home: new HomePage(),
//  ));
//
//
//class HomePage extends StatefulWidget{
//  @override
//  HomePageState createState() => new HomePageState();
//}
//
//
//class HomePageState extends State<HomePage>{
//
//
//  final String url = "https://swapi.co/api/people";
//  List data;
//
// @override
//  void initState() {
//    super.initState();
//    this.getJsonData();
//  }
//
//  Future<String> getJsonData() async {
//   var response = await http.get(
//     Uri.encodeFull(url),
//     headers: {"Accept":"application/json"}
//   );
//
//   print(response.body);
//
//   setState(() {
//     var convertDataToJson = json.decode(response.body);
//     data = convertDataToJson['results'];
//
//   });
//
//   return "Success";
//
//
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//        appBar: new AppBar(
//          title: new Text("Retrieve Json Http Get Request"),
//        ),
//      body: new ListView.builder(
//        itemCount: data == null ? 0 : data.length,
//        itemBuilder: (BuildContext context, int index){
//          return new Container(
//            child: new Center(
//              child: new Column(
//                crossAxisAlignment: CrossAxisAlignment.stretch,
//                children: <Widget>[
//                  new Card(
//                    child: new Container(
//                      child: new Text(data[index]['name']),
//                      padding: const EdgeInsets.all(20.0),
//                    ),
//                  )
//                ],
//              ),
//            ),
//          );
//        },
//      ),
//    );
//  }
//
//}
