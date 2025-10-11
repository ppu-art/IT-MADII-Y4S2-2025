import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class FirebaseRealtimeDBController extends GetxController {
  final db = FirebaseDatabase.instance;

  static String userRefId = "users";
  static String menuRefId = "menu";
  static String newsRefId = "news";
  static String facultyRefId = "faculty";

  Future<Map<dynamic, dynamic>> getRealtimeDB(String refId) async {
    final snapshot = await db.ref(refId).get();
    return snapshot.value as Map<dynamic, dynamic>;
  }

  Future<void> createRealtimeDB(
    String refId,
    Map<String, Object> dataReq,
  ) async {
    await db.ref(refId).push().set(dataReq);
  }

  Future<void> updateRealtimeDB(
    String id,
    String refId,
    Map<String, Object> dataReq,
  ) async {
    await db.ref("$refId/$id").push().set(dataReq);
  }

  Future<void> deleteRealtimeDB(String id, String refId) async {
    await db.ref("$refId/$id").remove();
  }
}
