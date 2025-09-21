class Tarla {
  int? tarlaID;
  String tarlaAdi;
  String ekiliMahsul;
  int donum;
  String resimAdresi;
  String eklemeTarihi;
  double toplamMasraf; // Toplam masraf alanı

  Tarla({
    required this.tarlaAdi,
    required this.ekiliMahsul,
    required this.donum,
    required this.resimAdresi,
    required this.eklemeTarihi,
    this.toplamMasraf = 0.0, // Varsayılan değer
  });

  // With ID Constructor
  Tarla.withID({
    this.tarlaID,
    required this.tarlaAdi,
    required this.ekiliMahsul,
    required this.donum,
    required this.resimAdresi,
    required this.eklemeTarihi,
    this.toplamMasraf = 0.0, // Toplam masrafı da ekle
  });

  factory Tarla.fromMap(Map<String, dynamic> map) {
    return Tarla.withID(
      tarlaID: map['tarlaID'],
      tarlaAdi: map['tarlaAdi'] as String,
      ekiliMahsul: map['ekiliMahsul'] as String,
      donum: map['donum'] as int,
      resimAdresi: map['resimAdresi'] as String,
      eklemeTarihi: map['eklemeTarihi'].toString(),
      toplamMasraf: map['toplamMasraf'] ?? 0.0, // Toplam masrafı ekle
    );
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["tarlaAdi"] = tarlaAdi;
    map["ekiliMahsul"] = ekiliMahsul;
    map["donum"] = donum;
    map["resimAdresi"] = resimAdresi;
    map["eklemeTarihi"] = eklemeTarihi;
    map["toplamMasraf"] = toplamMasraf;
    if (tarlaID != null) map["tarlaID"] = tarlaID;

    return map;
  }
}
