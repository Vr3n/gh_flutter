import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../types/member.dart';

import '../constants/strings.dart' as strings;

class GHFullter extends StatefulWidget {
  const GHFullter({Key? key}) : super(key: key);

  @override
  State<GHFullter> createState() => _GHFullterState();
}

class _GHFullterState extends State<GHFullter> {
  final _members = <Member>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Future<void> _loadData() async {
    const dataUrl = 'https://api.github.com/orgs/raywenderlich/members';
    final response = await http.get(Uri.parse(dataUrl));
    setState(() {
      final dataList = json.decode(response.body) as List;
      for (final item in dataList) {
        final login = item['login'] as String? ?? '';
        final avatarUrl = item['avatar_url'] as String? ?? '';
        final member = Member(login, avatarUrl);
        _members.add(member);
      }
    });
  }

  Widget _buildRow(int i) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.purple,
            backgroundImage: NetworkImage(_members[i].avatarUrl),
          ),
          title: Text(
            _members[i].login,
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
