import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profileImg
  ) async{
    String res="Some error occured.";
    try{
        String photoUrl=await StorageMethods().uploadImageToFirestore('posts', file, true);

        String postId=Uuid().v1();
        Post post=Post(description: description,
         uid: uid,
          username: username,
           postId: postId,
            datePublished: DateTime.now(),
             postUrl: photoUrl,
              profileImg: profileImg, 
              likes: []
              );

              _firestore.collection('posts').doc(postId).set(post.toJson());

              res="success";
    }catch(e){
      res=e.toString();

    }

    return res;
  }
}