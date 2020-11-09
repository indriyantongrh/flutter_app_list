import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_list/model/modelresponse.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Application Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<modelresponse> _modelresponse = List<modelresponse>();

  Future<List<modelresponse>> fetchData() async{
    final response =
    await http.get("https://jsonplaceholder.typicode.com/users");

    var datas = List<modelresponse>();

    if (response.statusCode == 200) {
      var datasJson = json.decode(response.body);
      for(var datasJson in datasJson){
        datas.add(modelresponse.fromJson(datasJson));
      }
    }
    return datas;
  }

  @override
  Widget build(BuildContext context) {
    fetchData().then((value) {
      _modelresponse.addAll(value);
    });


    return Scaffold(
      appBar: AppBar(

        title: Text(
          "Application Listview"
        ),
      ),

      body: ListView.separated(
        separatorBuilder: (context, index){
          return Divider(
              color: Colors.grey,
          );
          },
        itemBuilder: (context, index){

          return Card(
            child: Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 32, left: 16.0, right: 16.0),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _modelresponse[index].name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    "Username: "+_modelresponse[index].username,
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                  Text(
                    "Email: "+_modelresponse[index].email,
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                  Text(
                    "Phone: "+_modelresponse[index].phone,
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                  Text(
                    "Website: "+ _modelresponse[index].website,
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.normal
                    ),
                  ),

                  Text(
                    "Detail Alamat",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  Text(
                    "Street: "+_modelresponse[index].address.suite+", "+ _modelresponse[index].address.street+", "+_modelresponse[index].address.city+"\n Zip Code: "+_modelresponse[index].address.zipcode,
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                  Text(
                      "Detail Company",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  Text(
                    "Name Company: "+_modelresponse[index].company.name,

                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.normal
                    ),
                  ),

                  Text(
                    "Catchphrase: "+_modelresponse[index].company.catchPhrase,
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                  Text(
                    "BS: "+_modelresponse[index].company.bs,
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.normal
                    ),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: _modelresponse.length,
      ),
    );
  }


}
