class DateTimeHelper {
  static int nowTimestamp() {
    DateTime datetime = DateTime.now();
    return (datetime.toLocal().millisecondsSinceEpoch / 1000).floor();
  }

  static DateTime createFromTimestamp(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  static DateTime? createFromString(String datetime) {
    return DateTime.tryParse(datetime);
  }

  static String convertToString(DateTime datetime, {String format = 'd/m/y h:i:s'}) {
    String day = datetime.day.toString().padLeft(2, '0');
    String month = datetime.month.toString().padLeft(2, '0');
    String year = datetime.year.toString();
    String hour = datetime.hour.toString().padLeft(2, '0');
    String minute = datetime.minute.toString().padLeft(2, '0');
    String second = datetime.second.toString().padLeft(2, '0');

    String formattedDateTime =
        format.replaceAll('d', day).replaceAll('m', month).replaceAll('y', year).replaceAll('h', hour).replaceAll('i', minute).replaceAll('s', second);

    return formattedDateTime;
  }

  static String fromTimestampToString(int timestamp, {String format = 'd/m/y h:i:s'}) {
    return DateTimeHelper.convertToString(DateTimeHelper.createFromTimestamp(timestamp), format: format);
  }

  static int fromStringToTimestamp(String datetime) {
    DateTime? obj = DateTimeHelper.createFromString(datetime);
    if(obj == null) {
      return 0;
    }

    return (obj.millisecondsSinceEpoch / 1000).floor();
  }
}
