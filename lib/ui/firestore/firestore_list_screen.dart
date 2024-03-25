import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/ui/auth/login_screen.dart';
import 'package:login_app/ui/firestore/add_firestore_data_screen.dart';
import 'package:login_app/utils/utils.dart';

class FirestoreListScreen extends StatefulWidget {
  const FirestoreListScreen({super.key});

  @override
  State<FirestoreListScreen> createState() => _FirestoreListScreenState();
}

class _FirestoreListScreenState extends State<FirestoreListScreen> {
  final auth = FirebaseAuth.instance;
  TextEditingController editController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('users').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('users');

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
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: fireStore,
                  builder: (BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot){

                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center( child:  CircularProgressIndicator());
                    }
                    if(snapshot.hasError){
                      return const Text('Error Occurred!');
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index){
                          return ListTile(
                            onTap: (){

                            },
                            title: Text(snapshot.data!.docs[index]['message'].toString()),
                            subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
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
                                          myDialogBox(snapshot.data!.docs[index]['message'].toString(),
                                              snapshot.data!.docs[index]['id'].toString());
                                        },
                                      )
                                  ),
                                  PopupMenuItem(
                                    value: 2,
                                    child: ListTile(
                                      title: const Text('Delete'),
                                      leading: const Icon(Icons.delete, color: Colors.red,),
                                      onTap: (){
                                        ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                                        Utils().toastMessage('message deleted successfully!');
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ]
                            ),
                          );
                        });
                  }
              ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddFirestoreDataScreen()));
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
              TextButton(onPressed: (){
                Navigator.pop(context);
                }, child: const Text('Cancel')),
              TextButton(onPressed: (){
                Navigator.pop(context);
                FirebaseFirestore.instance.collection('users').doc(id).
                update({
                  'message' : editController.text.toString(),
                }
                ).then((value){
                  Utils().toastMessage('message updated');
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
                    },child: const Text('Update')),
            ],
          );
        }
    );
  }
}