import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:note/data/model/entity/item.dart';
import 'package:note/data/repository/auth_repository.dart';
import 'package:note/view/widgets/info_dialog.dart';
import 'package:note/view/widgets/page_padding.dart';
import 'package:note/view/widgets/popup_menu_button.dart';

class DetailsScreen extends HookWidget {
  const DetailsScreen(
      {Key? key, required this.note, required this.authRepository})
      : super(key: key);

  final Item note;
  final AuthRepository authRepository;

  Future _launchUrl(BuildContext context) async {
    if (await canLaunch(note.url!)) {
      await launch(note.url!.trim());
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => InfoDialog(description: 'Provided url is not valid'),
      );
      throw 'Could not launch $note.url!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: PagePadding(
        child: Container(
          width: double.infinity,
          child: detailsCard(context),
        ),
      ),
    );
  }

  Card detailsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            itemDetailsHeader(context),
            displayDivider(),
            itemNote(context),
          ],
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.chevron_left),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text('Note details'),
      centerTitle: true,
      actions: [UserPopupMenuButton(authRepository: authRepository)],
    );
  }

  Widget itemNote(BuildContext context) {
    if (isNoteEmpty()) {
      return SizedBox(height: 5);
    }
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.note!,
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }

  Container itemDetailsHeader(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  note.name,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              IconButton(
                onPressed: () async => _launchUrl(context),
                icon: Icon(Icons.link_rounded),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            'Created on ' +
                DateFormat('yyyy MMM d | h:mma')
                    .format(note.created)
                    .toString(),
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }

  Widget displayDivider() {
    if (isNoteEmpty()) {
      return SizedBox.shrink();
    }
    return Column(
      children: [
        SizedBox(height: 6),
        Divider(color: Colors.grey),
        SizedBox(height: 6),
      ],
    );
  }

  bool isNoteEmpty() {
    return note.note == null || note.note!.trim() == '';
  }
}
