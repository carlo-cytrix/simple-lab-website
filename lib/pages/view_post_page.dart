import 'package:flutter/material.dart';

class ViewPostPage extends StatelessWidget {
  const ViewPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Post')),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text('This is the content of the post.'),
      ),
    );
  }
}
