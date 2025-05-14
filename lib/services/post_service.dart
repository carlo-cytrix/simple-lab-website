import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostService {
  final posts = FirebaseFirestore.instance.collection('posts');

  Future<void> addPost(String title, String content) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    await posts.add({
        'title': title,
        'content': content,
        'created_at': Timestamp.now(),
        'userId': uid,
    });
  }


  Future<void> updatePost(String id, String title, String content) async {
    await posts.doc(id).update({'title': title, 'content': content});
  }

  Future<void> deletePost(String id) async {
    await posts.doc(id).delete();
  }

  Stream<QuerySnapshot> getUserPosts() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return posts.where('userId', isEqualTo: uid).orderBy('created_at', descending: true).snapshots();
  }

}
