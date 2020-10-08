import 'package:mobx/mobx.dart';
import 'package:mpsp_app/app/model/service.dart';
import 'package:mpsp_app/app/services/service_service.dart';
part 'home_screen_store.g.dart';

class HomeScreenStore = _HomeScreenStoreBase with _$HomeScreenStore;

abstract class _HomeScreenStoreBase with Store {
  final ServiceService serviceService = ServiceService();
  List<ServiceModel> _listaPartnerLocal = <ServiceModel>[];

  _HomeScreenStoreBase() {
    init();
  }

  init() async {
    isLoading = true;
    _listaPartnerLocal = await serviceService.findAll();
    listaPartner = _listaPartnerLocal.asObservable();
    isLoading = false;
  }

  @observable
  String filtro = "";

  @observable
  ObservableList<ServiceModel> listaPartner = <ServiceModel>[].asObservable();

  @observable
  bool isLoading = false;

  @action
  findAllCourses() async {
    init();
  }

  @action
  setFilter(value) {
    filtro = value;
  }

  @computed
  List<ServiceModel> get filtered {
    if (filtro.isEmpty) {
      return listaPartner;
    } else {
      var lista = listaPartner
          .where((partner) => partner.nameServise.toLowerCase().contains(
                filtro.toLowerCase(),
              ))
          .toList();
      return lista;
    }
  }

  @computed
  int get quantidade {
    return listaPartner.length;
  }
}
