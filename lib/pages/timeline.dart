import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/widgets/header.dart';
import 'package:flutter_share/widgets/progress.dart';

final usersRef = Firestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  void initState() {
    createUser();
    updateUser();
    deleteUser();
    // getUserById();
    super.initState();
  }

  createUser() {
    usersRef.document("assdfjg").setData({
      "username": "jeff",
      "postsCount": 0,
      "isAdmin": false,
    });
  }

  updateUser() {
    usersRef.document("Khan").setData({
      "username": "NAHK",
      "postsCount": 100000,
      "isAdmin": false,
    });
  }

  deleteUser() {
    usersRef.document("assdfjg").delete();
  }

  // getUserById() async {
  //   final String id = "uOdqRdYS3DF85Vl3SOlh";
  //   final DocumentSnapshot doc = await usersRef.document(id).get();
  //   print(doc.data);
  //   print(doc.documentID);
  //   print(doc.exists);
  // }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return circularProgress();
          }
          final List<Text> children = snapshot.data.documents
              .map((doc) => Text(doc['username']))
              .toList();
          return Container(
            child: ListView(
              children: children,
            ),
          );
        },
      ),
    );
  }
}
