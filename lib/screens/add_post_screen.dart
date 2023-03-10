import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController=TextEditingController();
  bool _isLoading=false;

  void postImage(
    String uid,
    String userName,
    String profImage
  ) async{
    setState(() {
      _isLoading=true;
    });
    try{

        String res= await FirestoreMethods().uploadPost(_descriptionController.text, _file!, uid, userName, profImage);

        if(res=='success'){
          
          setState(() {
      _isLoading=false;
    });
          showSnackbar("Posted",context);
          clearImage();
        }else{
          setState(() {
      _isLoading=false;
    });
          showSnackbar(res, context);
        }
    }catch(e){
showSnackbar(e.toString(), context);
    }

  }

  void clearImage(){
    setState(() {
      _file=null;
    });
  }

  _selectImage(BuildContext context){
    return showDialog(context: context, builder: (context){
      return SimpleDialog(
        title: const Text('Create a post'),
        children: [
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text("Take a photo"),
            onPressed: () async{
              Navigator.of(context).pop();
              Uint8List file=await pickImage(ImageSource.camera);
              setState(() {
                _file=file;
              });
            },
          ),

          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text("Choose from gallery"),
            onPressed: () async{
              Navigator.of(context).pop();
              Uint8List file=await pickImage(ImageSource.gallery);
              setState(() {
                _file=file;
              });
            },
          ),

          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text("Cancel"),
            onPressed: () async{
              Navigator.of(context).pop();
              
            },
          ),
        ],
      );

    }
    
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user=Provider.of<UserProvider>(context).getUser;

    

    return _file!=null ? Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(icon: const Icon(Icons.arrow_back)
        ,onPressed: clearImage,),
        title: const Text("Post to"),
        actions: [
          TextButton(onPressed: ()=>postImage(user.uid, user.username, user.photoUrl), child: const Text('Post',style: TextStyle(
            color:  Colors.blueAccent,
            fontWeight: FontWeight.bold,
            fontSize: 16
          ),))
        ],
      ),
      body: Column(
        children: [
          _isLoading?const LinearProgressIndicator():const Padding(padding: EdgeInsets.only(top: 0),),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(backgroundImage: NetworkImage(user.photoUrl),)
              ,SizedBox(
                width: MediaQuery.of(context).size.width*0.4,
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: "Write a caption ...",
                    border: InputBorder.none,
                    
                  ),
                  maxLines: 8,
                ),
              ),

              SizedBox(
                height: 45,
                width: 45,
                child: AspectRatio(
                  aspectRatio: 487/451,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: MemoryImage(_file!),
                       fit: BoxFit.fill,
                       alignment: FractionalOffset.topCenter
                       )
                      
                     ),
                  ),
                ),

              ),

              const Divider()
            ],
          )
        ],
      ),
       
    ):
    Center(
      child: IconButton(icon: const Icon(Icons.upload),
      onPressed: ()=>_selectImage(context),),
    );
  }
}