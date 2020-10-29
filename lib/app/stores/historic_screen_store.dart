import 'package:mobx/mobx.dart';
import 'package:mpsp_app/app/model/chat_message.dart';
import 'package:mpsp_app/app/services/chat_message_service.dart';
part 'historic_screen_store.g.dart';

class HistoricScreenStore = _HistoricScreenStoreBase with _$HistoricScreenStore;

abstract class _HistoricScreenStoreBase with Store {
  List<ChatMessage> _listChatsLocal = <ChatMessage>[];

  ChatMessageService chatMessageService = ChatMessageService();

  _HistoricScreenStoreBase() {
    init();
  }

  init() async {
    isLoading = true;

    //Service List
    _listChatsLocal = await chatMessageService.findAll(limit: 50);
    listChats = _listChatsLocal.asObservable();
    isLoading = false;
  }

  @observable
  ObservableList<ChatMessage> listChats = <ChatMessage>[].asObservable();

  @observable
  bool isLoading = false;

  @action
  findAllCourses() async {
    await init();
  }

  @computed
  List<ChatMessage> get getListChats {
    return listChats;
  }
}
