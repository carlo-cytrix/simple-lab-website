import 'package:flutter/material.dart';
import '../services/post_service.dart';

class EditPostPage extends StatelessWidget {
  const EditPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final id = args?['id'];
    final titleController = TextEditingController(text: args?['title']);
    final contentController = TextEditingController(text: args?['content']);
    final postService = PostService();

    return Scaffold(
      appBar: AppBar(title: Text(id == null ? 'New Post' : 'Edit Post')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: contentController, maxLines: 5, decoration: const InputDecoration(labelText: 'Content')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (id == null) {
                  await postService.addPost(titleController.text, contentController.text);
                } else {
                  await postService.updatePost(id, titleController.text, contentController.text);
                }
                Navigator.pop(context);
              },
              child: Text(id == null ? 'Save' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}
