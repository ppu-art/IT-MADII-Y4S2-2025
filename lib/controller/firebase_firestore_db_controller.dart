import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirebaseFirestoreDBController extends GetxController {
  static String newsCollectionPath = "news";
  static String facultyCollectionPath = "faculty";

  final _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getData(String collectionPath) async {
    List<Map<String, dynamic>> datas = [];
    QuerySnapshot querySnapshot = await _firestore
        .collection(collectionPath)
        .get();
    for (var doc in querySnapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      data["id"] = doc.id;
      datas.add(data);
    }
    return datas;
  }

  Future<void> createData(
    String collectionPath,
    Map<String, dynamic> data,
  ) async {
    await _firestore
        .collection(collectionPath)
        .add(data)
        .then((documentReference) {
          print("Document added with ID: ${documentReference.id}");
        })
        .catchError((error) {
          print("Failed to add document: $error");
        });
  }

  Future<void> deleteData(String collectionPath, String id) async {
    await _firestore
        .collection(collectionPath)
        .doc(id)
        .delete()
        .then((documentReference) {
          print("Document deleted with ID: ${id}");
        })
        .catchError((error) {
          print("Failed to deleted document: $error");
        });
  }
}
