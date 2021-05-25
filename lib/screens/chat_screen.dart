import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/UmVNADKYs14JuVrL01Li/messages')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final docs = streamSnapshot.data.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(docs[index]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/UmVNADKYs14JuVrL01Li/messages')
              .add({'text': 'This was added by Elfr3on El34k!'});
        },
      ),
    );
  }
}
