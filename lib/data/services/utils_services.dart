import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class UtilsService {
  final storage = const FlutterSecureStorage();

  //Valor moeda
  String priceToCurrencyString(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_PT');
    return numberFormat.format(price);
  }

  //Date formatter
  String formatDateTime(DateTime dateTime) {
    initializeDateFormatting();

    final DateFormat dateFormat = DateFormat.yMd('pt_BR').add_Hm();
    return dateFormat.format(dateTime);
  }

  //Storage Local Data
  Future<void> saveLocalData({
    required String key,
    required String data,
  }) async {
    await storage.write(key: key, value: data);
  }

  //Write Local Data
  Future<String?> getLocalData({required String key}) async {
    return await storage.read(key: key);
  }

  //Remove Storaged Local Data
  Future<void> removeLocalData({required String key}) async {
    return await storage.delete(key: key);
  }
}
