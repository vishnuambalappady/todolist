import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'homescreen.dart';

class Edit extends StatefulWidget {
   Edit({Key?key,required this.data,required this.cons,required this.id}) : super(key: key);
   String data;
   String cons;
   String id;

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController titleContrler =TextEditingController();
  TextEditingController contentContrler = TextEditingController();
  sentdata()async{
    var body={
      'title' :titleContrler.text,
      'content':contentContrler.text,
      'id':widget.id
    };
    Response response = await post(Uri.parse('http://192.168.1.34:8080/updateNotes'),
    body: jsonEncode(body));
    if (response.statusCode ==200){
      var boy =jsonDecode(response.body);
     print(boy);
     if (boy['message']== 'note updated'){
     Navigator.push(context,MaterialPageRoute(builder:(context) => Todo(),));
     }
    }

  }
  @override
  void initState() {

    titleContrler.text= widget.cons;
    contentContrler.text=widget.data;
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: titleContrler,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: contentContrler,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
            ),
            ElevatedButton(onPressed: (){
              sentdata();
            }, child: Text('Update'))
          ],
        ),
      ),
    );
  }
}
