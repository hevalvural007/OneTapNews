import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ot_news/data/entity/article.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatefulWidget {
  final Article article;

  const DetailsScreen(this.article, {super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final Color primaryColor = const Color(0xFFEB4A7B);
  final Color secondaryColor = const Color(0xFF5A2E98);

  final TextEditingController tfComment = TextEditingController();


  void sendComment() async{
    final user = FirebaseAuth.instance.currentUser;


    if(user == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("You have to log in to share a comment")));
      return;
    }

    if(tfComment.text.trim().isEmpty) return;
    try{
      String nameToShow = "Unknown User";

      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if(userDoc.exists){
        nameToShow = userDoc.get('username') ?? 'Unknown User';
      }
      if(!mounted) return;
      String commentToSend = tfComment.text.trim();
      tfComment.clear();
      FocusScope.of(context).unfocus();



      await FirebaseFirestore.instance.collection('comments').add({
        'articleUrl': widget.article.url,
        'comment' : commentToSend,
        'username': nameToShow,
        'createdAt': FieldValue.serverTimestamp()
      });
    }
    catch(e){
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error occurred while posting the comment: $e")));
    }
  }

  Future<void> openNewsUrl() async {
    if (widget.article.url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cannot Reach The Website")),
      );
      return;
    }
    final Uri url = Uri.parse(widget.article.url);

    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
        enableJavaScript: true,
      ),
    )) {
      throw 'Cannot Reach The Website: ${widget.article.url}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: Image.network(
                    widget.article.urlToImage.isNotEmpty
                        ? widget.article.urlToImage
                        : "https://via.placeholder.com/400",
                    height: 280,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 280,
                      color: Colors.grey[300],
                      child: const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
                shadowColor: Colors.black.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.article.title,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                          height: 1.2,
                          fontFamily: 'Roboto',
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 16),

                      Row(
                        children: [
                          const Icon(Icons.person_outline, size: 18, color: Colors.grey),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              widget.article.author.isNotEmpty
                                  ? widget.article.author
                                  : "Unknown",
                              style: TextStyle(
                                fontSize: 13,
                                color: secondaryColor.withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.access_time, size: 18, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            widget.article.publishedAt.split("T").first,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Divider(thickness: 1, height: 1),
                      ),

                      Text(
                        widget.article.description,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500, //
                          color: Colors.black87,
                          height: 1.5, //
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.article.content,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [primaryColor, secondaryColor],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: openNewsUrl,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Read Full Article",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Comments",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: secondaryColor
                ),
              ),
            ),
            commentList(),
            const SizedBox(height: 80,)
          ],
        ),
      ),
      bottomSheet: commentInputArea(),
    );
  }
  Widget commentList(){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('comments')
          .where('articleUrl',isEqualTo: widget.article.url)
          .orderBy('createdAt',descending: true)
          .snapshots(),
      builder: (context,snapshot){
        if(snapshot.hasError) return const Text("An error occurred when uploading the comments");
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(color: Colors.black,),);
        }
        final comments = snapshot.data!.docs;
        if(comments.isEmpty){
          return const Padding(
            padding: EdgeInsets.all(12),
            child: Text("No comments yet!",style: TextStyle(color: Colors.grey),),
          );
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: comments.length,
          separatorBuilder: (ctx,index) => const SizedBox(height: 10,),
          itemBuilder: (context,index){
            var data = comments[index].data() as Map<String,dynamic>;
            return Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5)],
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
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Text(data['comment'] ?? '',style: TextStyle(fontSize: 15),)
                ],
              ),
            );
          },

        );
      },
    );
  }
  Widget commentInputArea() {
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
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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