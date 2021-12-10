import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:note/logic/bloc/add_item/add_item_event.dart';
import 'package:note/logic/bloc/add_item/add_item_state.dart';
import 'package:note/data/model/entity/item.dart';
import 'package:note/data/model/formz/item/name.dart';
import 'package:note/data/model/formz/item/note.dart';
import 'package:note/data/model/formz/item/url.dart';
import 'package:note/data/repository/item_repository.dart';

class AddItemBloc extends Bloc<AddItemEvent, AddItemState> {
  AddItemBloc({required this.itemRepository}) : super(AddItemState());

  final ItemRepository itemRepository;

  @override
  Stream<AddItemState> mapEventToState(AddItemEvent event) async* {
    if (event is NameChanged) {
      final name = Name.dirty(event.name);
      yield state.copyWith(
        name: name.valid ? name : Name.pure(event.name),
        status: Formz.validate([name, state.note, state.url]),
      );
    } else if (event is NameUnfocused) {
      final name = Name.dirty(state.name.value);
      yield state.copyWith(
        name: name,
        status: Formz.validate([name, state.note, state.url]),
      );
    } else if (event is NoteChanged) {
      final note = Note.dirty(event.note);
      yield state.copyWith(
        note: note.valid ? note : Note.pure(event.note),
        status: Formz.validate([state.name, note, state.url]),
      );
    } else if (event is NoteUnfocused) {
      final note = Note.dirty(state.note.value);
      yield state.copyWith(
        note: note,
        status: Formz.validate([state.name, note, state.url]),
      );
    } else if (event is UrlChanged) {
      final url = Url.dirty(event.url);
      yield state.copyWith(
        url: url.valid ? url : Url.pure(event.url),
        status: Formz.validate([state.name, state.note, url]),
      );
    } else if (event is UrlUnfocused) {
      final url = Url.dirty(state.url.value);
      yield state.copyWith(
        url: url,
        status: Formz.validate([state.name, state.note, url]),
      );
    } else if (event is FormSubmitted) {
      final name = Name.dirty(state.name.value);
      final note = Note.dirty(state.note.value);
      final url = Url.dirty(state.url.value);

      yield state.copyWith(
        name: name,
        note: note,
        url: url,
        status: Formz.validate([name, note, url]),
      );

      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);
        try {
          Item item = Item(DateTime.now(), event.name, event.note, event.url);
          await itemRepository.addItem(item);

          yield state.copyWith(status: FormzStatus.submissionSuccess);
        } catch (err) {
          yield state.copyWith(
            errorMessage: err.toString(),
            status: FormzStatus.submissionFailure,
          );
        }
      }
    }
  }
}
