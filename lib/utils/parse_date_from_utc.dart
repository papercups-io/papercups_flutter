/// This function converts a sting in ISO8601 format into a DateTime object which is in UTC
/// and then converts in into the local timezone. Used to convert times from the Papercups API.
/// It assumes all times provided are in UTC or it will force them bo be.
DateTime? parseDateFromUTC(String? time) {
  if (time == null) {
    return null;
  }

  DateTime? processed;

  if (DateTime.tryParse(time) != null) {
    if (time.endsWith("Z") || !time.contains(":")) {
      processed = DateTime.tryParse(time);
    } else {
      processed = DateTime.tryParse("${time}Z");
    }
  }

  processed = processed?.toLocal();

  return processed;
}
