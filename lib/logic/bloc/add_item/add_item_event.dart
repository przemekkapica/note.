import 'package:equatable/equatable.dart';

abstract class AddItemEvent extends Equatable {
  const AddItemEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends AddItemEvent {
  const NameChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class NameUnfocused extends AddItemEvent {}

class NoteChanged extends AddItemEvent {
  const NoteChanged({required this.note});

  final String note;

  @override
  List<Object> get props => [note];
}

class NoteUnfocused extends AddItemEvent {}

class UrlChanged extends AddItemEvent {
  const UrlChanged({required this.url});

  final String url;

  @override
  List<Object> get props => [url];
}

class UrlUnfocused extends AddItemEvent {}

class FormSubmitted extends AddItemEvent {
  const FormSubmitted(
      {required this.name, required this.note, required this.url});

  final String name;
  final String note;
  final String url;

  @override
  List<Object> get props => [name, note, url];
}
