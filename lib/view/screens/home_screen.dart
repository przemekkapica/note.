import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:note/data/repository/auth_repository.dart';
import 'package:note/data/repository/item_repository.dart';
import 'package:note/utils/constants.dart';
import 'package:note/data/model/entity/item.dart';
import 'package:note/view/widgets/page_padding.dart';
import 'package:note/view/widgets/popup_menu_button.dart';

class HomeScreen extends HookWidget {
  HomeScreen(
      {Key? key, required this.itemRepository, required this.authRepository})
      : super(key: key);

  final ItemRepository itemRepository;
  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      floatingActionButton: floatingActionButton(context),
      body: Container(
        child: PagePadding(
          child: StreamBuilder(
            stream: itemRepository.fetchItems(),
            builder: streamBuilder,
          ),
        ),
      ),
    );
  }

  Widget streamBuilder(context, snapshot) {
    if (!snapshot.hasData) {
      return Center(child: CircularProgressIndicator());
    }

    List<Item> list = snapshot.data as List<Item>;

    if (list.length == 0) {
      return Center(
        child: Text('You have not created any notes yet'),
      );
    }
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return itemCard(list, index, context);
      },
    );
  }

  Card itemCard(List<Item> list, int index, BuildContext context) {
    return Card(
      child: ListTile(
        leading: null,
        title: Text(list[index].name),
        subtitle: Text(
          DateFormat('MMM d | h:mma').format(list[index].created).toString(),
        ),
        onTap: () async => await navigateToDetailsScreen(context, list, index),
      ),
    );
  }

  Future navigateToDetailsScreen(
      BuildContext context, List<Item> list, int index) async {
    await Navigator.pushNamed(
      context,
      ITEM_DETAILS_ROUTE,
      arguments: list[index],
    );
  }

  FloatingActionButton floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, ADD_ITEM_ROUTE),
      child: Icon(Icons.add_rounded, size: 26),
    );
  }

  AppBar appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text('Your notes'),
      centerTitle: true,
      actions: [
        UserPopupMenuButton(
          authRepository: authRepository,
        )
      ],
    );
  }
}
