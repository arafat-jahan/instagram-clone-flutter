import 'dart:typed_data'; // 1️⃣ image/file data byte akare handle korar jnno
import 'package:firebase_auth/firebase_auth.dart'; // 2️⃣ user info (ID) anar jnno
import 'package:firebase_storage/firebase_storage.dart'; // 3️⃣ Firebase storage use korar jnno
import 'package:flutter/material.dart'; // 4️⃣ Flutter UI r basic tools

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance; // 5️⃣ ekta storage object nilam
  final FirebaseAuth _auth = FirebaseAuth.instance; // 6️⃣ ekta auth object nilam

  // 7️⃣ Image upload korar jnno method
  Future<String> uploadImageToStorage(String childName, Uint8List file, bool isPost) async {

    // 8️⃣ ekta specific folder path banacchi:
    Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);

    // 9️⃣ oi folder e file upload korchi
    UploadTask uploadTask = ref.putData(file);

    // 1️⃣0️⃣ wait kortesi upload complete howar jnno
    TaskSnapshot snap = await uploadTask;

    // 1️⃣1️⃣ upload hoile tar download URL nicchi
    String downloadUrl = await snap.ref.getDownloadURL();

    // 1️⃣2️⃣ sei URL return kortesi
    return downloadUrl;
  }
}
