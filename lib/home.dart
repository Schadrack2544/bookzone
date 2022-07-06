import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

var contents = ['comic', 'Adventures'];
var contentValue;
var courses = ['Maths', 'Science'];
var courseValue;
var grades = ['grade 1', 'grade 2', 'grade 3', 'grade 4', 'grade 5', 'grade 6'];
var gradeValue;

class _HomeState extends State<Home> {
  Future getBooks() async {
    var booksData =
        await http.get(Uri.parse("http://localhost:5005/api/v1/books"));
    List<Map<String, dynamic>> booksList = [];

    var booksJson = jsonDecode(booksData.body)['result'] as List;

    // print("Igerageza" + booksJson.toString());
  }

  @override
  Widget build(BuildContext context) {
    getBooks();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Column(children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage("assets/images/homebackground.png"),
                    fit: BoxFit.cover,
                  )),
              child: Center(
                child: Text("Augmented Library of your learning contents",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              )),
          Container(
              margin: EdgeInsets.all(12.0),
              child: Column(children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text("Filter")
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.dashboard),
                            Text("Content"),
                          ],
                        ),
                        DropdownButton(
                          dropdownColor: Colors.yellow,
                          // Initial Value
                          value: contents[0],

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: contents.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              contentValue = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.dashboard),
                            Text("Courses"),
                          ],
                        ),
                        DropdownButton(
                          dropdownColor: Colors.yellow,
                          // Initial Value
                          value: courses[0],

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: courses.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              courseValue = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.dashboard),
                            Text("grade"),
                          ],
                        ),
                        DropdownButton(
                          dropdownColor: Colors.yellow,
                          // Initial Value
                          value: grades[0],

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: grades.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              gradeValue = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: FutureBuilder(
                      initialData: [],
                      future: getBooks(),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          return Center(
                            child: Text("No data to show"),
                          );
                        } else {
                          return Card(
                              child: Column(
                            children: [
                              Row(children: [
                                Container(
                                  width:MediaQuery.of(context).size.width*0.45,
                                  height:MediaQuery.of(context).size.height*0.15,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/image.png"),
                                          fit: BoxFit.cover,
                                        ))),
                                Container(
                                    width:MediaQuery.of(context).size.width*0.45,
                                    height:MediaQuery.of(context).size.height*0.15,
                                    color: Color(0xff193059),
                                    child: Center(
                                        child: Text(
                                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit")))
                              ]),
                              Row(children: [
                                Column(
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      
                                      children: [
                                      Text("The ABCS  of Rwanda"),
                                      IconButton(
                                        icon: Icon(Icons.zoom_in_map),
                                        onPressed: () {},
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.speaker_notes_rounded),
                                        onPressed: () {},
                                      )
                                    ]),
                                    Text("Author: ImagineWe Pub"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(children: [
                                      Icon(Icons.money_rounded),
                                      Text("500 Frw"),
                                      GestureDetector(
                                          child: Row(
                                        children: [
                                          Icon(Icons.shopping_cart),
                                          Text("BUY")
                                        ],
                                      ))
                                    ])
                                  ],
                                )
                              ])
                            ],
                          ));
                        }
                      })),
                )
              ])),
        ]),
      ),
    );
  }
}
