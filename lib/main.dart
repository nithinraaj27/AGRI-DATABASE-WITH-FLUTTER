import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
import 'package:mini_project/addUsers.dart';
import 'package:mini_project/updateUsers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: <String,WidgetBuilder>{
        '/addUsers':(BuildContext context)=> new AddUsers()
      },
    );
  }
}

Future<List> getData() async{

  var url = "http://192.168.43.185/API/getData.php";
  final response = await http.get(url);
  var dataReceived = jsonDecode(response.body);
  //print(dataReceived);
  return dataReceived;
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffB9D1D2),
      appBar: AppBar(
        backgroundColor: Color(0xff3FA0A6),
        elevation: 0.0,
        title: Text("CRUD APP",
        style: TextStyle(
          fontSize: 30.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),),
        centerTitle: true,
      ),

      body: new FutureBuilder<List>(
        future: getData(),
        builder:(context, snapshot)
        {
          if(snapshot.hasError)
            {
              print("Eror in Loading"+ snapshot.error.toString());
            }
          
          return snapshot.hasData? new ItemList(list: snapshot.data):new Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, '/addUsers');
        },
      ),

    );
  }
}

class ItemList extends StatelessWidget {

  final List list;

  const ItemList({Key key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null?0:list.length,
        itemBuilder: (context,i){
          return Card(
            child: ListTile(
              onTap: ()
              {
                Navigator.push(context, MaterialPageRoute(builder:(context)=>UpdateUsers(

                    id : list[i]['ID'],
                    name : list[i]['NAME'],
                    crop_name : list[i]['CROP_NAME'],
                    crop_weight: list[i]['CROP_WEIGHT'],
                ) ));

              },
              leading: CircleAvatar(
                child: Text(list[i]["NAME"].toString().substring(0,1).toUpperCase()),
              ),
              title: new Text(
                list[i]['NAME'],style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
              subtitle: new Text(list[i]['CROP_NAME'],style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
            ),
          );
        });
  }
}

