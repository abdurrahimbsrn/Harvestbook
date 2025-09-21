class Masraf {
  int? masrafID;
  String masrafAdi;
  String aciklama;
  String eklemeTarihi;
  double ucret;


  Masraf({
    required this.masrafAdi,
    required this.aciklama,
    required this.eklemeTarihi,
    required this.ucret,
  });

  Masraf.withID({
    this.masrafID,
    required this.masrafAdi,
    required this.aciklama,
    required this.eklemeTarihi,
    required this.ucret,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["masrafAdi"] = masrafAdi;
    map["aciklama"] = aciklama;
    map["eklemeTarihi"] = eklemeTarihi;
    map["ucret"] = ucret;
    if (masrafID != null) map["masrafID"] = masrafID;

    return map;
  }
}
