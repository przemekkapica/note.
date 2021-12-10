import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/logic/bloc/add_item/add_item_bloc.dart';
import 'package:note/logic/bloc/add_item/add_item_event.dart';
import 'package:note/logic/bloc/add_item/add_item_state.dart';

class NoteInput extends StatelessWidget {
  const NoteInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddItemBloc, AddItemState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.note.value,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          minLines: 1,
          maxLines: 10,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: 'Note',
            errorText: state.note.invalid ? 'Invalid note' : null,
          ),
          onChanged: (value) => _onChanged(context, value),
        );
      },
    );
  }

  void _onChanged(BuildContext context, String value) =>
      context.read<AddItemBloc>().add(NoteChanged(note: value));
}
