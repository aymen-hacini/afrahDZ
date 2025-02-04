import 'package:get_storage/get_storage.dart';

String? getToken() {
  final GetStorage storage = GetStorage();

  return storage.read('token'); // Retrieve the token from GetStorage
}
