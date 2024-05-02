import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noteapp/class/note_class.dart';
import 'package:noteapp/pages/home.dart';

class AddNote extends StatefulWidget {
  Function(List) onChanged;
  AddNote({super.key, required this.onChanged});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  bool isSubmit = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AddNote"),
        backgroundColor: Colors.orange[300],
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          SizedBox(
            // height: 300,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              // title
              child: TextField(
                controller: titleController,
                maxLines: 2,
                maxLength: 60,
                // overflow: TextOverflow.ellipsis,
                decoration: InputDecoration(
                    hintText: "Flutter Learner",
                    labelText: "Add title",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide())),
              ),
            ),
          ),

          // body
          SizedBox(height: 30),
          SizedBox(
            // height: 300,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: bodyController,
                maxLines: 10,
                maxLength: 260,
                decoration: InputDecoration(
                    hintText:
                        "I am flutter learn who is learning flutter .....",
                    labelText: "Add Body",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide())),
              ),
            ),
          ),
          // TextField(),

          // button

          SizedBox(
            height: 50,
            width: 300,
            child: ElevatedButton(
              onPressed: () async {
                print("add note submit");

                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    actions: [
                      TextButton(
                        onPressed: () {
                          isSubmit = false;
                          Navigator.of(context).pop();
                          // return;
                          // print("close");
                        },
                        child: Text("close"),
                      ),
                      TextButton(
                        onPressed: () {
                          isSubmit = true;
                          Navigator.of(context).pop();
                          print("submit");
                        },
                        child: Text("submit"),
                      ),
                    ],
                    title: Text("Sure!"),
                    content: Text("Are you sure! you want to add note"),
                    // contentPadding: EdgeInsets.all(10),
                  ),
                );

                if (isSubmit &&
                    titleController.text != "" &&
                    bodyController.text != "") {
                  widget.onChanged([titleController.text, bodyController.text]);
                  Navigator.pop(context);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Ok!"),
                        ),
                      ],
                      title: Text("Pagal"),
                      content: Text("Title or Body fill is empty!"),
                      contentPadding: EdgeInsets.all(30),
                    ),
                  );
                  return;
                }
              },
              child: Text("Submit"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
