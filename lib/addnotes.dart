import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:todolist/homescreen.dart';

class Tds extends StatefulWidget {
  const Tds({Key? key}) : super(key: key);

  @override
  State<Tds> createState() => _TdsState();
}

class _TdsState extends State<Tds> {
  TextEditingController a =TextEditingController();
  TextEditingController b=TextEditingController();
  sentdata()async {
    var body = {
      'title': a.text,
      'content': b.text
    };
    Response response = await post(Uri.parse('http://192.168.1.34:8080/addNotes'),
        body: jsonEncode(body));
      print('daaa');
      if (response.statusCode==200){
        var boy =jsonDecode(response.body);
        print(boy);
        if(boy['message']=='inserted'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Todo(),));
        }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: a,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
                )
              ),

            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: b,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
            ),
            ElevatedButton(onPressed: (){
               sentdata();
            }, child: Text('Ok'))
          ],
        ),
      ),
    );
  }
}
