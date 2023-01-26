import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List followings;

  const User({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.username,
    required this.bio,
    required this.followers,
    required this.followings
  });

  Map<String,dynamic> toJson()=>{
          'username': username,
          'uid': uid,
          'email': email,
          'bio': bio,
          'followers': followers,
          'followings': followings,
          'photoUrl':photoUrl
  };

  static User fromSnap(DocumentSnapshot snap){
    print(snap.data());
    var snapshot=snap.data() as Map<String,dynamic>;

    User user1= User(
          email: snapshot['email'], 
          uid: snapshot['uid'],
          photoUrl: snapshot['photoUrl'],
          username: snapshot['username'], 
          bio: snapshot['bio'], 
          followers: snapshot['followers'],
          followings: snapshot['followings']);

    



          return user1;
  }
}