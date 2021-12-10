import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note/data/service/auth_service.dart';

class ItemService {
  CollectionReference<Map<String, dynamic>> getItemsCollection() {
    return FirebaseFirestore.instance
        .collection('users/' + AuthService().user!.uid + '/items');
  }
}
