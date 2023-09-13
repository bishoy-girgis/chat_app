import 'package:intl/intl.dart';

formatMessageDate(int messageDate){
  DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(messageDate);
  DateFormat dateFormat = DateFormat('h:mm a');
  return dateFormat.format(dateTime);
}