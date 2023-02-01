import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final  snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating=false;
  @override
  Widget build(BuildContext context) {
    
    final User user=Provider.of<UserProvider>(context).getUser;

    
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: [
        //Header section
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4
          ).copyWith(right: 0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(widget.snap['postImg']),
              ),

              Expanded(child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                        Text(widget.snap['username'],style: TextStyle(fontWeight: FontWeight.bold),),
                ]),
              )
              ),

              IconButton(onPressed: (){
                showDialog(context: context, builder: (context)=>Dialog(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    children: [
                      'Delete'
                    ].map((e) => InkWell(
                      onTap: () {
                        
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                        child: Text(e),
                      ),
                    )
                    ).toList(),
                  ),
                ),);
              }, icon: Icon(Icons.more_vert))
            ],
          ),

        
        ),
  //Image section
  
          GestureDetector(
          
            onDoubleTap: () async{
              await FirestoreMethods().likePost(
                widget.snap['postId'],
                user.uid,
                widget.snap['likes']
              );
              setState((){
                 isLikeAnimating=true;
              });

            },
            child: Stack(
              alignment: Alignment.center,
              children:[ SizedBox(
                height: MediaQuery.of(context).size.height*0.35,
                width: double.infinity,
                child: Image.network(widget.snap['postUrl'],fit: BoxFit.cover,),
              ),
          
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isLikeAnimating? 1 : 0,
                child: LikeAnimation(child: const Icon(Icons.favorite,color:Colors.white,size:100), isAnimating: isLikeAnimating,
                  duration: const Duration(milliseconds: 400),onEnd: (){
                    setState(() {
                      isLikeAnimating=false;
                    });
                  },),
              )
              ]
            ),
          ),

          //Like comment section
          Row(
            children: [
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid),
                smallLike: true,
                onEnd: (){
                  setState(() {
                    isLikeAnimating=true;
                  });
                },
                child: IconButton(onPressed: () async{
                      await FirestoreMethods().likePost(
                                      widget.snap['postId'],
                                      user.uid,
                                      widget.snap['likes']
                                    );
                }, icon: widget.snap['likes'].contains(user.uid)?
                const Icon(
                  Icons.favorite,color: Colors.red,): 
                  const Icon(
                  Icons.favorite_border,)
                  ) 
                  ),
              IconButton(onPressed: (){}, icon: Icon(Icons.comment_outlined,)),
               IconButton(onPressed: (){}, icon: Icon(Icons.send,)),

               Expanded(
                 child: Align(alignment: Alignment.bottomRight,
                 child: IconButton(icon: const Icon(Icons.bookmark_border),onPressed: (){},),
                 
               ),

               
               )
            ],
          ),

          //Description and number of likes
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.w800),
                  child: Text('${widget.snap['likes'].length} likes',style: Theme.of(context).textTheme.bodyText2,)),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 8
                    ),
                    child: RichText(text: TextSpan(style: const TextStyle(color: primaryColor),
                        children: [
                          TextSpan(text: widget.snap['username'],
                          style: const TextStyle(fontWeight: FontWeight.bold)),

                          TextSpan(text: ' ${widget.snap['description']}',
                          ),
                          
                        ])),
                  ),


                  InkWell(
                    onTap: (){},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text('View all 200 comments',style: const TextStyle(fontSize: 16,color: secondaryColor),),
                    ),
                  ),

                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(DateFormat.yMMMd().format(widget.snap['datePublished'].toDate()),style: const TextStyle(fontSize: 16,color: secondaryColor),),
                    ),
              ]),
          )



        
      ]),
    );
  }
}