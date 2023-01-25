import 'package:js/js.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';

// import 'package:instagram_clone/provider/user_provider.dart';

// import 'package:provider/provider.dart';

// import 'package:instagram_clone/models/user.dart' as model;

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String username="";
   int _page=0;
   late  PageController pageController;

   @override
  void initState() {
    pageController=PageController();
    super.initState();
  }

  @override
  void dispose() {
   
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page){
    print(page);
      pageController.jumpToPage(page);
  }


void onPageChanged(int page){
  setState(() {
    _page=page;
  });
}
  

  @override
  Widget build(BuildContext context) {
   

   


    return Scaffold(
        body:PageView(
          
          children: [
              Text("1 ztC4QvtvOdSkk9yJKK3valKUX2, photoUrl: https://firebasestorage.googleap"),
              Text("2"),
              Text("3ztC4QvtvOdSkk9yJKK3valKUX2, photoUrl: https://firebasestorage.googleap"),
              Text("4"),
              Text("5"),
          ],
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
         onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: CupertinoTabBar(
          
          backgroundColor: mobileBackgroundColor,
            items:[
              BottomNavigationBarItem(icon: Icon(Icons.home
              ,color: _page==0?primaryColor:secondaryColor,),
              label: '',backgroundColor: primaryColor),

              BottomNavigationBarItem(icon: Icon(Icons.search,color: _page==1?primaryColor:secondaryColor),
              label: '',backgroundColor: primaryColor),

               BottomNavigationBarItem(icon: Icon(Icons.add_circle,color: _page==2?primaryColor:secondaryColor),
              label: '',backgroundColor: primaryColor),

               BottomNavigationBarItem(icon: Icon(Icons.favorite,color: _page==3?primaryColor:secondaryColor),
              label: '',backgroundColor: primaryColor)

              , BottomNavigationBarItem(icon: Icon(Icons.person,color: _page==4?primaryColor:secondaryColor),
              label: '',backgroundColor: primaryColor)
            ],
            onTap: navigationTapped,
         ),
    );
  }
  
}
