import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:noteapp/class/note_class.dart';
import 'package:noteapp/pages/add_page.dart';
import 'package:noteapp/pages/edit_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<NoteApp> noteList = [
  //   NoteApp(title: "firstone", body: "FirstOne body"),
  //   NoteApp(
  //       title: "secondone",
  //       body:
  //           "secondOne body this not a week point it's also a fixed point in current situtaion"),
  // ];
  List<NoteApp> noteList = [];

  late SharedPreferences shPref;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    shPref = await SharedPreferences.getInstance();

    List<String>? getList = shPref.getStringList('myData')!.toList();

    if (getList != null) {
      print("Get list: ${getList}");
      noteList = getList.map((items) {
        return NoteApp.fromJson(jsonDecode(items));
      }).toList();
      print("NoteList ${noteList}");
    }
    setState(() {});
  }

  void SaveData() {
    List<String> noteItemString =
        noteList.map((items) => jsonEncode(items.toJson())).toList();
    shPref.setStringList('myData', noteItemString);
  }

  bool isWantDelete = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NoteApp"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: [
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "${noteList[index].title.toString()}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text("${noteList[index].body.toString()}"),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () async {
                            // print("${noteList[index]}");

                            await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      isWantDelete = false;
                                      Navigator.pop(context);
                                    },
                                    child: Text("No!"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      isWantDelete = true;
                                      Navigator.pop(context);
                                    },
                                    child: Text("Yes!"),
                                  ),
                                ],
                                title: Text("Sure!"),
                                content: Text(
                                    "Are you want to delete Note with\n title:${noteList[index].title.toString()} \n body:${noteList[index].body.toString()} "),
                                contentPadding: EdgeInsets.all(20),
                              ),
                            );

                            print("${isWantDelete.toString()}");
                            if (isWantDelete) {
                              noteList.remove(noteList[index]);
                              print("${isWantDelete.toString()}");
                              setState(() {});
                              SaveData();
                            }
                          },
                          icon: Icon(Icons.delete),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return EditPage(
                                    onChanged: (value) {
                                      // print("${value.first.toString()}");
                                      // print("${value.last.toString()}");
                                      noteList[index].title = value.first;
                                      noteList[index].body = value.last;
                                      setState(() {});
                                      SaveData();
                                    },
                                    titleText: noteList[index].title.toString(),
                                    bodyText: noteList[index].body.toString(),
                                  );
                                },
                              ),
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: noteList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return AddNote(
                onChanged: (value) {
                  // print("$value");
                  // print(value.first);
                  noteList.add(NoteApp(title: value.first, body: value.last));
                  setState(() {});
                  SaveData();
                },
              );
            },
          ));
        },
        child: Icon(Icons.add),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.cen,
    );
  }
}
