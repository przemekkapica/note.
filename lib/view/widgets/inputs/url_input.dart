import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/logic/bloc/add_item/add_item_bloc.dart';
import 'package:note/logic/bloc/add_item/add_item_event.dart';
import 'package:note/logic/bloc/add_item/add_item_state.dart';

class UrlInput extends StatelessWidget {
  const UrlInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddItemBloc, AddItemState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.url.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: 'Url',
            errorText: state.url.invalid ? 'Invalid url' : null,
          ),
          keyboardType: TextInputType.url,
          onChanged: (value) => _onChanged(context, value),
          textInputAction: TextInputAction.done,
        );
      },
    );
  }

  void _onChanged(BuildContext context, String value) =>
      context.read<AddItemBloc>().add(UrlChanged(url: value));
}
