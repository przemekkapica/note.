import 'package:note/data/model/entity/item.dart';
import 'package:note/data/service/item_service.dart';

class ItemRepository {
  ItemRepository({required this.itemService});

  final ItemService itemService;

  Stream<List<Item>> fetchItems() {
    var collection = itemService.getItemsCollection();
    return collection
        .orderBy('created', descending: true)
        .snapshots()
        .map((event) {
      var items = <Item>[];
      event.docs.forEach((doc) {
        items.add(
          Item(
            DateTime.fromMillisecondsSinceEpoch(doc.data()['created'],
                isUtc: true),
            doc.data()['name'].toString().trim(),
            doc.data()['note'].toString().trim(),
            doc.data()['url'].toString().trim(),
          ),
        );
      });
      return items;
    });
  }

  Future addItem(Item item) async {
    var collection = itemService.getItemsCollection();

    item.created = DateTime.now();
    await collection.add({
      'created': item.created.toUtc().millisecondsSinceEpoch,
      'name': item.name.trim(),
      'note': item.note!.trim(),
      'url': addUrlPrefix(item.url!.trim()),
    });
  }

  String addUrlPrefix(String url) {
    if (!(url.startsWith('https://') ||
        url.startsWith('www') ||
        url.startsWith('http://'))) {
      url = 'https://' + url;
    }
    return url;
  }
}
