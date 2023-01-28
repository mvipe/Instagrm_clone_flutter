import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                backgroundImage: NetworkImage(""),
              ),

              Expanded(child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                        Text("username",style: TextStyle(fontWeight: FontWeight.bold),),
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
          SizedBox(
            height: MediaQuery.of(context).size.height*0.35,
            width: double.infinity,
            child: Image.network("",fit: BoxFit.cover,),
          ),

          //Like comment section
          Row(
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.favorite,color: Colors.red,)),
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
                  child: Text('1,231 Likes',style: Theme.of(context).textTheme.bodyText2,)),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 8
                    ),
                    child: RichText(text: TextSpan(style: const TextStyle(color: primaryColor),
                        children: [
                          TextSpan(text: 'username',
                          style: const TextStyle(fontWeight: FontWeight.bold)),

                          TextSpan(text: '   Hey this is some description',
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
                      child: Text('22/12/2022',style: const TextStyle(fontSize: 16,color: secondaryColor),),
                    ),
              ]),
          )



        
      ]),
    );
  }
}