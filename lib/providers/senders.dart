import 'package:flutter/foundation.dart';
import 'package:sensor_app/models/sender_model.dart';
import 'package:sensor_app/services/sender_service.dart';

enum SenderState { initial, loading, loaded }

class Senders with ChangeNotifier {
  SenderService senderService = SenderService();

  // Sender State
  // SenderState _state = SenderState.initial;
  // SenderState get state => _state;

  // void _setState(SenderState state) {
  //   _state = state;
  //   notifyListeners();
  // }

  // //Error Handle
  // Failure _failure;
  // Failure get failure => _failure;

  // void _setFailure(Failure failure) {
  //   _failure = failure;
  //   notifyListeners();
  // }

  List<Sender> _senders = [];

  List<Sender> get senders {
    return [..._senders];
  }

  int get senderCount {
    return _senders.length;
  }

  Sender findById(int id) {
    return _senders.firstWhere((element) => element.id == id);
  }

  int findLastId() {
    Sender sender = _senders.last;
    return sender.id;
  }

  Future<void> fetchSenders() async {
    // _setState(SenderState.loading);
    try {
      List<Sender> fetchedSenders = await senderService.getSenders();
      _senders = fetchedSenders;
      notifyListeners();
    } catch (error) {
      // _setFailure(error);
      throw Exception(error.toString());
    }
    // _setState(SenderState.loaded);
  }

  Future<bool> createSender(String name, String location) async {
    int newId = findLastId() + 1;
    List locationList = location.split(' ');
    final coordinat = Coordinat(
      lat: double.parse(locationList[0]),
      lon: double.parse(locationList[1]),
    );
    final newSender = Sender(
      id: newId,
      name: name,
      status: 0,
      coord: coordinat,
      lastActive: DateTime.now(),
    );
    _senders.add(newSender);
    notifyListeners();
    return true;
  }

  void deleteSender(int id) {
    _senders.removeWhere((sender) => sender.id == id);
    notifyListeners();
  }
}
