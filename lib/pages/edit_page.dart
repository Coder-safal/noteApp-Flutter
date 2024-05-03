import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  String titleText;
  String bodyText;
  Function(List) onChanged;
  EditPage({
    super.key,
    required this.titleText,
    required this.bodyText,
    required this.onChanged,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController titleContoller = TextEditingController();
  TextEditingController bodyContoller = TextEditingController();
  bool isUpdate = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleContoller.text = widget.titleText;
    bodyContoller.text = widget.bodyText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit page"),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: titleContoller,
              maxLines: 2,
              maxLength: 80,
              decoration: InputDecoration(
                labelText: "title",
                hintText: titleContoller.text,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          // Body
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: bodyContoller,
              maxLines: 4,
              maxLength: 260,
              decoration: InputDecoration(
                // Text: "title",
                labelText: "Body Message",
                hintText: bodyContoller.text,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(
            height: 50,
            width: 250,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      actions: [
                        TextButton(
                          onPressed: () {
                            isUpdate = false;
                            Navigator.pop(context);
                            return;
                          },
                          child: Text("cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            isUpdate = true;
                            Navigator.pop(context);
                          },
                          child: Text("Submit"),
                        ),
                      ],
                      title: Text("Update"),
                      content: Text("Are you sure are you want to update"),
                      contentPadding: EdgeInsets.all(10),
                    );
                  },
                );
                if (!isUpdate) {
                  Navigator.pop(context);
                  return;
                } else if (isUpdate &&
                    titleContoller.text != "" &&
                    bodyContoller.text != "") {
                  widget.onChanged([titleContoller.text, bodyContoller.text]);
                  Navigator.pop(context);
                } else {
                  if (titleContoller.text == "" && bodyContoller.text == "") {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("ok"),
                          ),
                        ],
                        title: Text("Are you understand!"),
                        content: Text(
                            "Body and Title is empty!\nplease fill the title"),
                        contentPadding: EdgeInsets.all(8),
                      ),
                    );
                  } else if (bodyContoller.text == "") {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("ok"),
                          ),
                        ],
                        title: Text("Are you understand!"),
                        content: Text("Body is empty!\nplease fill the title"),
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Ok"),
                          ),
                        ],
                        title: Text("Are you understand!"),
                        content: Text(
                          "Title is empty!\nplease fill the title",
                        ),
                        contentPadding: EdgeInsets.all(10),
                      ),
                    );
                  }
                  return;
                }
              },
              child: Text("Update"),
            ),
          )
        ],
      ),
    );
  }
}
