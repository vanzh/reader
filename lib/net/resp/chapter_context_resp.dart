import 'dart:convert' show json;

class ChapterContextResp {

  bool ok;
  ChapterContext chapter;

  ChapterContextResp.fromParams({this.ok, this.chapter});

  factory ChapterContextResp(jsonStr) => jsonStr == null ? null : jsonStr is String ? new ChapterContextResp.fromJson(json.decode(jsonStr)) : new ChapterContextResp.fromJson(jsonStr);

  ChapterContextResp.fromJson(jsonRes) {
    ok = jsonRes['ok'];
    chapter = jsonRes['chapter'] == null ? null : new ChapterContext.fromJson(jsonRes['chapter']);
  }

  @override
  String toString() {
    return '{"ok": $ok,"chapter": $chapter}';
  }
}

class ChapterContext {

  int currency;
  int order;
  bool isVip;
  String body;
  String cpContent;
  String created;
  String id;
  String title;
  String updated;

  ChapterContext.fromParams({this.currency, this.order, this.isVip, this.body, this.cpContent, this.created, this.id, this.title, this.updated});

  ChapterContext.fromJson(jsonRes) {
    currency = jsonRes['currency'];
    order = jsonRes['order'];
    isVip = jsonRes['isVip'];
    body = jsonRes['body'];
    cpContent = jsonRes['cpContent'];
    created = jsonRes['created'];
    id = jsonRes['id'];
    title = jsonRes['title'];
    updated = jsonRes['updated'];
  }

  @override
  String toString() {
    return '{"currency": $currency,"order": $order,"isVip": $isVip,"body": ${body != null?'${json.encode(body)}':'null'},"cpContent": ${cpContent != null?'${json.encode(cpContent)}':'null'},"created": ${created != null?'${json.encode(created)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"updated": ${updated != null?'${json.encode(updated)}':'null'}}';
  }
}

