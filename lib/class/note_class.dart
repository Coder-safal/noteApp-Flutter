import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class NoteApp {
  String? title;
  String? body;

  NoteApp({this.title = "This is title", this.body = "This is body"});

  Object? toJson() {
    return {
      "title": title,
      "body": body,
    };
  }

  factory NoteApp.fromJson(jsonDecode) {
    // print(jsonDecode);
    print("title ${jsonDecode['title']}");
    print("body ${jsonDecode['body']}");
    return NoteApp(body: jsonDecode['title'], title: jsonDecode['body']);
    // return jsonDecode;
  }

  // factory NoteApp.fromJson(jsonDecode) {
  //   return NoteApp(jsonDecode['title'], jsonDecode['body']);
  // }

  // factory NoteApp.fromJson(decode) {
  //   return NoteApp(decode['title'], decode['body']);
  // }
  // factory NoteApp.fromJson(jsonDecoder){
  //   return NoteApp(jsonDecode['title'],jsonDecode['body']);
  // }
}
