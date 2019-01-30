
class DateUtil{
  static String toNow(String dataStr){
    DateTime time;
    try {
       time = DateTime.parse(dataStr);
    }
    catch(e){
      print(e.toString());
    }
    Duration duration = DateTime.now().difference(time);
    if(duration.inDays >0){
      return duration.inDays.toString()+"天前";
    }
    if(duration.inHours>0){
      return duration.inHours.toString()+"小时前";
    }
    if(duration.inMinutes>0){
      return duration.inMinutes.toString()+"分钟前";
    }
    return "刚刚";
  }
}