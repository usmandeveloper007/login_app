import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:login_app/ui/auth/login_screen.dart';
import 'package:login_app/ui/posts/add_posts.dart';
import 'package:login_app/utils/utils.dart';
class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Posts');
  TextEditingController searchFilter = TextEditingController();
  TextEditingController editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Screen'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const LogInScreen()));
            }).onError((error, stackTrace){
              Utils().toastMessage(error.toString());
            });
          },
              icon: const Icon(Icons.logout_outlined)),
          const SizedBox(width: 10,)
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchFilter,
              decoration: const InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (String value){
                setState(() {

                });
              },
            ),
          ),
          const SizedBox(height: 20,),
          const Center(
            child: Text('Using Firebase Animated List',
              style: TextStyle(color: Colors.deepPurple, fontSize: 18),),),
          const SizedBox(height: 10,),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: const Center(child: CircularProgressIndicator(color: Colors.deepPurple,),),
                itemBuilder: (context, snapshot, animation, index){
                  final title = snapshot.child('message').value.toString();
                  final id = snapshot.child('id').value.toString();
                  if(searchFilter.text.isEmpty){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        tileColor: Colors.deepPurple[100],
                        title: Text(snapshot.child('message').value.toString()),
                        subtitle: Text(snapshot.child('id').value.toString()),
                        trailing: PopupMenuButton(
                          icon: const Icon(Icons.more_vert_outlined, color: Colors.deepPurple,),
                            itemBuilder: (context) => [
                               PopupMenuItem(
                                value: 1,
                                  child: ListTile(
                                    title: const Text('Edit'),
                                    leading: const Icon(Icons.edit, color: Colors.deepPurple,),
                                    onTap: (){
                                      Navigator.pop(context);
                                      myDialogBox(title, id);
                                    },
                                  )
                              ),
                               PopupMenuItem(
                                value: 2,
                                  child: ListTile(
                                    title: const Text('Delete'),
                                    leading: const Icon(Icons.delete, color: Colors.red,),
                                    onTap: (){
                                      ref.child(id).remove();
                                      Navigator.pop(context);
                                      Utils().toastMessage('message deleted successfully');
                                    },
                                  ),
                              ),
                            ]
                        ),
                      ),
                    );
                  } else if(title.toLowerCase().contains(searchFilter.text.toLowerCase())){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        tileColor: Colors.deepPurple[100],
                        title: Text(snapshot.child('message').value.toString()),
                        subtitle: Text(snapshot.child('id').value.toString()),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddPostsScreen()));
          },
        child: const Icon(Icons.add,),
      ),
    );
  }

  Future <void> myDialogBox (String title,id) async{
    editController.text = title;
    return showDialog(
        context: context,
        builder: (context){
          return  AlertDialog(
            title: const Text('Update'),
            content:  TextField(
              controller: editController,
              decoration: const InputDecoration(
                hintText: 'Update the message',
              ),
            ),
            actions: [
              TextButton(onPressed: (){Navigator.pop(context);}, child: const Text('Cancel')),
              TextButton(onPressed: (){
                ref.child(id).update({
                    'message' : editController.text
                  }
                ).then((value) {
                  Utils().toastMessage('message updated!');
                }).onError((error, stackTrace){
                  Utils().toastMessage(error.toString());
                });
                Navigator.pop(context);
                }, child: const Text('Update')),
            ],
          );
        }
    );
  }
}





















// const Center(
// child: Text('Using Stream Builder',
// style: TextStyle(color: Colors.deepPurple, fontSize: 18),),),
// const SizedBox(height: 10,),
// Expanded(
// child: StreamBuilder(
// stream: ref.onValue,
// builder: (context ,AsyncSnapshot <DatabaseEvent> snapshot){
// if(!snapshot.hasData){
// return const CircularProgressIndicator();
// } else if(snapshot.data!.snapshot.children.isEmpty ){
// if(snapshot.connectionState == ConnectionState.waiting){
// return const Center(child: CircularProgressIndicator(),);
// } return const Center ( child:  Text('There is no post in firebase!',
// style: TextStyle(color: Colors.red, fontSize: 16),));
// } else {
// Map <dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
// List<dynamic> list = [];
// list.clear();
// list = map.values.toList();
// return ListView.builder(
// itemCount: snapshot.data!.snapshot.children.length,
// itemBuilder: (context , index){
// return Padding(
// padding: const EdgeInsets.all(8.0),
// child: ListTile(
// shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
// tileColor: Colors.deepPurple[100],
// title: Text(list[index]['message']),
// subtitle: Text(list[index]['id']),
// ),
// );
// }
// );
// }
// }
// )),