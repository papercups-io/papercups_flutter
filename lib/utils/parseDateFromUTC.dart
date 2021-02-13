DateTime parseDateFromUTC(String time){
  DateTime processed;

  if (DateTime.tryParse(time) != null){
    if(time.endsWith("Z")){
      processed = DateTime.parse(time).toLocal();
    }else{
      DateTime.parse(time + "Z").toLocal();
    }
  }

  return processed;
}