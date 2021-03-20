import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddUsers extends StatefulWidget {
  @override
  _AddUsersState createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {

  final tname = new TextEditingController();
  final tcropname = new TextEditingController();
  final tcropweight = new TextEditingController();

  bool _vname = false;
  bool _vcropname = false;
  bool _vcropweight = false;

  Future _saveDetails(String name, String crop_name, String crop_weight ) async
  {
    var url = "http://192.168.43.185/API/saveData.php";
    final response = await http.post(url,body: {"name": name, "crop_name": crop_name, "crop_weight": crop_weight});
    var res = response.body;
    if(res == "true")
      {
        Navigator.pop(context);
      }
    else
      {
        print("Error: " + res);
      }

  }

  @override
  void dispose() {
    tname.dispose();
    tcropname.dispose();
    tcropweight.dispose();
    //tid.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD USERS"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: new InputDecoration(
                hintText: 'FULL NAME',
                labelText: 'FULL NAME',
                labelStyle: TextStyle(fontSize: 17.0),
                hintStyle: TextStyle(fontSize: 17.0),
                errorText: _vname ? 'Name cant be empty' : null,
              ),
              controller: tname,
            ),
            SizedBox(height: 10.0,),
            TextField(
              decoration: new InputDecoration(
                hintText: 'CROP NAME',
                labelText: 'CROP NAME',
                labelStyle: TextStyle(fontSize: 17.0),
                hintStyle: TextStyle(fontSize: 17.0),
                errorText: _vcropname ? 'Crop Name cant be empty' : null,
              ),
              controller: tcropname,
            ),
            SizedBox(height: 10.0,),
            TextField(
              decoration: new InputDecoration(
                hintText: 'CROP WEIGHT',
                labelText: 'CROP WEIGHT',
                labelStyle: TextStyle(fontSize: 17.0),
                hintStyle: TextStyle(fontSize: 17.0),
                errorText: _vcropweight ? 'Crop weight cant be empty' : null,
              ),
              controller: tcropweight,
            ),
            SizedBox(height: 10.0,),
            ButtonBar(
              children:<Widget>[
                // ignore: deprecated_member_use
                RaisedButton(
                    color: Colors.green,
                    child: Text("Save"),
                    onPressed:(){
                      setState(() {
                        tname.text.isEmpty ? _vname = true : _vname = false;
                        tcropname.text.isEmpty ? _vcropname = true : _vcropname = false;
                        tcropweight.text.isEmpty ? _vcropweight = true : _vcropweight = false;

                        if(_vname ==  false && _vcropname ==  false && _vcropweight == false)
                          {
                            _saveDetails(tname.text, tcropname.text , tcropweight.text);
                          }
                      });
                    }
                    ),
                // ignore: deprecated_member_use
                RaisedButton(
                    onPressed: (){
                      tname.clear();
                      tcropname.clear();
                      tcropweight.clear();
                    },
                    color: Colors.red,
                    child: Text("Clear"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

