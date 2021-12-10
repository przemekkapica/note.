import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/src/provider.dart';
import 'package:note/logic/bloc/add_item/add_item_bloc.dart';
import 'package:note/logic/bloc/add_item/add_item_event.dart';

List<FocusNode> useAddItem() {
  return use(const _UseAddItem());
}

class _UseAddItem extends Hook<List<FocusNode>> {
  const _UseAddItem();

  @override
  __UseAddItemState createState() => __UseAddItemState();
}

class __UseAddItemState extends HookState<List<FocusNode>, _UseAddItem> {
  final _nameFocusNode = FocusNode();
  final _noteFocusNode = FocusNode();
  final _urlFocusNode = FocusNode();

  @override
  void initHook() {
    super.initHook();
    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus) {
        context.read<AddItemBloc>().add(NameUnfocused());
      }
    });
    _noteFocusNode.addListener(() {
      if (!_noteFocusNode.hasFocus) {
        context.read<AddItemBloc>().add(NoteUnfocused());
      }
    });
    _urlFocusNode.addListener(() {
      if (!_urlFocusNode.hasFocus) {
        context.read<AddItemBloc>().add(UrlUnfocused());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _nameFocusNode.dispose();
    _noteFocusNode.dispose();
    _urlFocusNode.dispose();
  }

  @override
  List<FocusNode> build(BuildContext context) {
    return [_nameFocusNode, _urlFocusNode, _noteFocusNode];
  }
}
