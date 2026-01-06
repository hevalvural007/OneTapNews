import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentList extends StatelessWidget {
  final String articleUrl;
  final Color secondaryColor = const Color(0xFF5A2E98);

  const CommentList({super.key, required this.articleUrl});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('comments')
          .where('articleUrl', isEqualTo: articleUrl)
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("An error occurred when uploading the comments"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        }

        final comments = snapshot.data!.docs;

        if (comments.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              "No comments yet!",
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: comments.length,
          separatorBuilder: (ctx, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            var data = comments[index].data() as Map<String, dynamic>;
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: secondaryColor.withOpacity(0.2),
                        child: Icon(Icons.person, size: 16, color: secondaryColor),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        data['username'] ?? 'Unknown User',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey[800]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data['comment'] ?? '',
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}