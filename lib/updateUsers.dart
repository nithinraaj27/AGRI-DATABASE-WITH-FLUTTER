import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateUsers extends StatefulWidget {

  final String id;
  final String name;
  final String crop_name;
  final String crop_weight;

  const UpdateUsers({Key key, this.id, this.name, this.crop_name, this.crop_weight}) : super(key: key);

  @override
  _UpdateUsersState createState() => _UpdateUsersState();
}

class _UpdateUsersState extends State<UpdateUsers> {

  final tname = new TextEditingController();
  final tcropname = new TextEditingController();
  final tcropweight = new TextEditingController();
  //final tid = new TextEditingController();

  bool _vname = false;
  bool _vcropname = false;
  bool _vcropweight = false;
  //bool _vid = false;

  Future _deleteUser() async {
    var url = "http://192.168.43.185/API/deleteuser.php";
    final response  = await http.post(url,body : {"id" : widget.id});
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

  Future _updateDetails(String name,String crop_name,String crop_weight) async {
    var url = "http://192.168.43.185/api/updateUser.php";
    final response = await http.post(url,body:
    {
      "name" : name, "crop_name"  : crop_name, "crop_weight" : crop_weight, "id" : widget.id
    });
    var res = response.body;
    print(res);
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
  void initState() {
    tname.text = widget.name;
    tcropname.text = widget.crop_name;
    tcropweight.text = widget.crop_weight;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "update"
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            // TextField(
            //   decoration: new InputDecoration(
            //     hintText: 'ID',
            //     labelText: 'ID',
            //     labelStyle: TextStyle(fontSize: 17.0),
            //     hintStyle: TextStyle(fontSize: 17.0),
            //     errorText: _vid ? 'ID cant be empty' : null,
            //   ),
            //   controller: tid,
            // ),
            // SizedBox(height: 10.0,),
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
                    child: Text("UPDATE"),
                    onPressed:(){
                      setState(() {
                        tname.text.isEmpty ? _vname = true : _vname = false;
                        tcropname.text.isEmpty ? _vcropname = true : _vcropname = false;
                        tcropweight.text.isEmpty ? _vcropweight = true : _vcropweight = false;
                        //tid.text.isEmpty? _vid = true : _vid = false;

                        if(_vname ==  false && _vcropname ==  false && _vcropweight == false)
                        {
                         _updateDetails(tname.text, tcropname.text , tcropweight.text);
                        }
                      });
                    }
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: (){
                    _deleteUser();
                  },
                  color: Colors.red,
                  child: Text("DELETE"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
