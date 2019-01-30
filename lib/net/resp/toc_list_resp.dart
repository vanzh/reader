import 'dart:convert' show json;

class TocListResp {

  List<Toc> list;

  TocListResp.fromParams({this.list});

  factory TocListResp(jsonStr) => jsonStr == null ? null : jsonStr is String ? new TocListResp.fromJson(json.decode(jsonStr)) : new TocListResp.fromJson(jsonStr);

  TocListResp.fromJson(jsonRes) {
    list = jsonRes == null ? null : [];

    for (var listItem in list == null ? [] : jsonRes){
      list.add(listItem == null ? null : new Toc.fromJson(listItem));
    }
  }

  @override
  String toString() {
    return '{"json_list": $list}';
  }
}

class Toc {

  int chaptersCount;
  bool isCharge;
  bool starting;
  String id;
  String host;
  String lastChapter;
  String link;
  String name;
  String source;
  String updated;

  Toc.fromParams({this.chaptersCount, this.isCharge, this.starting, this.id, this.host, this.lastChapter, this.link, this.name, this.source, this.updated});

  Toc.fromJson(jsonRes) {
    chaptersCount = jsonRes['chaptersCount'];
    isCharge = jsonRes['isCharge'];
    starting = jsonRes['starting'];
    id = jsonRes['_id'];
    host = jsonRes['host'];
    lastChapter = jsonRes['lastChapter'];
    link = jsonRes['link'];
    name = jsonRes['name'];
    source = jsonRes['source'];
    updated = jsonRes['updated'];
  }

  @override
  String toString() {
    return '{"chaptersCount": $chaptersCount,"isCharge": $isCharge,"starting": $starting,"_id": ${id != null?'${json.encode(id)}':'null'},"host": ${host != null?'${json.encode(host)}':'null'},"lastChapter": ${lastChapter != null?'${json.encode(lastChapter)}':'null'},"link": ${link != null?'${json.encode(link)}':'null'},"name": ${name != null?'${json.encode(name)}':'null'},"source": ${source != null?'${json.encode(source)}':'null'},"updated": ${updated != null?'${json.encode(updated)}':'null'}}';
  }
}

