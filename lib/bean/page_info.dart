
//阅读界面的所有信息
class PageInfo {
  int indexPage;

  List<String> lineTexts =[];
  ReadingSetting readingSetting;
  PageInfo();
}

//阅读进度
class ReadingProgress{

}

class ReadingSetting{
  int fortSize;
  int maxRow =20;
  int maxWord=18;
  int color;

  ReadingSetting({this.fortSize, this.maxRow, this.maxWord, this.color});

}