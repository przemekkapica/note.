import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/logic/bloc/add_item/add_item_bloc.dart';
import 'package:note/logic/bloc/add_item/add_item_event.dart';
import 'package:note/logic/bloc/add_item/add_item_state.dart';

class NameInput extends StatelessWidget {
  const NameInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddItemBloc, AddItemState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.name.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: 'Name',
            errorText: state.name.invalid ? 'Name cannot be empty' : null,
          ),
          keyboardType: TextInputType.text,
          onChanged: (value) => _onChanged(context, value),
          textInputAction: TextInputAction.next,
        );
      },
    );
  }

  void _onChanged(BuildContext context, String value) =>
      context.read<AddItemBloc>().add(NameChanged(name: value));
}
