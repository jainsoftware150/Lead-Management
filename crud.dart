

import 'package:cloud_firestore/cloud_firestore.dart';

class CRUD {
     // craete(){
       final CollectionReference obj =  FirebaseFirestore.instance.collection("curd");

       Future<void> Creation(
           String name ,
           String email,
           String phn,
           String description
           ) {
         return  obj.add({
           "Name": name,
           "email": email,
           "phone": phn,
           "description" :description
         });

       }
      // Future<void>



       //Read
     Stream<QuerySnapshot> Reading(){
         return obj.snapshots();

     }
     //Delete
   Future<void> Delete(String id){
         return obj.doc(id).delete();
   }

}