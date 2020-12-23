import 'package:sensor_app/models/sender_model.dart';
import 'package:sensor_app/services/api_services.dart';

const String _BASE_URL = 'http://10.0.2.2:3000';

class SenderService {
  Future<List<Sender>> getSenders() async {
    try {
      ApiService apiService = ApiService('$_BASE_URL/senders');
      List<dynamic> responseJson = await apiService.getData();
      List<Sender> senders =
          responseJson.map((sender) => Sender.fromJson(sender)).toList();
      return senders;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  // Future<void> createSender() async {
  //   try {
  //     ApiService apiService = ApiService('$_BASE_URL/senders');
  //     // final response = await apiService.
  //   } catch (error) {}
  // }
}
