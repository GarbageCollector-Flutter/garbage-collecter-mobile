import 'package:easy_localization/easy_localization.dart';

// ignore: camel_case_extensions
extension formatDateFromTimeStamp on int {
 String get toFormattedTime {
// ignore: unnecessary_new
DateTime date = new DateTime.fromMillisecondsSinceEpoch(this);
String formattedString = DateFormat('MM/dd/yyyy').format(date);
return formattedString;
 }
}
