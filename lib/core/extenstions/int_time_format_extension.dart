import 'package:easy_localization/easy_localization.dart';

extension formatDateFromTimeStamp on int {
 String get toFormattedTime {
DateTime date = new DateTime.fromMillisecondsSinceEpoch(this);
String formattedString = DateFormat('MM/dd/yyyy').format(date);
return formattedString;
 }
}
