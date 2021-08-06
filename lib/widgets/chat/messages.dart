import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:massanger_app/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chat')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatData = chatSnapshot.data.docs;
              return ListView.builder(
                reverse: true,
                itemCount: chatData.length,
                itemBuilder: (ctx, index) => MessageBubble(
                  chatData[index]['text'],
                  chatData[index]['userName'],
                  chatData[index]['userImage'],
                  chatData[index]['userId'] == futureSnapshot.data.uid,
                  key: ValueKey(chatData[index].id),
                ),
              );
            });
      },
    );
  }
}
