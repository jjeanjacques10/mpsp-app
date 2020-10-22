import 'package:mobx/mobx.dart';
import 'package:mpsp_app/app/model/service.dart';
import 'package:mpsp_app/app/model/user.dart';
import 'package:mpsp_app/app/services/service_service.dart';
import 'package:mpsp_app/app/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'home_screen_store.g.dart';

class HomeScreenStore = _HomeScreenStoreBase with _$HomeScreenStore;

abstract class _HomeScreenStoreBase with Store {
  final ServiceService serviceService = ServiceService();
  List<ServiceModel> _listaServiceLocal = <ServiceModel>[];
  UserService userService = new UserService();

  _HomeScreenStoreBase() {
    init();
  }

  init() async {
    isLoading = true;

    //Name
    SharedPreferences item = await SharedPreferences.getInstance();
    var id = item.getString('id');
    nome = item.getString('name') != null ? item.getString('name') : '';

    //User
    user = await userService.findById(int.parse(id));

    //Service List
    _listaServiceLocal = await serviceService.findAll();
    listaService = _listaServiceLocal.asObservable();
    isLoading = false;
  }

  @observable
  String filtro = "";

  @observable
  ObservableList<ServiceModel> listaService = <ServiceModel>[].asObservable();

  @observable
  bool isLoading = false;

  @observable
  String nome = '';

  @observable
  UserModel user;

  @action
  findAllCourses() async {
    await init();
  }

  @action
  setFilter(value) {
    filtro = value;
  }

  @computed
  List<ServiceModel> get filtered {
    return listaService;
  }

  @computed
  int get quantidade {
    return listaService.length;
  }

  @computed
  String get name {
    if (nome != '') {
      return nome;
    }
    return '';
  }

  @computed
  UserModel get userModel {
    return user;
  }
}
