import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';



class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    }
    catch(e){
      print("Login Error $e");
      return null;
    }
  }

  Future<User?> signUp(String email, String password,String username) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      if(result.user != null){
        await _firestore.collection('users').doc(result.user!.uid).set({
          'email': email,
          'username' : username,
          'uid' : result.user!.uid,
          'createdAt' : FieldValue.serverTimestamp(),
        });

        return result.user;
      }
      return null ;
    }
    catch(e){
      print("Sign Up Error $e");
      return null;
    }
  }

  Future<User?> signInWithGoogle() async{
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if(googleUser == null) return null;

      final GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if(user != null){
        final userDoc = await _firestore.collection('users').doc(user.uid).get();

        if(!userDoc.exists){
          await _firestore.collection('users').doc(user.uid).set({
            'email':user.email,
            'username':user.displayName,
            'uid':user.uid,
            'createdAt':FieldValue.serverTimestamp(),
          });
        }
      }
      return user;

      }
      catch(e){
        print("Google Sign Up Error $e");
        return null;
      }
  }
  Future<void> signOut() async{
    try{
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      print("sign out successfully");
    }
    catch(e){
      print("Sign out error $e");
    }
  }
}