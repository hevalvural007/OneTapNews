import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CommentInputArea extends StatefulWidget {
  final String articleUrl;

  const CommentInputArea({super.key, required this.articleUrl});

  @override
  State<CommentInputArea> createState() => _CommentInputAreaState();
}

class _CommentInputAreaState extends State<CommentInputArea> {
  final TextEditingController tfComment = TextEditingController();
  final Color primaryColor = const Color(0xFFEB4A7B);

  @override
  void dispose() {
    tfComment.dispose();
    super.dispose();
  }

  void sendComment() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You have to log in to share a comment")));
      return;
    }

    if (tfComment.text.trim().isEmpty) return;

    try {
      String nameToShow = "Unknown User";

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        nameToShow = userDoc.get('username') ?? 'Unknown User';
      }

      if (!mounted) return;

      String commentToSend = tfComment.text.trim();
      tfComment.clear();
      FocusScope.of(context).unfocus();

      await FirebaseFirestore.instance.collection('comments').add({
        'articleUrl': widget.articleUrl,
        'comment': commentToSend,
        'username': nameToShow,
        'createdAt': FieldValue.serverTimestamp()
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("An error occurred while posting the comment: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: tfComment,
              decoration: InputDecoration(
                hintText: "Enter your Comment...",
                fillColor: Colors.grey[100],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: primaryColor,
            radius: 24,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white, size: 20),
              onPressed: sendComment,
            ),
          ),
        ],
      ),
    );
  }
}