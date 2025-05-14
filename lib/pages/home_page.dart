import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/post_service.dart';
import '../widgets/sidebar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final postService = PostService();

    return Scaffold(
      drawer: const SideBar(),
      appBar: AppBar(title: const Text('Home')),
      body: StreamBuilder<QuerySnapshot>(
        stream: postService.getUserPosts(),
        builder: (context, snapshot) {
            if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text("No posts yet."));
            }

            final posts = snapshot.data!.docs;

            return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: posts.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                    final doc = posts[index];
                    final data = doc.data() as Map<String, dynamic>;

                    return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        title: Text(
                        data['title'] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(data['content'] ?? ''),
                        ),
                        trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                            IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                                Navigator.pushNamed(
                                context,
                                '/edit',
                                arguments: {
                                    'id': doc.id,
                                    'title': data['title'],
                                    'content': data['content'],
                                },
                                );
                            },
                            ),
                            IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                                await postService.deletePost(doc.id);
                            },
                            ),
                        ],
                        ),
                    ),
                    );
                },
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/edit'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
