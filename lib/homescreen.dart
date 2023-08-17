import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todolist/addnotes.dart';
import 'package:http/http.dart';

import 'Edit.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List responselist = [];
  List<Map<dynamic,dynamic>> searchlist = [];

  TextEditingController a = TextEditingController();
  search() {
    searchlist.clear();
    responselist.forEach((search) {
      if (search['title'].contains(a.text) == true) {
        setState(() {
          searchlist.add(search);
        });
      }
    });

    print(searchlist);
  }

  deletedata(String id) async {
    var body = {
      'id': id,
    };
    Response response = await post(
        Uri.parse('http://192.168.1.34:8080/removeNotes'),
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      print(response.statusCode);
      var boh = jsonDecode(response.body);
      print(response.body);
      if (boh['message'] == 'deleted') {
        setState(() {});
      }
    }
  }

  getdata() async {
    Response response =
        await get(Uri.parse('http://192.168.1.34:8080/getNotes'));
    if (response.statusCode == 200) {
      var boy = jsonDecode(response.body);
      print(response.body);
      setState(() {
        responselist = boy['message'];
      });
      return boy;
    }
  }

  bool isclicked = false;

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Tds(),
          ));
        },
        child: Text('+'),
        backgroundColor: Colors.yellow,
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.only(left: 120),
          child: Icon(Icons.note_alt_sharp),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 140),
          child: Icon(Icons.speaker_notes_outlined),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Icon(Icons.adjust_rounded),
          ),
        ],
      ),
      body: SizedBox(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: a,
                onChanged: (f){

                  setState(() {
                    isclicked=true;
                  });
                  search();

                },
                decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
        isclicked== false ?    Expanded(
              child: ListView.builder(
                  itemCount: responselist.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Edit(
                              cons: responselist[index]['title'],
                              data: responselist[index]['content'],
                              id: responselist[index]['id'].toString(),
                            ),
                          ));
                        },
                        child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.black12),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Text(responselist[index]['title']),
                                  Text(responselist[index]['content'])
                                ],
                              ),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () {
                                      deletedata(
                                          responselist[index]['id'].toString());
                                    },
                                    child: Container(
                                      child: Icon(Icons.delete),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ):SizedBox(),

            isclicked== true ?      Expanded(
              child: ListView.builder(
                  itemCount: searchlist.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Edit(
                              cons: searchlist[index]['title'],
                              data: searchlist[index]['content'],
                              id: searchlist[index]['id'].toString(),
                            ),
                          ));
                        },
                        child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.black12),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Text(searchlist[index]['title']),
                                  Text(searchlist[index]['content'])
                                ],
                              ),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap: () {
                                      deletedata(
                                          searchlist[index]['id'].toString());
                                    },
                                    child: Container(
                                      child: Icon(Icons.delete),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ):SizedBox(),
          ],
        ),
      ),
    );
  }
}
