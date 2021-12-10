import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:note/data/model/formz/item/name.dart';
import 'package:note/data/model/formz/item/note.dart';
import 'package:note/data/model/formz/item/url.dart';

class AddItemState extends Equatable {
  const AddItemState({
    this.name = const Name.pure(),
    this.note = const Note.pure(),
    this.url = const Url.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage = '',
  });

  final Name name;
  final Note note;
  final Url url;
  final FormzStatus status;
  final String errorMessage;

  AddItemState copyWith(
      {Name? name,
      Note? note,
      Url? url,
      FormzStatus? status,
      String? errorMessage}) {
    return AddItemState(
      name: name ?? this.name,
      note: note ?? this.note,
      url: url ?? this.url,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [name, note, url, status, errorMessage];
}
