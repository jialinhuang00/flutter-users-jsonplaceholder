import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:users/app/data/models/user.dart';
import 'package:users/pages/HomePage.dart';
void main() => runApp(const UserListApp());

class UserListApp extends StatelessWidget {
  const UserListApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOCK USERS LIST',
      theme: ThemeData(
        scaffoldBackgroundColor:Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: false,
        fontFamily: "Inconsolata",
      ),
      home: const HomePage(title: 'Users List'),
    );
  }
}

