import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:note/logic/bloc/add_item/add_item_bloc.dart';
import 'package:note/logic/bloc/add_item/add_item_event.dart';
import 'package:note/logic/bloc/add_item/add_item_state.dart';

class AddItemButton extends StatelessWidget {
  const AddItemButton({Key? key}) : super(key: key);

  _addItem(BuildContext context) {
    final String name = context.read<AddItemBloc>().state.name.value;
    final String note = context.read<AddItemBloc>().state.note.value;
    final String url = context.read<AddItemBloc>().state.url.value;

    context
        .read<AddItemBloc>()
        .add(FormSubmitted(name: name, note: note, url: url));
  }

  @override
  Widget build(BuildContext context2) {
    return Container(
      width: double.infinity,
      child: BlocBuilder<AddItemBloc, AddItemState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, blocState) {
          return ElevatedButton(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                  Theme.of(context).textTheme.subtitle1),
            ),
            onPressed:
                blocState.status.isValidated ? () => _addItem(context2) : null,
            child: Text('Add note'),
          );
        },
      ),
    );
  }
}
