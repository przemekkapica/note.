import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:formz/formz.dart';
import 'package:note/logic/bloc/add_item/add_item_bloc.dart';
import 'package:note/logic/bloc/add_item/add_item_state.dart';
import 'package:note/data/repository/auth_repository.dart';
import 'package:note/utils/constants.dart';
import 'package:note/logic/hooks/add_item_hook.dart';
import 'package:note/view/widgets/info_dialog.dart';
import 'package:note/view/widgets/buttons/add_item_button.dart';
import 'package:note/view/widgets/inputs/name_input.dart';
import 'package:note/view/widgets/inputs/note_input.dart';
import 'package:note/view/widgets/inputs/url_input.dart';
import 'package:note/view/widgets/page_padding.dart';
import 'package:note/view/widgets/popup_menu_button.dart';

class AddItemScreen extends HookWidget {
  AddItemScreen({Key? key, required this.authRepository}) : super(key: key);

  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    final addItem = useAddItem();

    return Scaffold(
      appBar: appBar(context),
      body: BlocListener<AddItemBloc, AddItemState>(
        listener: (context, blocState) async {
          if (blocState.status.isSubmissionSuccess) {
            await navigateToHomeScreen(context);
          }
          if (blocState.status.isSubmissionInProgress) {
            showProgressIndicator(context);
          }
          if (blocState.status.isSubmissionFailure) {
            showInfoDialog(context, blocState);
          }
        },
        child: blocBuilder(addItem),
      ),
    );
  }

  void showInfoDialog(BuildContext context, AddItemState blocState) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => InfoDialog(description: blocState.errorMessage),
    );
  }

  void showProgressIndicator(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  BlocBuilder<AddItemBloc, AddItemState> blocBuilder(List<FocusNode> addItem) {
    return BlocBuilder<AddItemBloc, AddItemState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, blocState) {
        return PagePadding(
          child: addItemFormCard(context, addItem),
        );
      },
    );
  }

  Card addItemFormCard(BuildContext context, List<FocusNode> addItem) {
    return Card(
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: addItemFormFields(addItem),
            ),
          ),
        ),
      ),
    );
  }

  Column addItemFormFields(List<FocusNode> addItem) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        NameInput(focusNode: addItem[0]),
        SizedBox(height: 10),
        UrlInput(focusNode: addItem[1]),
        SizedBox(height: 10),
        NoteInput(focusNode: addItem[2]),
        SizedBox(height: 35),
        AddItemButton(),
      ],
    );
  }

  Future navigateToHomeScreen(BuildContext context) async =>
      await Navigator.pushNamed(context, HOME_ROUTE);

  AppBar appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.chevron_left),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text('Adding new note'),
      centerTitle: true,
      actions: [UserPopupMenuButton(authRepository: authRepository)],
    );
  }
}
