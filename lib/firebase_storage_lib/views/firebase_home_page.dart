import 'package:flutter/material.dart';
import 'package:learn_github_actions/firebase_storage_lib/firebase_service/firebase_service.dart';

class FirebaseHomePage extends StatefulWidget {
  const FirebaseHomePage({super.key});

  @override
  State<FirebaseHomePage> createState() => _FirebaseHomePageState();
}

class _FirebaseHomePageState extends State<FirebaseHomePage> {
  FBServices firebaseService = FBServices();

  @override
  void initState() {
    firebaseService.getDeviceToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Firebase App')));
  }
}
