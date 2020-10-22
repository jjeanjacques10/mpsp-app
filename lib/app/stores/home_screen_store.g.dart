// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeScreenStore on _HomeScreenStoreBase, Store {
  Computed<List<ServiceModel>> _$filteredComputed;

  @override
  List<ServiceModel> get filtered =>
      (_$filteredComputed ??= Computed<List<ServiceModel>>(() => super.filtered,
              name: '_HomeScreenStoreBase.filtered'))
          .value;
  Computed<int> _$quantidadeComputed;

  @override
  int get quantidade =>
      (_$quantidadeComputed ??= Computed<int>(() => super.quantidade,
              name: '_HomeScreenStoreBase.quantidade'))
          .value;
  Computed<String> _$nameComputed;

  @override
  String get name => (_$nameComputed ??=
          Computed<String>(() => super.name, name: '_HomeScreenStoreBase.name'))
      .value;
  Computed<UserModel> _$userModelComputed;

  @override
  UserModel get userModel =>
      (_$userModelComputed ??= Computed<UserModel>(() => super.userModel,
              name: '_HomeScreenStoreBase.userModel'))
          .value;

  final _$filtroAtom = Atom(name: '_HomeScreenStoreBase.filtro');

  @override
  String get filtro {
    _$filtroAtom.reportRead();
    return super.filtro;
  }

  @override
  set filtro(String value) {
    _$filtroAtom.reportWrite(value, super.filtro, () {
      super.filtro = value;
    });
  }

  final _$listaServiceAtom = Atom(name: '_HomeScreenStoreBase.listaService');

  @override
  ObservableList<ServiceModel> get listaService {
    _$listaServiceAtom.reportRead();
    return super.listaService;
  }

  @override
  set listaService(ObservableList<ServiceModel> value) {
    _$listaServiceAtom.reportWrite(value, super.listaService, () {
      super.listaService = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_HomeScreenStoreBase.isLoading');

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

  final _$nomeAtom = Atom(name: '_HomeScreenStoreBase.nome');

  @override
  String get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  final _$userAtom = Atom(name: '_HomeScreenStoreBase.user');

  @override
  UserModel get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$findAllCoursesAsyncAction =
      AsyncAction('_HomeScreenStoreBase.findAllCourses');

  @override
  Future findAllCourses() {
    return _$findAllCoursesAsyncAction.run(() => super.findAllCourses());
  }

  final _$_HomeScreenStoreBaseActionController =
      ActionController(name: '_HomeScreenStoreBase');

  @override
  dynamic setFilter(dynamic value) {
    final _$actionInfo = _$_HomeScreenStoreBaseActionController.startAction(
        name: '_HomeScreenStoreBase.setFilter');
    try {
      return super.setFilter(value);
    } finally {
      _$_HomeScreenStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filtro: ${filtro},
listaService: ${listaService},
isLoading: ${isLoading},
nome: ${nome},
user: ${user},
filtered: ${filtered},
quantidade: ${quantidade},
name: ${name},
userModel: ${userModel}
    ''';
  }
}
