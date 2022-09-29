import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class UtilsService {
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
}
