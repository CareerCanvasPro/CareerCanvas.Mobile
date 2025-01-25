// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class GoogleGmailSignUp extends StatefulWidget {
//   @override
//   _GoogleGmailSignUpState createState() => _GoogleGmailSignUpState();
// }

// class _GoogleGmailSignUpState extends State<GoogleGmailSignUp> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   Future<User?> _signInWithGoogle() async {
//     try {
//       // Trigger the Google Sign-In flow
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) {
//         // User canceled the sign-in
//         return null;
//       }

//       // Obtain the Google authentication details
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       // Create a new credential
//       final OAuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       // Sign in to Firebase with the credential
//       final UserCredential userCredential =
//           await _auth.signInWithCredential(credential);

//       return userCredential.user;
//     } catch (e) {
//       print('Error signing in with Google: $e');
//       return null;
//     }
//   }

//   void _signOut() async {
//     await _auth.signOut();
//     await _googleSignIn.signOut();
//     print("User signed out.");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Google Sign-In"),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             User? user = await _signInWithGoogle();
//             if (user != null) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Welcome, ${user.displayName}!')),
//               );
//             } else {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Sign-In Failed')),
//               );
//             }
//           },
//           child: Text("Sign in with Google"),
//         ),
//       ),
//     );
//   }
// }
