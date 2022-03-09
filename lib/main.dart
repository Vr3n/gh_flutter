import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'strings.dart' as strings;

void main() {
  runApp(const GHFlutterApp());
}

class GHFlutterApp extends StatelessWidget {
  const GHFlutterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: strings.appTitle,
      home: const GHFullter(),
    );
  }
}

class GHFullter extends StatefulWidget {
  const GHFullter({Key? key}) : super(key: key);

  @override
  State<GHFullter> createState() => _GHFullterState();
}

class _GHFullterState extends State<GHFullter> {
  var _members = <dynamic>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Future<void> _loadData() async {
    const dataUrl = 'https://api.github.com/orgs/raywenderlich/members';
    final response = await http.get(Uri.parse(dataUrl));
    setState(() {
      _members = json.decode(response.body) as List;
    });
  }

  Widget _buildRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListTile(
          title: Text(
        '${_members[i]["login"]}',
        style: _biggerFont,
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(strings.appTitle),
      ),
      body: ListView.separated(
        itemCount: _members.length,
        itemBuilder: (BuildContext context, int position) {
          return _buildRow(position);
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }
}
