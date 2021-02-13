DateTime parseDateFromUTC(String time) {
  DateTime processed;

  if (DateTime.tryParse(time) != null) {
    if (time.endsWith("Z")) {
      processed = DateTime.tryParse(time);
    } else {
      processed = DateTime.tryParse(time + "Z");
    }
  }

  if (processed != null) processed = processed.toLocal();

  return processed;
}
