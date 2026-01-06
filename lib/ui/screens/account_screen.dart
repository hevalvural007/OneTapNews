import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ot_news/services/auth_service.dart';
import 'package:ot_news/ui/screens/login_screen.dart';
import 'package:ot_news/ui/widgets/info_card.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final Color primaryColor = const Color(0xFFEB4A7B);
  final Color secondaryColor = const Color(0xFF5A2E98);

  final authService = AuthService();
  final user = FirebaseAuth.instance.currentUser;

  final List<String> allCategories = ["Sports", "Finance", "Technology", "Politics","Turkish","Music"];
  List<String> selectedFavorites = [];
  bool isDataLoaded = false;

  void signOut(BuildContext context) async {
    await authService.signOut();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Sign Out Successfully"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> updateFavorites() async {
    if (user == null) return;
    try {
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
        'favoriteList': selectedFavorites
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Favorites Updated Successfully")));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("An error occurred while updating favorites")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: user == null
          ? const Center(child: Text("User Cannot Be Found"))
          : FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting && !isDataLoaded) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.black));
          }

          if (snapshot.hasError ||
              !snapshot.hasData ||
              !snapshot.data!.exists) {
            return const Center(child: Text("No data."));
          }

          if (!isDataLoaded) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            if (data['favoriteList'] != null) {
              selectedFavorites = List<String>.from(data['favoriteList']);
            }
            isDataLoaded = true;
          }

          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          String username = data['username'] ?? "User";
          String email = data['email'] ?? user!.email ?? "No Email";

          String joinedDate = "Unknown";
          if (data['createdAt'] != null) {
            Timestamp t = data['createdAt'];
            DateTime date = t.toDate();
            joinedDate = "${date.day}/${date.month}/${date.year}";
          }


          String initial = username.isNotEmpty
              ? username[0].toUpperCase()
              : "?";

          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 220,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [primaryColor, secondaryColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: secondaryColor.withOpacity(0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: -0,
                      child: Transform.translate(
                        offset: const Offset(0, 40),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[200],
                            child: Text(
                              initial,
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: secondaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                Text(
                  username,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[900],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Account Info",
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),

                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      InfoCard(
                          icon: Icons.email_outlined,
                          title: "E-mail Address",
                          value: email),
                      const SizedBox(height: 15),
                      InfoCard(
                          icon: Icons.calendar_month_outlined,
                          title: "Created At",
                          value: joinedDate),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Edit Favorites",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[900],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Center(
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          alignment: WrapAlignment.center,
                          children: allCategories.map((category) {
                            bool isSelected = selectedFavorites.contains(category);
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedFavorites.remove(category);
                                  } else {
                                    selectedFavorites.add(category);
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: isSelected ? secondaryColor : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isSelected
                                        ? secondaryColor
                                        : Colors.grey.shade300,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                    BoxShadow(
                                        color: secondaryColor.withOpacity(0.3),
                                        blurRadius: 5,
                                        offset: const Offset(0, 3))
                                  ]
                                      : [],
                                ),
                                child: Text(
                                  category,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey[700],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: updateFavorites,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                      ),
                      child: const Text(
                        "Update Favorites",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () => signOut(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.redAccent,
                        elevation: 2,
                        side: const BorderSide(
                            color: Colors.redAccent, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout),
                          SizedBox(width: 10),
                          Text(
                            "Sign Out",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}