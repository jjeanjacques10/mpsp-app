// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historic_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HistoricScreenStore on _HistoricScreenStoreBase, Store {
  Computed<List<ChatMessage>> _$getListChatsComputed;

  @override
  List<ChatMessage> get getListChats => (_$getListChatsComputed ??=
          Computed<List<ChatMessage>>(() => super.getListChats,
              name: '_HistoricScreenStoreBase.getListChats'))
      .value;

  final _$listChatsAtom = Atom(name: '_HistoricScreenStoreBase.listChats');

  @override
  ObservableList<ChatMessage> get listChats {
    _$listChatsAtom.reportRead();
    return super.listChats;
  }

  @override
  set listChats(ObservableList<ChatMessage> value) {
    _$listChatsAtom.reportWrite(value, super.listChats, () {
      super.listChats = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_HistoricScreenStoreBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$findAllCoursesAsyncAction =
      AsyncAction('_HistoricScreenStoreBase.findAllCourses');

  @override
  Future findAllCourses() {
    return _$findAllCoursesAsyncAction.run(() => super.findAllCourses());
  }

  @override
  String toString() {
    return '''
listChats: ${listChats},
isLoading: ${isLoading},
getListChats: ${getListChats}
    ''';
  }
}
