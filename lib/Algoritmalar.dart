import 'package:HasatDefteri/data/dbHelper.dart';
import 'constObjects.dart';

var tImage=TarlaImages();
class TarlaImageGenerator{
  static String imageAdress(int? id){
    if(id!=null) {
      int idLeftNum = id % 10;
      if (idLeftNum == 1 || idLeftNum == 6)
        return tImage.tarlaImage1;
      else if (idLeftNum == 2 || idLeftNum == 7)
        return tImage.tarlaImage2;
      else if (idLeftNum == 3 || idLeftNum == 8)
        return tImage.tarlaImage3;
      else if (idLeftNum == 4 || idLeftNum == 9)
        return tImage.tarlaImage4;
      else if (idLeftNum == 5 || idLeftNum == 0)
        return tImage.tarlaImage5;
    }
    return tImage.tarlaImage1;
  }
}