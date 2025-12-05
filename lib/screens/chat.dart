import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});
  // final _auth = FirebaseAuth.instance;
  @override
  State<Chat> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<Chat> {
  final _msgController = TextEditingController();

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
  }

  void sendMessage() {
    final msg = _msgController.text;
    if (msg.trim().isEmpty) {
      return;
    }
    print('dfdsf');
    final userId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('messages').add({
      'text': msg,
      'createdAt': Timestamp.now(),
      'userId': userId,
      'username': 'Firas',
    });
    _msgController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.exit_to_app, color: Colors.deepPurple, size: 32),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: const Center(child: Text('Chat Messages Here'))),
          Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    decoration: const InputDecoration(
                      labelText: 'Send a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    sendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
